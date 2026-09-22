# Install dicomconvert

`dicomconvert` is a local command-line tool that exports frame 0 of a DICOM
file to PNG, JPEG, GIF, BMP, TIFF, WebP, or SVG. It does not upload input files.

## Homebrew: macOS and Linux

Homebrew selects the correct verified binary for macOS 13+ (Apple Silicon or
Intel) and Linux (ARM64 or x86_64):

```sh
brew install aniachi/dicomconvert/dicomconvert
dicomconvert --version
```

To update later:

```sh
brew update
brew upgrade dicomconvert
```

If Homebrew has not been installed yet, follow the instructions at
[brew.sh](https://brew.sh/). Homebrew is the recommended installation path on
macOS and Linux because it validates the release checksum automatically.

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
