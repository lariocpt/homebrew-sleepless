class Sleepless < Formula
  desc "Keep your computer awake for exactly as long as it runs"
  homepage "https://github.com/lariocpt/sleepless"
  version "0.1.2"
  license "MIT"

  # Prebuilt binaries rather than a source build: the point of the tool is that you
  # can start it in a terminal immediately, and compiling ~280 crates first is a poor
  # introduction. Homebrew fetches with curl, which does not set the quarantine
  # attribute, so Gatekeeper does not block these.
  on_macos do
    on_arm do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.2/sleepless-aarch64-apple-darwin-v0.1.2.tar.gz"
      sha256 "700b0f61dd83b3ecfec1e84e595ff2b40064b857acd7cd472bc98b3895965006"
    end
    on_intel do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.2/sleepless-x86_64-apple-darwin-v0.1.2.tar.gz"
      sha256 "7db652eb0308a722c3c77729a1907515fd126e2a1e77287fb040f05c8ced9f6d"
    end
  end

  # Linuxbrew gets the static musl builds, which have no libc floor at all.
  on_linux do
    on_arm do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.2/sleepless-aarch64-unknown-linux-musl-v0.1.2.tar.gz"
      sha256 "5dd8f73ebd0eff261ce61c4fb7c73228c58d0d7f43a7fe3fe89a6b3a1b9c2bca"
    end
    on_intel do
      url "https://github.com/lariocpt/sleepless/releases/download/v0.1.2/sleepless-x86_64-unknown-linux-musl-v0.1.2.tar.gz"
      sha256 "be0141c59f0592b4117ce45edb7709422afeb80374562f0985fde23ba9d77dfa"
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
