# dicomconvert: native DICOM conversion

![DICOM slices converted locally into image formats](https://raw.githubusercontent.com/aniachi/homebrew-dicomconvert/main/assets/hero.png)

Binary distribution and Homebrew tap for the native `dicomconvert` CLI. The
application source and HTTP API are maintained separately. This repository
contains only the package formula, public documentation, license, and signed-by-
checksum release binaries; it contains no DICOM samples or patient data.

## Documentation

- [Installation guide](docs/INSTALL.md) — Homebrew, direct macOS/Linux downloads,
  and Android Termux.
- [CLI usage](docs/USAGE.md) — supported formats, examples, and exit behavior.
- [Release and integrity policy](docs/RELEASES.md) — checksums and immutable releases.
- [Contributing](CONTRIBUTING.md) and [security reporting](SECURITY.md).

## Install with Homebrew (macOS and Linux)

After the first release, Homebrew supports macOS 13+ on Apple Silicon and Intel,
plus Linux ARM64 and x86_64:

```sh
brew install aniachi/dicomconvert/dicomconvert
dicomconvert scan.dcm --output scan.png
dicomconvert scan.dcm --output scan.svg
dicomconvert scan.dcm --output result --format webp
```

Homebrew downloads the matching archive and verifies its SHA-256 automatically.

## Termux on Android (direct download)

The Android build is a native ARM64 command-line executable for current Termux
installations. It is not an APK and does not require root. Install the latest
release with `curl`, `tar`, and `coreutils`:

```sh
pkg update && pkg install curl tar coreutils
release="vX.Y.Z" # replace with the release shown on this repository's Releases page
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

`aarch64` is required (`uname -m` prints `aarch64`). The release is linked for
Android API 21+, while current Termux distributions generally require a newer
Android version. A checksum mismatch means the binary must not be installed.

## Direct download on macOS or Linux

Download the archive matching the `target` shown below from Releases and verify
it against `SHA256SUMS` before extracting it. Linux archives are static musl
binaries; macOS requires version 13 or newer.

| System | CPU / `uname -m` | Release target |
| --- | --- | --- |
| macOS | Apple Silicon / `arm64` | `aarch64-apple-darwin` |
| macOS | Intel / `x86_64` | `x86_64-apple-darwin` |
| Linux | ARM64 / `aarch64` | `aarch64-unknown-linux-musl` |
| Linux | Intel/AMD / `x86_64` | `x86_64-unknown-linux-musl` |
| Android Termux | ARM64 / `aarch64` | `aarch64-linux-android` |

Supported image outputs: PNG, JPEG, GIF, BMP, TIFF, WebP, SVG. Converts frame 0
only, using the same decoding and image conversion as the HTTP service.
Files are processed locally. Existing output files are never overwritten.
Use `--help` or `--version`. An error produces a nonzero exit status.

The CLI exports image files; HTTP export modes such as NPZ, JSON vectors,
base64 and compression wrappers remain available through the separate API.
Decoder support depends on the compiled dicom-pixeldata codecs; unsupported
transfer syntaxes return an error. JPEG and vectorized SVG are lossy.

This tap is initialized with a disabled bootstrap formula. The first successful
release replaces it with the four Homebrew archive URLs and real SHA256 values.
