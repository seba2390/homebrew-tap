cask "pistachio" do
  version "0.5.0"
  sha256 "b04c94c8824448c1cad74d2af7f98896ed6cb4aea9241c99d41aa9d7b124bc0a"

  url "https://github.com/seba2390/pistachio/releases/download/v#{version}/Pistachio-v#{version}-macos-arm64.zip"
  name "Pistachio"
  desc "Native desktop app for the pi coding agent"
  homepage "https://github.com/seba2390/pistachio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
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
