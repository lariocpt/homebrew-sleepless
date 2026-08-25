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
