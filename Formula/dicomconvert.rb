class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.1.0"
  license "Beerware"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.0/dicomconvert-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "07f061806a04f6966cbf27cf062262c3aa95c7ebef67c7f5ae45cf830f913987"
    end
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.0/dicomconvert-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "f5631454968f47794977a592147ef7b9b2aced503f00778d51aaaf173e20fe5b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.0/dicomconvert-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b699f3b373010482e4082d81f56a86a61673eb24957a66077986cfab09531248"
    end
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.0/dicomconvert-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a625bb686cd154a3f5d4af6708339288a1b8e72635714695d7c5b048e05c6b72"
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
