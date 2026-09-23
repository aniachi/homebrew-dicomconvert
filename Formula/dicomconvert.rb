class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.1.18"
  license "Beerware"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.18/dicomconvert-v0.1.18-aarch64-apple-darwin.tar.gz"
      sha256 "e462be7bf746ce594b34bed1dbbf0601807415c4351d80567e59a45bcf918095"
    end
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.18/dicomconvert-v0.1.18-x86_64-apple-darwin.tar.gz"
      sha256 "7bab9d0cec6a1e416f9b0d9b338019a02ea4cadc264fa844ef783172412afc3f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.18/dicomconvert-v0.1.18-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fd752538ce2c10d3f1b52c27f9783b11093046f3cc15b4dfef058ef75e5ad698"
    end
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.18/dicomconvert-v0.1.18-aarch64-unknown-linux-musl.tar.gz"
      sha256 "184f246a5273940a5902cb7b69243e7e79950cdeec5e757bffa355fafa226126"
    end
  end

  def install
    bin.install "dicomconvert"
    doc.install "README.md", "LICENSE.txt"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dicomconvert --version")
    (testpath/"invalid.dcm").write "not a DICOM file"
    assert_match "Failed to parse", shell_output("#{bin}/dicomconvert invalid.dcm -o output.png 2>&1", 1)
    refute_path_exists testpath/"output.png"
  end
end
