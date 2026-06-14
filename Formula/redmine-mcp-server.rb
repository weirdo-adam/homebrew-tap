class RedmineMcpServer < Formula
  desc "Standalone stdio MCP server for Redmine"
  homepage "https://github.com/weirdo-adam/redmine-mcp-server"
  url "https://github.com/weirdo-adam/redmine-mcp-server/releases/download/v0.2.0/" \
      "redmine-mcp-server-0.2.0.tar.gz"
  sha256 "4187593a24c049fe26effb5b5d390e58ed07f7a7f28058e177a4cf27d1c1d223"
  license "MIT"

  bottle do
    root_url "https://github.com/weirdo-adam/homebrew-tap/releases/download/redmine-mcp-server-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5cf939238013f7e8eed562e5bdddcde247f381b06c7c2a0581e94e6615cf5563"
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
