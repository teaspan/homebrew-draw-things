# Teaspan tap for Draw Things

Homebrew tap for the Draw Things CLI. The upstream formula's `--HEAD`
build is broken because the public repository's Package.swift references
sources that were never published. This tap's `head` points at the
[teaspan fork](https://github.com/teaspan/draw-things-community), which
builds.

```
brew install --HEAD teaspan/draw-things/draw-things-cli
```

Without `--HEAD`, installs the upstream release binary.
