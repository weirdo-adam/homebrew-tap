class IssueJumper < Formula
  desc "Jump from the current Git branch to its issue page"
  homepage "https://github.com/weirdo-adam/issue-jumper"
  url "https://github.com/weirdo-adam/issue-jumper/archive/refs/tags/" \
      "v0.1.2.tar.gz"
  sha256 "21f163b40c4e65db0786e738704c90f17eef32220b1604e422c7db2d3d195b1e"
  license "MIT"
  head "https://github.com/weirdo-adam/issue-jumper.git", branch: "main"

  bottle do
    root_url "https://github.com/weirdo-adam/homebrew-tap/releases/download/issue-jumper-0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "27d43d94fe1e205436906b23b362205d3f0770f4ae373d297f560b35040cfb52"
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
