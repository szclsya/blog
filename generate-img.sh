#!/bin/bash

# \> in the end means it will only be resized if original image is bigger
SIZE='2500x2500>'

for img in $(find ./img | grep "avif$"); do
    echo "Converting $img..."
    new_path=${img/'./img/'/'./assets/img/'}
    mkdir -p "$(dirname "$new_path")"
    # Generate minified JPG
    if [[ ! -e ${new_path/'.avif'/'.jpg'} ]]; then
        convert "$img" -resize "$SIZE" -strip -interlace Plane -gaussian-blur 0.05 -quality 60% "${new_path/'.avif'/'.jpg'}"
    fi
    # Generate WebP
    if [[ ! -e ${new_path/'.avif'/'.webp'} ]]; then
        convert "$img" -resize "$SIZE" -strip -quality 80 -define webp:lossless=false -define webp:method=6 "${new_path/'.avif'/'.webp'}"
    fi
    # Generate minified AVIF
    if [[ ! -e $new_path ]]; then
        convert "$img" -resize $SIZE -strip -quality 80 "$new_path"
    fi
done

for img in $(find ./img | grep "jpg$"); do
    echo "Converting $img..."
    new_path=${img/'./img/'/'./assets/img/'}
    mkdir -p "$(dirname "$new_path")"
    # Generate minified JPG
    if [[ ! -e $new_path ]]; then
        convert "$img" -resize "$SIZE" -strip -interlace Plane -gaussian-blur 0.05 -quality 60% "$new_path"
    fi
    # Generate WebP
    if [[ ! -e ${new_path/'.jpg'/'.webp'} ]]; then
        convert "$img" -resize "$SIZE" -strip -quality 80 -define webp:lossless=false -define webp:method=6 "${new_path/'.jpg'/'.webp'}"
    fi
    # Generate AVIF
    if [[ ! -e ${new_path/'.jpg'/'.avif'} ]]; then
        convert "$img" -resize $SIZE -strip -quality 80 "${new_path/'.jpg'/'.avif'}"
    fi
done

for img in $(find ./img | grep "png$"); do
    echo "Converting $img..."
    new_path=${img/'./img/'/'./assets/img/'}
    mkdir -p "$(dirname "$new_path")"
    # Copy original PNG
    if [[ ! -e $new_path ]]; then
        convert "$img" -resize "$SIZE" -strip "$new_path"
        # Use OptiPNG to minimize the result
        optipng "$new_path"
    fi
    # Generate lossless WebP
    if [[ ! -e ${new_path/'.png'/'.webp'} ]]; then
        convert "$img" -resize "$SIZE" -strip -define webp:lossless=true "${new_path/'.png'/'.webp'}"
    fi
    # Generate AVIF
    if [[ ! -e ${new_path/'.png'/'.avif'} ]]; then
        convert "$img" -resize "$SIZE" -strip "${new_path/'.png'/'.avif'}"
    fi
done
