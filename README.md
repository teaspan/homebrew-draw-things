## A tap for a more recent Draw Things CLI build

Homebrew tap for the Draw Things CLI.  It builds from source at the tip of the `dti/main` branch of the [teaspan patchset](https://github.com/teaspan/draw-things-community), a set of unofficial patches maintained against upstream.

```
brew install teaspan/draw-things/draw-things-cli
```

### Base version

The teaspan edition is currently rebased off the unreleased [Draw Things Community](https://github.com/drawthingsai/draw-things-community) git ref 08e798b5, tagged v26.0910.1, dated Sat Sep 12.

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
- Write AV output as a raw NUT container with rgb48le frames and pcm_f32le audio

The teaspan edition also includes Linux-specific patches.  They are (should be) no-ops on macOS, so the Homebrew build doesn't benefit from them, still:

- mmap whole-file reads on Linux instead of copying them into RAM
- Builds the Trainer and Downloader on Linux
- Links ccv and NNC as a single shared library
