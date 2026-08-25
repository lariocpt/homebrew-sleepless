class Sleepless < Formula
  desc "Keep your computer awake for exactly as long as it runs"
  homepage "https://github.com/lariocpt/sleepless"
  version "0.1.0"
  license "MIT"

  # Prebuilt binaries rather than a source build: the point of the tool is that you
  # can start it in a terminal immediately, and compiling ~280 crates first is a poor
  # introduction. Homebrew fetches with curl, which does not set the quarantine
  # attribute, so Gatekeeper does not block these.
  on_macos do
    on_arm do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.0/sleepless-aarch64-apple-darwin-v0.1.0.tar.gz"
      sha256 "7ba3e50d052c333dc96a936e780a82fdb25b41cf155187fe2fd5164f56d964f5"
    end
    on_intel do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.0/sleepless-x86_64-apple-darwin-v0.1.0.tar.gz"
      sha256 "1ad6d0c58e53911097ce08fb6b13dd89777b6f505b5a35b5afe1645a7846bb84"
    end
  end

  # Linuxbrew gets the static musl builds, which have no libc floor at all.
  on_linux do
    on_arm do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.0/sleepless-aarch64-unknown-linux-musl-v0.1.0.tar.gz"
      sha256 "344db613d04e7f518cca7a2fa991572c19696ab52bd22e5bb5438119e6f74c78"
    end
    on_intel do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.0/sleepless-x86_64-unknown-linux-musl-v0.1.0.tar.gz"
      sha256 "87aac07190194c1e76e977e629db86c88366641e848699a2e580b33ce5b2ba9e"
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
