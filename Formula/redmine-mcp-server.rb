class RedmineMcpServer < Formula
  desc "Standalone stdio MCP server for Redmine"
  homepage "https://github.com/weirdo-adam/redmine-mcp-server"
  url "https://github.com/weirdo-adam/redmine-mcp-server/releases/download/v0.1.0/" \
      "redmine-mcp-server-0.1.0.tar.gz"
  sha256 "76dcff6ca952a4a98d94846345d3be093e32ce6b3a91b0cd68da1673fbac4004"
  license "MIT"

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
