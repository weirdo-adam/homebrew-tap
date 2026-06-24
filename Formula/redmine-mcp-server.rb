class RedmineMcpServer < Formula
  desc "Standalone stdio MCP server for Redmine"
  homepage "https://github.com/weirdo-adam/redmine-mcp-server"
  url "https://github.com/weirdo-adam/redmine-mcp-server/releases/download/v0.1.1/" \
      "redmine-mcp-server-0.1.1.tar.gz"
  sha256 "3d0cc3b554ff303d0e4f8e26a08f2ad0e30bae7928a405b99900c2194912643f"
  license "MIT"

  bottle do
    root_url "https://github.com/weirdo-adam/homebrew-tap/releases/download/redmine-mcp-server-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "22ee5569729b871f40b164128a7835781f8882a998ad38ce4f1a38237a63b8d6"
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
