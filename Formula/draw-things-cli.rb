class DrawThingsCli < Formula
  desc "Local inference and LoRA training CLI for Draw Things"
  homepage "https://github.com/teaspan/draw-things-community"
  url "https://github.com/drawthingsai/draw-things-community/releases/download/v1.20260430.0/draw-things-cli"
  version "1.20260430.0"
  sha256 "7e5fb3af7dd99916d7671354a11fd40182bc6a0d16e7faf06fda7740c24915cd"
  license "GPL-3.0-or-later"

  head "https://github.com/teaspan/draw-things-community.git", branch: "dti/main"

  depends_on macos: :ventura

  on_linux do
    disable! date: "2026-03-31", because: "is macOS-only"
  end

  def install
    executable = if build.head?
      build_from_source
    else
      chmod 0555, "draw-things-cli"
      buildpath/"draw-things-cli"
    end

    bin.install executable

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
