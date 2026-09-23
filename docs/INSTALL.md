# Install dicomconvert

`dicomconvert` is a local command-line tool that exports frame 0 of a DICOM
file to PNG, JPEG, GIF, BMP, TIFF, WebP, SVG, NumPy, or JPEG XL. It can also
extract metadata as JSON, text, table, or HTML. It does not upload input files.

## Homebrew: macOS and Linux

Homebrew selects the correct verified binary for macOS 13+ (Apple Silicon or
Intel) and Linux (ARM64 or x86_64):

```sh
brew install aniachi/dicomconvert/dicomconvert
dicomconvert --version
dicomconvert --help
dicomconvert --licence
```

To update later:

```sh
brew update
brew upgrade dicomconvert
```

If Homebrew has not been installed yet, follow the instructions at
[brew.sh](https://brew.sh/). Homebrew is the recommended installation path on
macOS and Linux because it validates the release checksum automatically.

## Chocolatey: Windows x64

Install the native Windows build from PowerShell:

```powershell
choco install dicomconvert
```

Open a new PowerShell window after installation and verify it:

```powershell
dicomconvert --version
dicomconvert --help
```

To update or uninstall:

```powershell
choco upgrade dicomconvert
choco uninstall dicomconvert
```

The package targets 64-bit Windows (`x86_64-pc-windows-msvc`). It downloads the
matching ZIP from the immutable GitHub Release and verifies its SHA-256 checksum
before installing. If Chocolatey is not available, download the asset ending in
`x86_64-pc-windows-msvc.zip` from the
[Releases page](https://github.com/aniachi/homebrew-dicomconvert/releases),
extract `dicomconvert.exe`, and add its directory to `PATH`.

## Direct binary download: macOS and Linux

Open the repository's **Releases** page and select the asset whose target
matches your machine:

| System | CPU / `uname -m` | Target |
| --- | --- | --- |
| macOS 13+ | Apple Silicon / `arm64` | `aarch64-apple-darwin` |
| macOS 13+ | Intel / `x86_64` | `x86_64-apple-darwin` |
| Linux | ARM64 / `aarch64` | `aarch64-unknown-linux-musl` |
| Linux | Intel/AMD / `x86_64` | `x86_64-unknown-linux-musl` |

Every release includes `SHA256SUMS`. Verify an archive before installing it:

```sh
release="vX.Y.Z" # replace with a published tag
target="aarch64-apple-darwin" # replace with your target from the table
asset="dicomconvert-${release}-${target}.tar.gz"
base="https://github.com/aniachi/homebrew-dicomconvert/releases/download/${release}"
workdir="$(mktemp -d)"
curl -fL "$base/$asset" -o "$workdir/$asset"
curl -fL "$base/SHA256SUMS" -o "$workdir/SHA256SUMS"
(cd "$workdir" && grep "  $asset$" SHA256SUMS | shasum -a 256 -c -)
tar -xzf "$workdir/$asset" -C "$workdir"
install -m 755 "$workdir/dicomconvert" /usr/local/bin/dicomconvert
rm -rf "$workdir"
dicomconvert --version
```

On Linux, replace `shasum -a 256 -c -` with `sha256sum -c -` if `shasum` is not
installed. Choose a directory on your `PATH` where you have write permission if
`/usr/local/bin` requires elevated privileges. Linux archives are static musl
binaries.

## Android Termux: direct download

The Android build is a native ARM64 executable, not an APK. It needs a current
Termux installation on an ARM64 phone or tablet (`uname -m` prints `aarch64`),
and does not require root. It is linked for Android API 21+.

```sh
pkg update && pkg install curl tar coreutils
release="vX.Y.Z" # replace with a published tag
asset="dicomconvert-${release}-aarch64-linux-android.tar.gz"
base="https://github.com/aniachi/homebrew-dicomconvert/releases/download/${release}"
workdir="$(mktemp -d)"
curl -fL "$base/$asset" -o "$workdir/$asset"
curl -fL "$base/SHA256SUMS" -o "$workdir/SHA256SUMS"
(cd "$workdir" && sha256sum --ignore-missing -c SHA256SUMS)
tar -xzf "$workdir/$asset" -C "$workdir"
install -Dm755 "$workdir/dicomconvert" "$PREFIX/bin/dicomconvert"
rm -rf "$workdir"
dicomconvert --version
```

Never install a file when the checksum command reports a mismatch.

## First commands after installation

```sh
dicomconvert scan.dcm --output scan.png
dicomconvert scan.dcm --output pixels.npz
dicomconvert scan.dcm --extract json
dicomconvert scan.dcm --extract html --output metadata.html
dicomconvert --about
dicomconvert --licence
```

JSON and text extraction write only metadata to stdout. Table and HTML reports
include elapsed time. Binary DICOM values, including Pixel Data, are reported
as byte lengths instead of being written to the terminal. Existing output
files are protected from overwrite.
