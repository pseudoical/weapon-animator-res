#!/bin/bash

set -euo pipefail
shopt -s nullglob

OUTPUT="README.md"

cat > "$OUTPUT" <<EOF
# Weapon Animator Resources

A collection of texture masks and animation previews for the Kirka [weapon animator](https://github.com/pseudoical/kirka-scripts/blob/main/scripts/weapon-animator.js) script.

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
    printf '### %s\n\n<img src="%s" height="300">\n\n' "$file" "$path"
done >> "$OUTPUT"

cat >> "$OUTPUT" <<EOF
---

<p align="center">This project is licensed under the <a href="LICENSE">BSD Zero Clause License</a>.</p>
EOF
