# Using dicomconvert

```text
dicomconvert INPUT --output OUTPUT [--format FORMAT]
```

The output format defaults to the output filename extension. Choose one
explicitly with `--format` when the output has no extension.

```sh
dicomconvert scan.dcm --output scan.png
dicomconvert scan.dcm --output scan.jpg
dicomconvert scan.dcm --output output --format webp
dicomconvert scan.dcm --output scan.svg
```

Supported format names are `png`, `jpg`, `jpeg`, `gif`, `bmp`, `tiff`, `webp`,
and `svg`. The CLI converts only the first DICOM frame. SVG is vectorized and
lossy; JPEG is also lossy.

```sh
dicomconvert --help
dicomconvert --version
```

Files are processed locally. Existing output paths, including symbolic links,
are never overwritten. Errors return a nonzero exit status. Input transfer
syntax support depends on the codecs included in the release binary.

The command-line release intentionally does not include the HTTP API's NPZ,
JSON vector, base64, or compression-wrapper export modes.
