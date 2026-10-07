# webp.sh

A  standalone Bash utility for converting video files into animated WebP files.

## Requirements

- FFmpeg

## Usage

The converter reads video files from `input/` and writes the resulting animated WebPs to `output/`. Existing output files are skipped.

1. Create the input directory:

   ```bash
   mkdir -p ./input
   ```

2. Add video files to `input/`.

3. Run the converter:

   ```bash
   ./tools/converter/webp.sh
   ```

4. Find the converted animated WebPs in `output/`.

## Supported Formats

- `.webm`
- `.mp4`
