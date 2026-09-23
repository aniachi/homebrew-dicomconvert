class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.1.10"
  license "Beerware"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.10/dicomconvert-v0.1.10-aarch64-apple-darwin.tar.gz"
      sha256 "804c84efc8e44948a2b374d62193a796d9952b9ca331a46b120d0982c530c319"
    end
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.10/dicomconvert-v0.1.10-x86_64-apple-darwin.tar.gz"
      sha256 "814c818ca47c1b04f27ff36ad23debd290852af091964b04ef980275f2f3cb24"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.10/dicomconvert-v0.1.10-x86_64-unknown-linux-musl.tar.gz"
      sha256 "938103e03206757246fa9d78fb9d847521d125182af4fb7e571358cf346d2285"
    end
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.10/dicomconvert-v0.1.10-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0e8d5c5a37d8301c0f2847c2a44c7b74ac8d2e80b4fbd5599250cf7164e76224"
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
