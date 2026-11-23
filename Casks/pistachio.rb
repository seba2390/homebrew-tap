cask "pistachio" do
  version "0.4.3"
  sha256 "cfccaae3802ff82489c1e63e48eeeb975f014a3ceb1b18414ce95281026c7d2b"

  url "https://github.com/seba2390/pistachio/releases/download/v#{version}/Pistachio-v#{version}-macos-universal.zip"
  name "Pistachio"
  desc "Native desktop app for the pi coding agent"
  homepage "https://github.com/seba2390/pistachio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Pistachio.app"

  # The app is not notarized yet; without this, macOS blocks its first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Pistachio.app"]
  end

  zap trash: [
    "~/.pi/agent/pistachio",
    "~/Library/Saved Application State/dev.pistachio.app.savedState",
  ]

  caveats <<~EOS
    Pistachio needs pi (https://pi.dev):
      npm i -g @earendil-works/pi-coding-agent
  EOS
end
