# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:$PATH

# Set $DEFAULT_USER so that PROMPT can omit user on local shells
export DEFAULT_USER=`id -un`

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Base16 Shell
BASE16_SHELL="$HOME/.base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mobley"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
if [[ -d $HOME/.omz-custom ]] {
  ZSH_CUSTOM=$HOME/.omz-custom
}

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()

if [[ -e $ZSH/oh-my-zsh.sh ]] {
  source $ZSH/oh-my-zsh.sh
} else {
  >&2 echo "oh-my-zsh is not installed!"
}

# Initialize fzf shell integration (e.g. ** tab expansion)
if (( $+commands[fzf] )) {
  source <(fzf --zsh)
}

# Add rust and cargo stuff to PATH if Rust is installed to ~/.cargo
if [[ -f $HOME/.cargo/env ]] {
  source $HOME/.cargo/env
}

# Add dotfiles/.zfunctions to $fpath for custom functions
fpath=( "$HOME/dotfiles/.zfunctions" $fpath )

# User configuration

# emacs mode for line editing
bindkey -e

export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Initialize pure prompt
# https://github.com/sindresorhus/pure
#autoload -U promptinit; promptinit
#prompt pure

# enable caching for oh-my-zsh/git-prompt plugin
export ZSH_THEME_GIT_PROMPT_CACHE=1

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# File listing customizations

# For consistent/readable create/modify time in file listings
export TIME_STYLE=long-iso

# Generate a decent LS_COLORS using vivid
# Other nice themes: nord, snazzy, zenburn
if (( $+commands[vivid] )) {
  export LS_COLORS="$(vivid generate snazzy)"
}

# Use the GNU ls instead of the BSD one because it doesn't support LS_COLORS
if (( $+commands[gls] )) {
  # alias "ls" to the GNU version of ls on mac
  alias ls='gls --color=auto --group-directories-first --no-group'
}

# Configure eza (formerly exa) if it's installed
# https://github.com/eza-community/eza
if (( $+commands[eza] )) {
  # change file owner to yellow instead of bold yellow, modified time to purple instead of blue
  export EZA_COLORS="uu=33:da=35"
  # format times like file modified time as ISO instead of dynamic which is too variable
  # list [a]ll files in a [l]ong listing with column [h]eaders and include git status info if any
  alias la='eza -ahl --git --group-directories-first'
  alias ll='eza -hl --git --group-directories-first --no-user'
}

# Activate mise (version manager for NodeJS, Java, Python, etc)
# https://mise.jdx.dev/
if (( $+commands[mise] )) {
  eval "$(mise activate zsh)"
}

# Source machine-specific .zshrc
if [[ -e $HOME/.zshrc.local ]] {
  source $HOME/.zshrc.local
}

# Make path array unique
typeset -U path

# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Bat config
export BAT_THEME=base16

# Tell ripgrep about our config file if present (should be linked to ~ from ~/dotfiles/ripgrep)
if [[ -e $HOME/.ripgreprc ]] {
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
}
# Enable hyperlinking in ripgrep by aliasing the command
# Use macvim-style hyperlinks with ripgrep if mvim binary is present or default style otherwise
# (prefixing with "command" tells zsh to find the rg binary ignoring aliases)
if (( $+commands[mvim] )) {
  alias rg="command rg --hyperlink-format=macvim"
} else {
  alias rg="command rg --hyperlink-format=default"
}

# Functions
#
# list the N most recently checked out branches (20 by default)
branches() {
  git reflog \
    | sed -n 's/.*checkout: moving from \(.*\) to \(.*\)/\2 \1/p' \
    | tr ' ' '\n' \
    | awk '!x[$0]++' \
    | head -n "${1:-20}"
}
# print the current git branch
branch() {
  if [ -t 1 ]; then
    # if stdout is a terminal simply run the command to print the branch name
    git branch --show-current
  else
    # otherwise (not a terminal, e.g. a pipe) strip the trailing newline (for things like piping to pbcopy)
    echo -n "$(git branch --show-current)"
  fi
}
# print the "parent" branch of the current git branch and copy to the clipboard
# (this is really more like the "merge-base" ... that is, the branch we pull from and would likely target with a PR)
parent() {
  git show-branch -a 2>/dev/null \
    | grep '*' \
    | grep -v "$(git branch --show-current)" \
    | head -n1 \
    | sed 's/.*\[\(.*\)\].*/\1/' \
    | sed 's/[\^~].*//'
}

# Aliases
#
alias brews='brew list -1'
# join lines from stdin into a single comma-delimited string
alias commas='paste -s -d , -'
alias fdd='fd -t d'
alias fdf='fd -t f'
alias fzv='fzf --multi | xargs mvim -p --'
alias gap='git add --patch'
alias gc='git checkout'
alias gd='git diff'
alias gds='git diff --cached'
alias gl='git log --oneline --decorate'
alias glg='git log --oneline --decorate --graph'
alias glga='git log --oneline --decorate --graph --all'
alias gll='git log'
alias gs='git status'
alias gss='git status --short --branch'
# print out the list of packages in node_modules that are npm link'd
alias nlinks='find node_modules -maxdepth 1 -type l -print'
alias path='echo $PATH | tr ":" "\n"'
alias tcp='lsof -P -i TCP -s TCP:LISTEN'

# Prefer neovim as vim when present
(( $+commands[nvim] )) && alias vim=nvim

# Source the zsh-syntax-highlighting script if present
# NOTE: this is meant to be the last thing in .zshrc!
if [[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] {
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}
