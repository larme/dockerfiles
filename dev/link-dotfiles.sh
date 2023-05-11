#!/bin/sh

SRC_DIR="/workspace/.local/dotfiles"
DES_DIR="$HOME"

for FILE in "$SRC_DIR/"*; do
    echo "$DES_DIR/.$(basename $FILE)"
    ln -ns "$FILE" "$DES_DIR/.$(basename $FILE)"
done
