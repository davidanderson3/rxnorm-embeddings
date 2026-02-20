#!/bin/sh
set -eu

URL="https://download.nlm.nih.gov/rxnorm/RxNorm_full_prescribe_current.zip"
OUT_PATH="${1:-./RxNorm_full_prescribe_current.zip}"

if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required but not installed." >&2
  exit 1
fi

if ! command -v unzip >/dev/null 2>&1; then
  echo "Error: unzip is required but not installed." >&2
  exit 1
fi

OUT_DIR=$(dirname "$OUT_PATH")
mkdir -p "$OUT_DIR"
EXTRACT_DIR="$OUT_DIR/$(basename "$OUT_PATH" .zip)"

echo "Downloading RxNorm to: $OUT_PATH"
curl -fL --retry 5 --retry-delay 2 --retry-connrefused -o "$OUT_PATH" "$URL"
echo "Download complete: $OUT_PATH"

mkdir -p "$EXTRACT_DIR"
echo "Unzipping to: $EXTRACT_DIR"
unzip -o "$OUT_PATH" -d "$EXTRACT_DIR" >/dev/null
echo "Unzip complete: $EXTRACT_DIR"
