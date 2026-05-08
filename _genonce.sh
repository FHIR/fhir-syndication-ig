#!/bin/bash
set -e

# Run SUSHI + the HL7 FHIR IG Publisher once, producing output/ in this dir.
# Run ./_updatePublisher.sh first to fetch publisher.jar.

cd "$(dirname "$0")"

publisher_jar="input-cache/publisher.jar"

if [ ! -f "$publisher_jar" ]; then
  echo "$publisher_jar not found. Run ./_updatePublisher.sh first." >&2
  exit 1
fi

# Compile FSH → FHIR resources.
sushi .

# Run the IG Publisher against the IG defined by ig.ini.
java -jar "$publisher_jar" -ig . "$@"
