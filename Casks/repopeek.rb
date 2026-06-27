cask "repopeek" do
  version "2026.06.04"
  sha256 "b195c556c81e0c2999468d0f19cb4007a57d3d515971810d143dd3a600330891"

  url "https://github.com/weirdo-adam/RepoPeek/releases/download/v#{version}/RepoPeek-#{version}.zip"
  name "RepoPeek"
  desc "GitLab repository status, local checkout state, and API limits in the macOS menu bar"
  homepage "https://github.com/weirdo-adam/RepoPeek"

  depends_on macos: ">= :sequoia"

  app "RepoPeek.app"

  auto_updates false

  livecheck do
    url :homepage
    regex(/v?(\d{4}\.\d{2}\.\d{2})/i)
    strategy :github_latest
  end

  zap trash: [
    "~/Library/Application Support/RepoPeek",
    "~/Library/Caches/RepoPeek",
    "~/Library/Logs/RepoPeek",
    "~/Library/Preferences/com.weirdoadam.repopeek.plist",
  ]
end
