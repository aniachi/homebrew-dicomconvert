# dicomconvert: native DICOM conversion

![DICOM slices converted locally into image formats](https://raw.githubusercontent.com/aniachi/homebrew-dicomconvert/main/assets/hero.png)

Binary distribution and Homebrew tap for the native `dicomconvert` CLI. The
application source and HTTP API are maintained separately. This repository
contains only the package formula, public documentation, license, and signed-by-
checksum release binaries; it contains no DICOM samples or patient data.

## Documentation

- [Installation guide](docs/INSTALL.md) — Homebrew, direct macOS/Linux downloads,
  Windows/Chocolatey, and Android Termux.
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
dicomconvert scan.dcm --extract json
dicomconvert scan.dcm --extract html --output metadata.html
dicomconvert --licence
```

Homebrew downloads the matching archive and verifies its SHA-256 automatically.

## Install on Windows with Chocolatey

The recommended Windows installation uses [Chocolatey](https://chocolatey.org/)
and installs the native x64 MSVC build:

```powershell
choco install dicomconvert
```

After installation, open a new PowerShell window and verify the command:

```powershell
dicomconvert --version
dicomconvert --help
```

To update or remove it later:

```powershell
choco upgrade dicomconvert
choco uninstall dicomconvert
```

Chocolatey verifies the SHA-256 checksum of the GitHub Release ZIP before
installing it. Windows users who do not use Chocolatey can download the
`x86_64-pc-windows-msvc.zip` asset from the
[Releases page](https://github.com/aniachi/homebrew-dicomconvert/releases),
extract `dicomconvert.exe`, and add its directory to `PATH`.

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

## Direct download on macOS, Linux, or Windows

Download the archive matching the `target` shown below from Releases and verify
it before extracting it. Use `SHA256SUMS` for Unix archives and the SHA-256
digest displayed by GitHub for the Windows ZIP. Linux archives are static musl
binaries; macOS requires version 13 or newer; Windows uses the native x64 MSVC
build.

| System | CPU / `uname -m` | Release target |
| --- | --- | --- |
| macOS | Apple Silicon / `arm64` | `aarch64-apple-darwin` |
| macOS | Intel / `x86_64` | `x86_64-apple-darwin` |
| Linux | ARM64 / `aarch64` | `aarch64-unknown-linux-musl` |
| Linux | Intel/AMD / `x86_64` | `x86_64-unknown-linux-musl` |
| Windows | x64 / `x86_64` | `x86_64-pc-windows-msvc` |
| Android Termux | ARM64 / `aarch64` | `aarch64-linux-android` |

## CLI features

The CLI converts frame 0 locally to PNG, JPEG, GIF, BMP, TIFF, WebP, SVG,
NumPy `.npy`/`.npz`, or lossless JPEG XL `.jxl`:

```sh
dicomconvert scan.dcm --output pixels.npy
dicomconvert scan.dcm --output pixels.npz
dicomconvert scan.dcm --output scan.jxl
```

The aliases `numpy` → `npz` and `jpegxl`/`jpeg-xl` → `jxl` are accepted with
`--format`. DICOM metadata can be extracted as JSON, text, an ASCII table, or
HTML. JSON and text are clean machine-readable output; table and HTML include
elapsed time. Pixel Data and every other binary value are represented only by
their byte length:

```sh
dicomconvert scan.dcm --extract json
dicomconvert scan.dcm --extract text > metadata.txt
dicomconvert scan.dcm --extract table --output metadata.table
dicomconvert scan.dcm --extract html --output metadata.html
```

`--help` and `--about` show the Aniachi Tech ASCII logo, company URL,
disclaimer, and elapsed time. `--version` shows the logo, URL, and version.
`--licence` prints the Beer-Ware licence (with the `--license` alias); unknown
options also point to `dicomconvert --help`. Files are processed locally and
existing output paths, including symbolic links, are never overwritten. An
error produces a nonzero exit status.

Decoder support depends on the compiled dicom-pixeldata codecs; unsupported
transfer syntaxes return an error. JPEG and vectorized SVG are lossy.

This tap is initialized with a disabled bootstrap formula. The first successful
release replaces it with the four Homebrew archive URLs and real SHA256 values.
