#!/usr/bin/env bash

if ! [[ -z $(git status -s) ]]; then
  echo 'You have uncommitted changes. Commit or revert them first!'
  exit 1
fi;

git submodule update --remote --merge
git commit -am 'Updating submodules to latest'
