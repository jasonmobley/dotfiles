# dotfiles

## Setting up a new machine using Stow

1. Install all the usual stuff: vim, nvim, macvim, zsh, oh-my-zsh, etc.
2. Install GNU Stow,
   e.g. `brew install stow`
3. Clone the repo to `~/dotfiles`:
   `git clone --recurse-submodules git@github.com:jasonmobley/dotfiles.git ~/dotfiles`
4. Move to the new dotfiles directory:
   `cd ~/dotfiles`
5. Create symlinks by running `./link.sh`

## Updating git submodules (e.g. vim plugins)

Just run `./update-submodules.sh` with a clean index and working tree.

You shouldn't need to relink things after updating.
