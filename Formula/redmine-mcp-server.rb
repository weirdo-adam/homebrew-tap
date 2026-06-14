class RedmineMcpServer < Formula
  desc "Standalone stdio MCP server for Redmine"
  homepage "https://github.com/weirdo-adam/redmine-mcp-server"
  url "https://github.com/weirdo-adam/redmine-mcp-server/releases/download/v0.1.1/" \
      "redmine-mcp-server-0.1.1.tar.gz"
  sha256 "04656df03d6584fa7209e45c6b308e258934386a4d3b090f8d87c08d2655a19c"
  license "MIT"

  bottle do
    root_url "https://github.com/weirdo-adam/homebrew-tap/releases/download/redmine-mcp-server-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "9b5b0693caa766e5d0dad4e09a207f8a3eda59a157c68deb0b012c8036b99ed5"
  end

  depends_on "node"

  def install
    libexec.install "package.json", "server", "docs", "README.md", "README.zh-CN.md", "LICENSE"
    (bin/"redmine-mcp-server").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/server/index.js" "$@"
    SH
    chmod 0755, bin/"redmine-mcp-server"
  end

  def caveats
    <<~EOS
      Configure your MCP client to run:
        #{opt_bin}/redmine-mcp-server

      Required Redmine environment variables:
        REDMINE_BASE_URL=https://redmine.example.com
        REDMINE_API_KEY=your-api-key
        REDMINE_MCP_READ_ONLY=true

      If redmine-mcp-server is not found in a new shell, add Homebrew to PATH:
        eval "$(#{HOMEBREW_PREFIX}/bin/brew shellenv)"

      Full client examples:
        #{opt_libexec}/docs/client-configuration.md
    EOS
  end

  test do
    ENV["REDMINE_BASE_URL"] = "https://redmine.example.com"
    ENV["REDMINE_API_KEY"] = "test"

    input = <<~JSON
      {"jsonrpc":"2.0","id":1,"method":"initialize"}
    JSON

    assert_match "\"serverInfo\"", pipe_output("#{bin}/redmine-mcp-server", input)
  end
end
