class IssueJumper < Formula
  desc "Jump from the current Git branch to its issue page"
  homepage "https://github.com/weirdo-adam/issue-jumper"
  url "https://github.com/weirdo-adam/issue-jumper.git",
      tag:      "v0.1.0",
      revision: "eee1df8ac49152c44c69efcb313ba7408985e977"
  license "MIT"
  head "https://github.com/weirdo-adam/issue-jumper.git", branch: "main"

  bottle do
    root_url "https://github.com/weirdo-adam/homebrew-tap/releases/download/issue-jumper-0.1.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "03719cbb6c6f8f5b27680f1cdcc0463406e1b96ec053789f22fbb048d4ab2646"
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
