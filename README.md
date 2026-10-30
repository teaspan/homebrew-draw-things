## A tap for a more recent Draw Things CLI build

Homebrew tap for the Draw Things CLI.  It builds from source at the tip of the `dti/main` branch of the [teaspan patchset](https://github.com/teaspan/draw-things-community), a set of unofficial patches maintained against upstream.

```
brew install teaspan/draw-things/draw-things-cli
```

### To update

To rebuild and reinstall using the current tip of `dti/main`:

```
brew update
brew reinstall teaspan/draw-things/draw-things-cli
```

### Base version

The teaspan edition is currently rebased off the unreleased [Draw Things Community](https://github.com/drawthingsai/draw-things-community) git ref fb0291c59e, just past tag v26.1023.0, dated Mon Oct 26.

### Improvements

On top of upstream, the teaspan `dti/main` patchset currently carries additional features:

- Import of LTX-2.3 checkpoints
- Import of MiniMax H3 checkpoints
- Import of Qwen Image 2.1 checkpoints
- Import of MOSS Image checkpoints
- Import of ComfyUI scaled-FP8 safetensors
- Adds JSON output (`--json`) to `draw-things-cli models import`
- Write AV output as a raw NUT container with rgb48le frames and pcm_f32le audio

which are incorporated in the `draw-things-cli` built by this formula.

### Model prep tool

For some checkpoints you may need to run [prep-model.py](https://gist.github.com/teaspan/ea15f459934974f914c4771e4d9ff87e) over them first, to massage them into an import-able shape.

### Available separately

The full [teaspan edition's dti/main branch](https://github.com/teaspan/draw-things-community/tree/dti/main) includes additional tools, improvements, and Linux-specific patches.  These are not built by this formula because that edition is intended as an alternative source tree for a container image.  So the Homebrew build doesn't benefit from them, but here's what you're missing:

- mmap whole-file reads on Linux instead of copying them into RAM
- Builds the Trainer and Downloader on Linux
- Links ccv and NNC as a single shared library
- An extra tool, `dtiSplit`, for splitting model files to/from external-data parts
- An extra tool, `dtiMerge`, for baking LoRA into models and general model mixing

several improvements to the standalone ModelQuantizer tool:

- Quantization of MiniMax H3 checkpoints
- Keep BF16 matmul rows in BF16 (instead of narrowing them to F16)
- A `--codec` override option
- Match the Draw Things catalog tensor precisions when quantizing Krea 2

and some minor behavioural options for the gRPC server:

- Adds a `--no-advertising` flag
- Adds a `--separate-lora` flag
