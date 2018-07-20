# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set $DEFAULT_USER so that PROMPT can omit user on local shells
export DEFAULT_USER=`id -un`

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Load nvm if it's installed (this needs to be before the plugins section below)
if [[ -d $HOME/.nvm ]] {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="honukai"

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
if [[ -d $HOME/dotfiles/oh-my-zsh-custom ]] {
  ZSH_CUSTOM=$HOME/dotfiles/oh-my-zsh-custom
}

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-prompt jira npm shrink-path zsh-nvm)

if [[ -e $ZSH/oh-my-zsh.sh ]] {
  source $ZSH/oh-my-zsh.sh
} else {
  echo "oh-my-zsh is not installed!"
}

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

# enable caching for oh-my-zsh/git-prompt plugin
ZSH_THEME_GIT_PROMPT_CACHE=1

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

# Aliases
alias brews='brew list -1'
alias ackl='ack -l'
alias ackp='fd -e properties -t f -p "en_US[^_]" | ack -x'
alias ackq='ack -Q'
alias agl='ag --literal'
alias fzv='fzf --multi | xargs mvim -p --'
alias tcp='lsof -P -i TCP -s TCP:LISTEN'
alias vimr='vim -R'

# Enable iTerm shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
