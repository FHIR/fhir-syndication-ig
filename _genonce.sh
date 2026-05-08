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

# Ensure `jekyll` is reachable. The IG Publisher uses Jekyll to render the
# narrative HTML site, but on macOS the system Ruby is too old and the
# Homebrew Ruby + user-install gem dirs aren't on PATH by default.
if ! command -v jekyll >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    ruby_prefix="$(brew --prefix ruby 2>/dev/null || true)"
    [ -n "$ruby_prefix" ] && [ -d "$ruby_prefix/bin" ] && PATH="$ruby_prefix/bin:$PATH"
  fi
  if command -v ruby >/dev/null 2>&1; then
    gem_user_bin="$(ruby -e 'puts Gem.user_dir' 2>/dev/null)/bin"
    [ -d "$gem_user_bin" ] && PATH="$gem_user_bin:$PATH"
  fi
  export PATH
fi

# Compile FSH → FHIR resources.
sushi .

# Run the IG Publisher against the IG defined by ig.ini.
java -jar "$publisher_jar" -ig . "$@"
