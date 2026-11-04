class Sleepless < Formula
  desc "Keep your computer awake for exactly as long as it runs"
  homepage "https://github.com/lariocpt/sleepless"
  version "0.1.4"
  license "MIT"

  # Prebuilt binaries rather than a source build: the point of the tool is that you
  # can start it in a terminal immediately, and compiling ~280 crates first is a poor
  # introduction. Homebrew fetches with curl, which does not set the quarantine
  # attribute, so Gatekeeper does not block these.
  on_macos do
    on_arm do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.4/sleepless-aarch64-apple-darwin-v0.1.4.tar.gz"
      sha256 "22c0243fe27708052c5eaa7c0b1e030223323d21c031f7117e6ea19ea1640668"
    end
    on_intel do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.4/sleepless-x86_64-apple-darwin-v0.1.4.tar.gz"
      sha256 "5070d27bfbda7e0a96f2acb264c6528ce354e2e9e1b4cee2b07a5bcac4a31227"
    end
  end

  # Linuxbrew gets the static musl builds, which have no libc floor at all.
  on_linux do
    on_arm do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.4/sleepless-aarch64-unknown-linux-musl-v0.1.4.tar.gz"
      sha256 "06e4b1fa7551070424a04ff75861d4b0dd9e07d5407615347a79bce14ae8dc1e"
    end
    on_intel do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.4/sleepless-x86_64-unknown-linux-musl-v0.1.4.tar.gz"
      sha256 "fa514782d09edcdd0c7102beb7b2d217cad3693dfa052c625dba1d449b6019e0"
    end
  end

  def install
    bin.install "sleepless"
  end

  def caveats
    <<~EOS
      The system tray icon and lid-close blocking are Linux-only. On macOS,
      sleepless holds IOPMAssertions for the duration of the process, so quitting
      it -- or closing the terminal -- restores normal sleep immediately.
    EOS
  end

  test do
    assert_match "sleepless #{version}", shell_output("#{bin}/sleepless --version")
    # --smoke is the headless path: it takes the locks, prints status and exits.
    assert_match "sleepless -", shell_output("#{bin}/sleepless --always --smoke 1")
  end
end
