# Using dicomconvert

```text
dicomconvert INPUT --output OUTPUT [--format FORMAT]
dicomconvert INPUT --extract FORMAT [--output OUTPUT]
```

The output format defaults to the output filename extension. Choose one
explicitly with `--format` when the output has no extension.

```sh
dicomconvert scan.dcm --output scan.png
dicomconvert scan.dcm --output scan.jpg
dicomconvert scan.dcm --output output --format webp
dicomconvert scan.dcm --output scan.svg
dicomconvert scan.dcm --output pixels.npy
dicomconvert scan.dcm --output pixels.npz
dicomconvert scan.dcm --output scan.jxl
```

Supported format names are `png`, `jpg`, `jpeg`, `gif`, `bmp`, `tiff`, `webp`,
`svg`, `npy`, `npz`, and `jxl`. The aliases `numpy`, `jpegxl`, and `jpeg-xl`
are accepted. The CLI converts only the first DICOM frame. SVG is vectorized
and lossy; JPEG is also lossy; JPEG XL is lossless.

## Metadata extraction

Extraction can write to stdout or to a new file. JSON and text contain only
metadata, while table and HTML include an elapsed-time footer. Binary values
such as Pixel Data are represented by their byte length and are never dumped
to stdout:

```sh
dicomconvert scan.dcm --extract json
dicomconvert scan.dcm --extract text > metadata.txt
dicomconvert scan.dcm --extract table --output metadata.table
dicomconvert scan.dcm --extract html --output metadata.html
```

The same modes can be selected with `--format json|text|table|html`, or inferred
from an output extension. Existing files and symbolic links are protected.

```sh
dicomconvert --help
dicomconvert --about
dicomconvert --version
dicomconvert --licence
```

`--help` and `--about` include the ASCII logo, Aniachi Tech URL, disclaimer, and
elapsed time. `--version` includes the logo, URL, and version. `--licence`
prints the Beer-Ware licence; `--license` is an accepted alias. Unknown options
suggest `dicomconvert --help`. Files are processed locally and errors return a
nonzero exit status. Input transfer syntax support depends on the codecs
included in the release binary.
