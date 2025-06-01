#!/bin/bash

set -euo pipefail

SRC_DIR="out/lib"
DST_DIR="${1}"  # Use first argument if provided

mkdir -p "$DST_DIR"

find "$SRC_DIR" -type f -name 'lib*.so.*.*.*' | while read -r filepath; do
  filename=$(basename "$filepath")
  
  # Match libname.so.MAJOR.MINOR.PATCH
  if [[ "$filename" =~ ^(lib.+\.so)\.([0-9]+)\.[0-9]+\.[0-9]+$ ]]; then
    base="${BASH_REMATCH[1]}"
    major="${BASH_REMATCH[2]}"
    newname="$base.$major"
    
    cp "$filepath" "$DST_DIR/$newname"
    echo "Copied $filename -> $newname"
  else
    echo "Skipping $filename (does not match expected version pattern)"
  fi
done
