class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.1.14"
  license "Beerware"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.14/dicomconvert-v0.1.14-aarch64-apple-darwin.tar.gz"
      sha256 "cd9e366fc4316a69e7ba8645dc8b7dcb88fe5575a1677b9b5d2d654a428a0dd4"
    end
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.14/dicomconvert-v0.1.14-x86_64-apple-darwin.tar.gz"
      sha256 "2f938a1ddc3d9c88921977aa6b06d2dee41e9e73ef3515bdaffadf27812f1902"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.14/dicomconvert-v0.1.14-x86_64-unknown-linux-musl.tar.gz"
      sha256 "577cccf1a59cb76e53a9b8745c7d1c152a89136cc394ef681eeebd87e365506f"
    end
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.14/dicomconvert-v0.1.14-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7bff88ae189df9359d2865e9a0926f37b71aa44784bcb571da44d6c05fb30b48"
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
