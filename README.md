## A tap for a more recent Draw Things CLI build

Homebrew tap for the Draw Things CLI.  It builds from source at the tip of the `dti/main` branch of the [teaspan patchset](https://github.com/teaspan/draw-things-community), a set of unofficial patches maintained against upstream.  As of this writing (31 August 2026), the upstream repository's `Package.swift` references missing sources, so it does not build.  The patched tree does.

```
brew install teaspan/draw-things/draw-things-cli
```

### Base version

The teaspan edition is currently rebased off the unreleased Draw Things Community git ref [79b43626](https://github.com/drawthingsai/draw-things-community/commit/79b43626), dated Sat Jul 25, which includes useful Krea 2 and Ideogram 4 stuff, and is as far as we know the most recent end-user-buildable commit.

### Extra stuff

On top of upstream, the teaspan `dti/main` patchset currently carries additional features:

- Import of LTX-2.3 checkpoints
- Import of ComfyUI scaled-FP8 safetensors
- A small extra tool `dtiSplit`, for splitting model files into external-data parts
- Keeps BF16 matmul rows in BF16 when quantizing, instead of narrowing them to F16
- Adds a `--codec` option to the model quantizer
- Adds a `--no-advertising` flag to the gRPC server
- Adds a `--separate-lora` flag to the gRPC server
- Adds JSON output (`--json`) to `draw-things-cli models import`
- Stops the import progress spewing "100%" over and over on certain imports

The teaspan edition also includes Linux-specific patches.  They are (should be) no-ops on macOS, so the Homebrew build gains nothing from them, still:

- Writes AV output as a NUT clip on Linux instead of failing outright
- mmap whole-file reads on Linux instead of copying them into RAM
- Builds the Trainer and Downloader on Linux
- Links ccv and NNC as a single shared library
