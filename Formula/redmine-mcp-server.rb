class RedmineMcpServer < Formula
  desc "Standalone stdio MCP server for Redmine"
  homepage "https://github.com/weirdo-adam/redmine-mcp-server"
  url "https://github.com/weirdo-adam/redmine-mcp-server/releases/download/v0.1.0/" \
      "redmine-mcp-server-0.1.0.tar.gz"
  sha256 "76dcff6ca952a4a98d94846345d3be093e32ce6b3a91b0cd68da1673fbac4004"
  license "MIT"

  bottle do
    root_url "https://github.com/weirdo-adam/homebrew-tap/releases/download/redmine-mcp-server-0.1.1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "2a7ce1aed660266f4ea3584ae153571c8e4b704ae7745a1d41141f643c476449"
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

  test do
    ENV["REDMINE_BASE_URL"] = "https://redmine.example.com"
    ENV["REDMINE_API_KEY"] = "test"

    input = <<~JSON
      {"jsonrpc":"2.0","id":1,"method":"initialize"}
    JSON

    assert_match "\"serverInfo\"", pipe_output("#{bin}/redmine-mcp-server", input)
  end
end
