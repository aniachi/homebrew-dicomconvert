class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.1.15"
  license "Beerware"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.15/dicomconvert-v0.1.15-aarch64-apple-darwin.tar.gz"
      sha256 "f8d2072cd2a94e7b922541e2e2779b5647cbe62f39303d2ba01f865bb1fccb2a"
    end
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.15/dicomconvert-v0.1.15-x86_64-apple-darwin.tar.gz"
      sha256 "1cdeb87160f0368f81776532b571bc39a41ae14ebad8bba030cc635a245bab30"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.15/dicomconvert-v0.1.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fe00346f30aa62c5fc37f1a93ba454cd927a916f5602d101bdc9ddf280ffbb70"
    end
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.15/dicomconvert-v0.1.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "98519b3f65a3593c2447cb5c272c2be2ded78bfe503e9a48f81de4216ad775b6"
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
