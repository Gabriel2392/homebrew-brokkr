cask "brokkr" do
  version "2.4.8"

  on_arm do
    sha256 "c47ea8936e01ab840779478d340494e69920b29850c0fd5a7d638196ee8b0528"

    url "https://github.com/Gabriel2392/brokkr-flash/releases/download/v#{version}/Brokkr-#{version}-macos-arm64.app.zip"

    depends_on macos: :ventura
  end
  on_intel do
    sha256 "e751ab923345bac21c06614d040abc9fd02623a8149702070c2649f069273167"

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

    Alternatively, reinstall with:

      brew install --cask --no-quarantine #{token}
  EOS
end
