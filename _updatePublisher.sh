#!/bin/bash
set -e

# Download the latest HL7 FHIR IG Publisher JAR into ./input-cache/.
# Idempotent — overwrites any previous copy.

input_cache_path="$(dirname "$0")/input-cache"
publisher_url="https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar"

mkdir -p "$input_cache_path"

# Skip the prompt when CI=true or when -y / --yes is passed.
auto_yes=0
[ "$CI" = "true" ] && auto_yes=1
for arg in "$@"; do
  case "$arg" in
    -y|--yes) auto_yes=1 ;;
  esac
done

if [ -f "$input_cache_path/publisher.jar" ] && [ "$auto_yes" -ne 1 ]; then
  read -p "publisher.jar already exists. Overwrite? [y/N] " reply
  case "$reply" in
    y|Y) ;;
    *) echo "Aborted."; exit 0 ;;
  esac
fi

echo "Downloading publisher.jar from $publisher_url"
curl -fL "$publisher_url" -o "$input_cache_path/publisher.jar"
echo "Saved to $input_cache_path/publisher.jar"
