class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.1.25"
  license "Beerware"

  on_macos do
    depends_on macos: :ventura
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.25/dicomconvert-v0.1.25-aarch64-apple-darwin.tar.gz"
      sha256 "71c745c1e20b22b05b3e8307a2b6689405e6af253bec59c6f46bb49529a5c949"
    end
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.25/dicomconvert-v0.1.25-x86_64-apple-darwin.tar.gz"
      sha256 "7e98122c1ad4fe98ee65c975002553d80c36e17fc72098e598f5faac12833c63"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.25/dicomconvert-v0.1.25-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f894cd26d3c0dd94a5600db8a5c77bfe75445e2e68b05fdd6270b3dfce452284"
    end
    on_arm do
      url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/v0.1.25/dicomconvert-v0.1.25-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9a9603214dd3b53505914d8cba735e85d36a139886cea65bd05087461cccc2a2"
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
