# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Set $DEFAULT_USER so that PROMPT can omit user on local shells
export DEFAULT_USER=`id -un`

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Volta setup
# If $VOLTA_HOME isn't already set, set it to ~/.volta
if [[ ! -n "$VOLTA_HOME" ]] {
  export VOLTA_HOME="$HOME/.volta"
}
# And if $VOLTA_HOME/bin dir exists, add it to $PATH
if [[ -d $VOLTA_HOME/bin ]] {
  export PATH=$VOLTA_HOME/bin:$PATH
}

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
plugins=(zsh-syntax-highlighting)

if [[ -e $ZSH/oh-my-zsh.sh ]] {
  source $ZSH/oh-my-zsh.sh
} else {
  >&2 echo "oh-my-zsh is not installed!"
}

if [[ -f ~/.fzf.zsh ]] {
  source ~/.fzf.zsh
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

# Source machine-specific .zshrc
if [[ -e $HOME/.zshrc.local ]] {
  source $HOME/.zshrc.local
}

# Make path array unique
typeset -U path

# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Bat config
export BAT_THEME=TwoDark

# Tell ripgrep about our config file if present (should be linked to ~ from ~/dotfiles/ripgrep)
if [[ -e $HOME/.ripgreprc ]] {
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
}

# Configure exa if it's installed
# https://the.exa.website/
if (( $+commands[exa] )) {
  # change file owner to yellow instead of bold yellow, modified time to purple instead of blue
  export EXA_COLORS="uu=33:da=35"
  # format times like file modified time as ISO instead of dynamic which is too variable
  export TIME_STYLE=long-iso
  # list [a]ll files in a [l]ong listing with column [h]eaders and include git status info if any
  alias la='exa -ahl --git --group-directories-first'
  alias ll='exa -hl --git --group-directories-first'
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
# print the current git branch and copy it to the clipboard
branch() {
  git branch --show-current
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
gitCheckoutWithFzf() {
  if [ $# -eq 0 ]; then
    # if we got no args then prompt for a branch name using fzf
    local ref="$(git branch --list --format='%(refname:short)' | fzf --no-multi)"
    [ -n "$ref" ] && git checkout "$ref"
  else
    # otherwise just call `git checkout` with the args we were passed
    git checkout "$@"
  fi
}

# Aliases
#
alias brews='brew list -1'
# ack but only search files that git knows about (honor .gitignore)
alias agk='git ls-files --others --cached --exclude-standard | ack -x'
alias agl='ag --literal'
alias fdd='fd -t d'
alias fdf='fd -t f'
alias fzv='fzf --multi | xargs mvim -p --'
alias gap='git add --patch'
alias gb='git branch'
alias gc='gitCheckoutWithFzf'
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
