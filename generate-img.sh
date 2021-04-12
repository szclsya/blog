#!/bin/bash

SIZE="2500x2500"

for img in $(find ./img | grep "jpg$"); do
    echo "Converting $img..."
    new_path=${img/'./img/'/'./static/img/'}
    mkdir -p "$(dirname $new_path)"
    # Generate minified JPG
    convert $img -resize $SIZE -strip -interlace Plane -gaussian-blur 0.05 -quality 60% $new_path
    # Generate WebP
    convert $img -resize $SIZE -quality 80 -strip -define webp:lossless=false -define webp:method=6 ${new_path/'.jpg'/'.webp'}
    # Generate AVIF
    convert $img -resize $SIZE -quality 80 ${new_path/'.jpg'/'.avif'}
done

for img in $(find ./img | grep "png$"); do
    echo "Converting $img..."
    new_path=${img/'./img/'/'./static/img/'}
    mkdir -p "$(dirname $new_path)"
    # Copy original PNG
    convert $img -resize $SIZE -strip $new_path
    # Generate AVIF
    convert $img -resize $SIZE -strip ${new_path/'.png'/'.avif'}
done
