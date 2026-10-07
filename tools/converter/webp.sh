#!/bin/bash

set -euo pipefail
shopt -s nullglob

ROOT_DIR="tools/converter"
INPUT_DIR="$ROOT_DIR/input"
OUTPUT_DIR="$ROOT_DIR/output"

mkdir -p "./$OUTPUT_DIR"

for input in ./$INPUT_DIR/*; do
    file="${input##*/}"
    output="./$OUTPUT_DIR/${file%.*}.webp"

    if [[ -f "$output" ]]; then
        continue
    fi

    case "${file##*.}" in
        webm)
            options=(-q:v 100)
            ;;
        mp4)
            options=(-c:v libwebp -v:f "fps=50")
            ;;
        *)
            echo "Unknown format: $file"
            continue
            ;;
    esac

    ffmpeg -i "$input" "${options[@]}" -loop 0 "$output" &
done

wait
