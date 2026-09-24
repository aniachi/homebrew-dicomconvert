class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.1.23"
  license "Beerware"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.23/dicomconvert-v0.1.23-aarch64-apple-darwin.tar.gz"
      sha256 "4d0e983687920aac8ab2ba27212021469732274e20f58b62734fca75324260fd"
    end
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.23/dicomconvert-v0.1.23-x86_64-apple-darwin.tar.gz"
      sha256 "c6e23974dfba98b705f064aadc2bdd6421567feeff1176ab7a53a328223bbe55"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.23/dicomconvert-v0.1.23-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6139d93fca41a748972dc7643705b26ee41eb8a73eef5399e0f3e78a8329e6b5"
    end
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.23/dicomconvert-v0.1.23-aarch64-unknown-linux-musl.tar.gz"
      sha256 "980c8c47461f90fd086e5433029580c5e7112bbd5a6e9d8921d91eef3a740891"
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
