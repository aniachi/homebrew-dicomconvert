class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.1.22"
  license "Beerware"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.22/dicomconvert-v0.1.22-aarch64-apple-darwin.tar.gz"
      sha256 "4674475b0757c1a3daccf6c6b68f3e06313d53aacfb3076f4102240aed94b54f"
    end
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.22/dicomconvert-v0.1.22-x86_64-apple-darwin.tar.gz"
      sha256 "65390ee58e7a15a82b9fa428c81090c6a25fd7042139053e96bee7a8e29ae30d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.22/dicomconvert-v0.1.22-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c6a30de2ff4b5efb0ee55ffb0154345fd95254e6671fd4b44f43c1f1b6c7d09c"
    end
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.22/dicomconvert-v0.1.22-aarch64-unknown-linux-musl.tar.gz"
      sha256 "05a5f2448778ae9e35f5053440fd2793681212dad0cf4c144f1500c20086d318"
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
