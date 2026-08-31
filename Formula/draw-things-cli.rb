class DrawThingsCli < Formula
  desc "Local inference and LoRA training CLI for Draw Things"
  homepage "https://github.com/teaspan/draw-things-community"
  url "https://github.com/teaspan/draw-things-community.git", branch: "dti/main"
  version "1.20260831.0"
  license "GPL-3.0-or-later"

  head "https://github.com/teaspan/draw-things-community.git", branch: "dti/main"

  depends_on macos: :ventura

  on_linux do
    disable! date: "2026-03-31", because: "is macOS-only"
  end

  def install
    bin.install build_from_source

    generate_completions_from_executable(bin/"draw-things-cli", "completion")
  end

  test do
    assert_match "Local inference and training CLI", shell_output("#{bin}/draw-things-cli --help")
    assert_match "--model", shell_output("#{bin}/draw-things-cli generate --help")
    assert_match "Model utilities", shell_output("#{bin}/draw-things-cli models --help")
  end

  private

  def build_from_source
    scratch_path = buildpath/".build"

    ENV["CLANG_MODULE_CACHE_PATH"] = buildpath/"clang-module-cache"
    system(
      "swift", "build", "--disable-sandbox", "--cache-path", buildpath/"swiftpm-cache",
      "--config-path", buildpath/"swiftpm-config", "--security-path",
      buildpath/"swiftpm-security", "--scratch-path", scratch_path, "-c", "release",
      "--product", "draw-things-cli"
    )

    scratch_path/"release"/"draw-things-cli"
  end
end
