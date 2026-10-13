cask "brokkr" do
  version "2.4.11"

  on_arm do
    sha256 "f6249f9a372bef65982ad27a8805dfd133edd25f3cceae5b7e051f0d5f733a70"

    url "https://github.com/Gabriel2392/brokkr-flash/releases/download/v#{version}/Brokkr-#{version}-macos-arm64.app.zip"

    depends_on macos: :ventura
  end
  on_intel do
    sha256 "4b5e1063bba0dbacfab2e2970e86f6cc8edb281e60fa900c48f0ed946395244c"

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
