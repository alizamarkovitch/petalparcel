#!/bin/bash

# Bulk optimize JPG and PNG images in the images folder
# Requires: ImageMagick (mogrify), WebP tools (cwebp)
# Usage: bash optimize-images.sh

set -e

IMG_DIR="$(dirname "$0")/images"
cd "$IMG_DIR"

echo "[1/4] Backing up original images to images_backup..."
mkdir -p ../images_backup
cp *.jpg *.png ../images_backup/ 2>/dev/null || true

echo "[2/4] Optimizing JPG images..."
mogrify -strip -interlace Plane -gaussian-blur 0.05 -quality 80% *.jpg

echo "[3/4] Optimizing PNG images..."
mogrify -strip -quality 80% *.png

echo "[4/4] (Optional) Converting images to WebP..."
for img in *.jpg *.png; do
  cwebp -q 80 "$img" -o "${img%.*}.webp"
done

echo "Done! Your images are now optimized. Originals are in images_backup." 