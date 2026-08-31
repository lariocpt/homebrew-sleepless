# homebrew-sleepless

Homebrew tap for [sleepless](https://github.com/lariocpt/sleepless) — a terminal
app that keeps your computer awake for exactly as long as it's running.

```sh
brew install lariocpt/sleepless/sleepless
```

The formula installs a prebuilt binary, so there is nothing to compile. macOS gets
a native build for your architecture; Linuxbrew gets a static musl build with no
libc floor.

Tray icon and lid-close blocking are Linux-only — see the
[main README](https://github.com/lariocpt/sleepless#platform-support) for the full
platform table.

## To bump

Never by hand: the version and four sha256 values live in eleven places across this
formula, the AUR PKGBUILD and its .SRCINFO, and a checksum edited by eye is a checksum
that stops matching. From a sleepless checkout, after the release is live:

```sh
tools/bump-channels.sh 0.1.2          # rewrite this formula and the AUR package
tools/bump-channels.sh 0.1.2 --check  # or just verify they already agree
```

It reads the checksums from the release's own `.sha256` assets rather than re-hashing a
local build, so what gets pinned is what is actually published, and it refuses to finish
unless all three files agree.
