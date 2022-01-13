#!/bin/bash

# \> in the end means it will only be resized if original image is bigger
SIZE='2500x2500>'

for img in $(find ./img | grep "avif$"); do
    echo "Converting $img..."
    new_path=${img/'./img/'/'./assets/img/'}
    mkdir -p "$(dirname $new_path)"
    # Generate minified JPG
    convert $img -resize "$SIZE" -strip -interlace Plane -gaussian-blur 0.05 -quality 60% ${new_path/'.avif'/'.jpg'}
    # Generate WebP
    convert $img -resize "$SIZE" -strip -quality 80 -define webp:lossless=false -define webp:method=6 ${new_path/'.avif'/'.webp'}
    # Generate AVIF
    convert $img -resize $SIZE -strip -quality 80 $new_path
done

for img in $(find ./img | grep "jpg$"); do
    echo "Converting $img..."
    new_path=${img/'./img/'/'./assets/img/'}
    mkdir -p "$(dirname $new_path)"
    # Generate minified JPG
    convert $img -resize "$SIZE" -strip -interlace Plane -gaussian-blur 0.05 -quality 60% $new_path
    # Generate WebP
    convert $img -resize "$SIZE" -strip -quality 80 -define webp:lossless=false -define webp:method=6 ${new_path/'.jpg'/'.webp'}
    # Generate AVIF
    convert $img -resize $SIZE -strip -quality 80 ${new_path/'.jpg'/'.avif'}
done

for img in $(find ./img | grep "png$"); do
    echo "Converting $img..."
    new_path=${img/'./img/'/'./assets/img/'}
    mkdir -p "$(dirname $new_path)"
    # Copy original PNG
    convert $img -resize "$SIZE" -strip $new_path
    # Use OptiPNG to minimize the result
    optipng $new_path
    # Generate lossless WebP
    convert $img -resize "$SIZE" -strip -define webp:lossless=true ${new_path/'.png'/'.webp'}
    # Generate AVIF
    convert $img -resize "$SIZE" -strip ${new_path/'.png'/'.avif'}
done
