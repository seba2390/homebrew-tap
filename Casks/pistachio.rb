cask "pistachio" do
  version "0.5.5"
  sha256 "fa9a8e41e1e2f0367a5a96d387d5c2a3fae08069b50e82a7ebeb878068e68eff"

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
