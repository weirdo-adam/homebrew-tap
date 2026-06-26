cask "repopeek" do
  version "2026.06.04"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/weirdo-adam/RepoPeek/releases/download/v#{version}/RepoPeek-#{version}.zip"
  name "RepoPeek"
  desc "GitLab repository status, local checkout state, and API limits in the macOS menu bar"
  homepage "https://github.com/weirdo-adam/RepoPeek"

  depends_on macos: ">= :sequoia"

  app "RepoPeek.app"

  zap trash: [
    "~/Library/Application Support/RepoPeek",
    "~/Library/Caches/RepoPeek",
    "~/Library/Logs/RepoPeek",
    "~/Library/Preferences/com.weirdoadam.repopeek.plist",
  ]
end
