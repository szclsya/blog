#!/bin/bash

for img in ./img/*/*; do
    echo "Converting $img..."
    new_path=${img/'./img/'/'./static/img/'}
    mkdir -p "$(dirname $new_path)"
    # Generate minified JPG
    convert $img -strip -interlace Plane -gaussian-blur 0.05 -quality 60% $new_path
    # Generate WebP
    convert $img -quality 70 -strip -define webp:lossless=false -define webp:method=6 ${new_path/'.jpg'/'.webp'}
    # Generate AVIF
    convert $img -quality 60 ${new_path/'.jpg'/'.avif'}
done
