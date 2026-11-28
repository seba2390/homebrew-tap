cask "pistachio" do
  version "0.6.0"
  sha256 "45e147850da262b61e458c8ba8f8896ff6610519d9930a357278077f5831dc95"

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
