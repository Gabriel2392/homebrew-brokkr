cask "brokkr" do
  version "2.5.0"

  on_arm do
    sha256 "c74b09850b8bc2fd017c33f2973b87bba2f9473fc5af6b8825eb24eb1c391786"

    url "https://github.com/Gabriel2392/brokkr-flash/releases/download/v#{version}/Brokkr-#{version}-macos-arm64.app.zip"

    depends_on macos: :ventura
  end
  on_intel do
    sha256 "047069e6d176449212614f21b6fd0d1470ffc8a6044bf0e45ad171f492d42500"

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
