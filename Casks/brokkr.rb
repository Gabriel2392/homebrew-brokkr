cask "brokkr" do
  version "2.4.10"

  on_arm do
    sha256 "e3717e2159f944f887db9a619f62a3e407668f8adc11982a1545f007b40f6dd7"

    url "https://github.com/Gabriel2392/brokkr-flash/releases/download/v#{version}/Brokkr-#{version}-macos-arm64.app.zip"

    depends_on macos: :ventura
  end
  on_intel do
    sha256 "43e140074cd6e7effd7ed30470f71c7c286b9557016dd0d94c2cb5cdf07edc88"

    url "https://github.com/Gabriel2392/brokkr-flash/releases/download/v#{version}/Brokkr-#{version}-macos-x86_64.app.zip"

    depends_on macos: :big_sur
  end

  name "Brokkr"
  desc "Samsung device flashing utility"
  homepage "https://github.com/Gabriel2392/brokkr-flash"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false

  app "brokkr.app"
  binary "#{appdir}/brokkr.app/Contents/MacOS/brokkr"

  postflight_steps do
    run "xattr", args: ["-d", "-r", "com.apple.quarantine", "{{appdir}}/brokkr.app"]
  end

  caveats <<~EOS
    Brokkr is not signed or notarized by Apple. This cask clears the quarantine
    attribute after installation. If macOS still refuses to open the app, run:

      sudo xattr -dr com.apple.quarantine #{appdir}/brokkr.app
  EOS
end
