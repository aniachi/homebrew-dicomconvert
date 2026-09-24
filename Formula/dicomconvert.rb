class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.1.21"
  license "Beerware"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.21/dicomconvert-v0.1.21-aarch64-apple-darwin.tar.gz"
      sha256 "eaf90378fc9bc92db882853e9a84a090cbaa2a53952d01be079c8a1db8fa5bcf"
    end
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.21/dicomconvert-v0.1.21-x86_64-apple-darwin.tar.gz"
      sha256 "38040def2f19d7e27308dbba4d4a337e9f972b50a2ba455a0173ebc859f6e2d9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.21/dicomconvert-v0.1.21-x86_64-unknown-linux-musl.tar.gz"
      sha256 "53cf592ff2ccec5adf3e93b548dbb0b7767e574852a125fec6deccf1f8f3a15f"
    end
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.21/dicomconvert-v0.1.21-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f9bfec8350d4a74c2a696bf4d9636164eee27113cc71c592247db6dad7421070"
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
