#!/usr/bin/env bash

if ! [ -x "$(command -v stow)" ]; then
  echo 'Error: stow is not installed.' >&2
  exit 1
fi

# Call stow to make appropriate symlinks for each directory in the current directory
# The --dotfiles flag will make it name links to things named 'dot-foo' be named '.foo'
stow -R --dotfiles $(ls -d1 */)
