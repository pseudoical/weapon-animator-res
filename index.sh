#!/bin/bash

set -euo pipefail
shopt -s nullglob

OUTPUT="index.html"

cat > "$OUTPUT" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Weapon Animator Resources</title>
    <style>
        body {
            background: #f3f3f4;
            color: #2e2e34;
        }
        @media (prefers-color-scheme: dark) {
            body {
                background: #2e2e34;
                color: #f3f3f4;
            }
        }
        body {
            --width: 350px;
            --gap: 50px;
            --columns: 3;
            display: grid;
            grid-template-columns: repeat(auto-fit, var(--width));
            gap: var(--gap);
            justify-content: center;
            width: min(100%, calc(var(--columns) * var(--width) + (var(--columns) - 1) * var(--gap)));
            margin: 0 auto;
            font-family: sans-serif;
        }
        body > div {
            width: var(--width);
        }
        body img {
            width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
EOF

{
    for path in masks/*_texture_mask*; do
        file=${path##*/}
        printf '%s\t%s\n' "${file%_texture_mask*}" "$path"
    done

    for path in anims/*_anim*; do
        file=${path##*/}
        printf '%s\t%s\n' "${file%_anim*}" "$path"
    done
} |
sort -s -t $'\t' -k1,1 |
while IFS=$'\t' read _ path; do
    file=${path##*/}
    cat >> "$OUTPUT" <<EOF
    <div>
        <h3>$file</h3>
        <a href="$path" target="_blank" rel="noopener noreferrer">
            <img src="$path" alt="$file" loading="lazy">
        </a>
    </div>
EOF
done >> "$OUTPUT"

cat >> "$OUTPUT" <<EOF
</body>
</html>
EOF
