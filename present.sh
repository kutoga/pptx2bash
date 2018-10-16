#!/bin/bash
set -e

pptx_file="$(realpath $1)"
cd "$(dirname "$0")"
workdir="$(realpath ".work")"

echo "Create temporary working directory: $workdir"
rm -Rf "$workdir"
mkdir -p "$workdir"
cp "$pptx_file" "$workdir/input.pptx"
cd "$workdir"

echo "Convert pptx to pdf..."
unoconv -f pdf input.pptx

echo "Convert pdf to jpg..."
convert input.pdf -quality 100 slide.jpg

echo "Present..."
for slide in slide*.jpg; do
    jp2a --colors --background=dark -f --chars=".:;#@...',;:clodxkO0KXNWM" "$slide"
    read
done

echo "Cleanup..."
cd ..
rm -Rf "$workdir"

