class IssueJumper < Formula
  desc "Jump from the current Git branch to its issue page"
  homepage "https://github.com/weirdo-adam/issue-jumper"
  url "https://github.com/weirdo-adam/issue-jumper.git",
      tag:      "v0.1.0",
      revision: "eee1df8ac49152c44c69efcb313ba7408985e977"
  license "MIT"
  head "https://github.com/weirdo-adam/issue-jumper.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    assert_match "issue-jumper #{version}", shell_output("#{bin}/issue-jumper --version")
  end
end
