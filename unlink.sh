#!/usr/bin/env bash

if ! [ -x "$(command -v stow)" ]; then
  echo 'Error: stow is not installed.' >&2
  exit 1
fi

# Call stow to *remove* symlinks for each directory in the current directory
# Also --ignore the damned .DS_Store files MacOS lays down in any Finder-opened dir
stow -D --ignore='DS_Store' $(ls -d1 */)

