class RedmineMcpServer < Formula
  desc "Standalone stdio MCP server for Redmine"
  homepage "https://github.com/weirdo-adam/redmine-mcp-server"
  url "https://github.com/weirdo-adam/redmine-mcp-server/releases/download/v0.1.0/" \
      "redmine-mcp-server-0.1.0.tar.gz"
  sha256 "60046aeff9b7c4bddfe8dcf578eb82fccb8944fe2cbc83a19906b5a6b56a2064"
  license "MIT"

  bottle do
    root_url "https://github.com/weirdo-adam/homebrew-tap/releases/download/redmine-mcp-server-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "f7a69fa7e877db9f4fa73b774f50ba9c88d8ffd73c99fc763f2a6d6b5f5825ff"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    doc.install "README.md", "README.zh-CN.md"
    doc.install Dir["docs/*.md"]
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
        #{doc}/client-configuration.md
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
