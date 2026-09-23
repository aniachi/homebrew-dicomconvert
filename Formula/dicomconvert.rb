class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.1.20"
  license "Beerware"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.20/dicomconvert-v0.1.20-aarch64-apple-darwin.tar.gz"
      sha256 "2df9fc6e163cbb68e33673babdf879c8ae61afd00c7824f57810a18a22421bdd"
    end
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.20/dicomconvert-v0.1.20-x86_64-apple-darwin.tar.gz"
      sha256 "438678c69f51d7ea9005424d5018c61c112ec10eb202acf60b9b534db02a8996"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.20/dicomconvert-v0.1.20-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4d934aa994489882adac7374e897ab82a819f741d321efcdf48d3e45dc9cfb86"
    end
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.20/dicomconvert-v0.1.20-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3e0ad7bc504fe71dd4df5ac3c483f98986c2e70d02fe72672c246df865259aa1"
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
