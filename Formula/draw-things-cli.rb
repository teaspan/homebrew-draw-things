class DrawThingsCli < Formula
  desc "Local inference and LoRA training CLI for Draw Things"
  homepage "https://github.com/teaspan/draw-things-community"
  url "https://github.com/teaspan/draw-things-community.git", branch: "dti/main"
  version "1.20261031.0"
  license "GPL-3.0-or-later"

  head "https://github.com/teaspan/draw-things-community.git", branch: "dti/main"

  depends_on macos: :ventura

  on_linux do
    disable! date: "2026-03-31", because: "is macOS-only"
  end

  # use our s4nnc, for the ezm7 external-data fix
  resource "s4nnc" do
    url "https://github.com/teaspan/s4nnc.git", branch: "dti/main"
  end

  def install
    resource("s4nnc").stage buildpath/"s4nnc"
    swift "package", "edit", "s4nnc", "--path", buildpath/"s4nnc"

    bin.install %w[draw-things-cli draw-things-quantizer].map(&method(:build_from_source))

    generate_completions_from_executable(bin/"draw-things-cli", "completion")
  end

  test do
    assert_match "Local inference and training CLI", shell_output("#{bin}/draw-things-cli --help")
    assert_match "--model", shell_output("#{bin}/draw-things-cli generate --help")
    assert_match "Model utilities", shell_output("#{bin}/draw-things-cli models --help")
    assert_match "--codec", shell_output("#{bin}/draw-things-quantizer --help")
  end

  private

  def scratch_path = buildpath/".build"

  # Workspace options go after the verb but before a `package` subcommand.
  # SwiftPM's sandbox won't nest inside Homebrew's.
  def swift(verb, *args)
    ENV["CLANG_MODULE_CACHE_PATH"] = buildpath/"clang-module-cache"
    system(
      "swift", verb, "--disable-sandbox", "--cache-path", buildpath/"swiftpm-cache",
      "--config-path", buildpath/"swiftpm-config", "--security-path",
      buildpath/"swiftpm-security", "--scratch-path", scratch_path, *args
    )
  end

  def build_from_source(product)
    swift "build", "-c", "release", "--build-system", "native", "--product", product

    scratch_path/"release"/product
  end
end
