# Releases and integrity

Each versioned release contains five archives and one `SHA256SUMS` manifest:

- macOS Apple Silicon and Intel;
- Linux ARM64 and x86_64 static musl binaries;
- Android/Termux ARM64.

Archives contain only `dicomconvert`, this repository's `README.md`, and its
license. They never contain application source code, `.env` files, fixtures, or
DICOM data.

Release files are immutable. If an asset is incorrect, use a new version rather
than replacing a published archive or moving a tag. The Homebrew formula is
updated only after the public archive downloads pass SHA-256 verification.

Use the `SHA256SUMS` file published with the exact release tag. A checksum
mismatch, missing asset, or unsupported CPU architecture means installation
must stop. Report a suspected compromised release through the repository's
private security-advisory channel.
