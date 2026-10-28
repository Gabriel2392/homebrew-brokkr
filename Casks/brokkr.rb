cask "brokkr" do
  version "2.4.12"

  on_arm do
    sha256 "5e60cadccadd1acf76c48e3d3c72786cc64d91699ac83fd67d8455a8b733004d"

    url "https://github.com/Gabriel2392/brokkr-flash/releases/download/v#{version}/Brokkr-#{version}-macos-arm64.app.zip"

    depends_on macos: :ventura
  end
  on_intel do
    sha256 "05f2d40921b450b449961fb1ab9158715925241f3a775cb88102721d92e21b54"

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
