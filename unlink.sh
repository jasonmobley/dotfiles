#!/usr/bin/env bash

if ! [ -x "$(command -v stow)" ]; then
  echo 'Error: stow is not installed.' >&2
  exit 1
fi

# Call stow to *remove* symlinks for each directory in the current directory
stow -D $(ls -d1 */)

