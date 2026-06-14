class IssueJumper < Formula
  desc "Jump from the current Git branch to its issue page"
  homepage "https://github.com/weirdo-adam/issue-jumper"
  url "https://github.com/weirdo-adam/issue-jumper/archive/refs/tags/" \
      "v0.1.1.tar.gz"
  sha256 "3b18bc204c130ade847336962e1804edfde289b14819b8c7d9c413c3400d2590"
  license "MIT"
  head "https://github.com/weirdo-adam/issue-jumper.git", branch: "main"

  bottle do
    root_url "https://github.com/weirdo-adam/homebrew-tap/releases/download/issue-jumper-0.1.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "b740986242dcc5ef83f3d22a5ec68b8228a3fda599817645ae27f99d9748bdf7"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  def caveats
    installer_url = "https://raw.githubusercontent.com/weirdo-adam/" \
                    "issue-jumper/main/scripts/install.sh"

    <<~EOS
      To configure Zed:
        #{opt_bin}/issue-jumper install-zed --force

      If issue-jumper is not found in a new shell, add Homebrew to PATH:
        eval "$(#{HOMEBREW_PREFIX}/bin/brew shellenv)"

      If ~/.local/bin/issue-jumper from the one-command installer shadows Homebrew, remove it with:
        curl -fsSL #{installer_url} | sh -s -- --uninstall
    EOS
  end

  test do
    assert_match "issue-jumper #{version}", shell_output("#{bin}/issue-jumper --version")
  end
end
