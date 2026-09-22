# Bootstrap only. Replaced automatically after the first verified public release.
class Dicomconvert < Formula
  desc "Convert the first frame of DICOM files to images"
  homepage "https://github.com/aniachi/homebrew-dicomconvert"
  version "0.0.0"
  license "Beerware"
  url "https://github.com/aniachi/homebrew-dicomconvert/releases/download/bootstrap/unavailable.tar.gz"
  disable! date: "2026-09-15", because: "the first binary release has not been published"

  def install
    odie "Publish the first binary release before installing"
  end
end
