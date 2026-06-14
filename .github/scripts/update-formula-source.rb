#!/usr/bin/env ruby
# frozen_string_literal: true

formula = ARGV.fetch(0)
source_url = ARGV.fetch(1)
source_sha256 = ARGV.fetch(2)

unless source_sha256.match?(/\A[0-9a-f]{64}\z/)
  abort "source_sha256 must be a lowercase 64-character SHA-256 digest"
end

formula_path = File.join("Formula", "#{formula}.rb")
abort "Formula not found: #{formula_path}" unless File.file?(formula_path)

filename = File.basename(source_url)
base_url = source_url.delete_suffix(filename)
url_block = if base_url.empty? || filename == source_url
              %(  url "#{source_url}")
            else
              %(  url "#{base_url}" \\\n      "#{filename}")
            end

if formula == "redmine-mcp-server"
  File.write(formula_path, <<~RUBY)
    class RedmineMcpServer < Formula
      desc "Standalone stdio MCP server for Redmine"
      homepage "https://github.com/weirdo-adam/redmine-mcp-server"
    #{url_block}
      sha256 "#{source_sha256}"
      license "MIT"

      depends_on "rust" => :build

      def install
        system "cargo", "install", *std_cargo_args
        doc.install "README.md", "README.zh-CN.md"
        doc.install Dir["docs/*.md"]
      end

      def caveats
        <<~EOS
          Configure your MCP client to run:
            \#{opt_bin}/redmine-mcp-server

          Required Redmine environment variables:
            REDMINE_BASE_URL=https://redmine.example.com
            REDMINE_API_KEY=your-api-key
            REDMINE_MCP_READ_ONLY=true

          If redmine-mcp-server is not found in a new shell, add Homebrew to PATH:
            eval "$(\#{HOMEBREW_PREFIX}/bin/brew shellenv)"

          Full client examples:
            \#{doc}/client-configuration.md
        EOS
      end

      test do
        ENV["REDMINE_BASE_URL"] = "https://redmine.example.com"
        ENV["REDMINE_API_KEY"] = "test"

        input = <<~JSON
          {"jsonrpc":"2.0","id":1,"method":"initialize"}
        JSON

        assert_match "\\"serverInfo\\"", pipe_output("\#{bin}/redmine-mcp-server", input)
      end
    end
  RUBY
  exit
end

formula_text = File.read(formula_path)
formula_text = formula_text.sub(/\n  bottle do\n(?:    .*\n)*  end\n\n?/, "\n")

source_pattern = /^  url ".*?"(?: \\\n\s+".*?")?\n  sha256 "[0-9a-fA-F]{64}"/m
git_source_pattern = /^  url ".*?\.git",\n\s+tag:\s+".*?",\n\s+revision:\s+".*?"/m
replacement = %(#{url_block}\n  sha256 "#{source_sha256}")

unless formula_text.sub!(source_pattern, replacement) || formula_text.sub!(git_source_pattern, replacement)
  abort "Unable to update source URL and sha256 in #{formula_path}"
end

File.write(formula_path, formula_text)
