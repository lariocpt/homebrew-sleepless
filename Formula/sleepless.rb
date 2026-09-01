class Sleepless < Formula
  desc "Keep your computer awake for exactly as long as it runs"
  homepage "https://github.com/lariocpt/sleepless"
  version "0.1.3"
  license "MIT"

  # Prebuilt binaries rather than a source build: the point of the tool is that you
  # can start it in a terminal immediately, and compiling ~280 crates first is a poor
  # introduction. Homebrew fetches with curl, which does not set the quarantine
  # attribute, so Gatekeeper does not block these.
  on_macos do
    on_arm do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.3/sleepless-aarch64-apple-darwin-v0.1.3.tar.gz"
      sha256 "c9f49113f45c97e36dee71628ab3ecdf5db34ca5d61d0437f7f8c014f1ff0884"
    end
    on_intel do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.3/sleepless-x86_64-apple-darwin-v0.1.3.tar.gz"
      sha256 "3a6edea9bb69069c319aee69117ba8f88d0a407c2dfd32f40a3474d2f2eabe1f"
    end
  end

  # Linuxbrew gets the static musl builds, which have no libc floor at all.
  on_linux do
    on_arm do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.3/sleepless-aarch64-unknown-linux-musl-v0.1.3.tar.gz"
      sha256 "f0aecb6142ad762f17c238ad17f489b48859c60f647cda19ed256a0cece43728"
    end
    on_intel do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.3/sleepless-x86_64-unknown-linux-musl-v0.1.3.tar.gz"
      sha256 "f08204604e79973557267ad670e9bec48815ebec688096d41c738778ddc354e7"
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
