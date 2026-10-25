## A tap for a more recent Draw Things CLI build

Homebrew tap for the Draw Things CLI.  It builds from source at the tip of the `dti/main` branch of the [teaspan patchset](https://github.com/teaspan/draw-things-community), a set of unofficial patches maintained against upstream.

```
brew install teaspan/draw-things/draw-things-cli
```

### Base version

The teaspan edition is currently rebased off the unreleased [Draw Things Community](https://github.com/drawthingsai/draw-things-community) git ref 3f7fcd9499, just past tag v26.1023.0, dated Sun Oct 25.

### Extra stuff

On top of upstream, the teaspan `dti/main` patchset currently carries additional features:

- Import of LTX-2.3 checkpoints
- Import and quantization of MiniMax H3 checkpoints
- Import of Qwen Image 2.1 checkpoints
- Import of MOSS Image checkpoints
- Import of ComfyUI scaled-FP8 safetensors
- Keep BF16 matmul rows in BF16 when quantizing, instead of narrowing them to F16
- Adds a `--codec` option to the model quantizer
- Adds a `--no-advertising` flag to the gRPC server
- Adds a `--separate-lora` flag to the gRPC server
- Adds JSON output (`--json`) to `draw-things-cli models import`
- Stops the import progress spewing "100%" over and over on certain imports
- Write AV output as a raw NUT container with rgb48le frames and pcm_f32le audio

The teaspan edition also includes additional tools and Linux-specific patches.  They are (should be) no-ops on macOS, and the additional tools are not built by this formula, so the Homebrew build doesn't benefit from them, and here's what you're missing:

- mmap whole-file reads on Linux instead of copying them into RAM
- Builds the Trainer and Downloader on Linux
- Links ccv and NNC as a single shared library
- An extra tool, `dtiSplit`, for splitting model files to/from external-data parts
- An extra tool, `dtiMerge`, for baking LoRA into models and general model mixing
