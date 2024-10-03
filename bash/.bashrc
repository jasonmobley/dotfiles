# Make terminal title show currently running command or
# pwd if no currently running command
trap 'echo -ne "\033]0;${BASH_COMMAND%% *}\007"' DEBUG

# Make the ls command use colored output by default
export CLICOLOR=1

# this is a bugfix for certain terminals so that all emacs bindings work
# without it, things like C-w and C-s can't be rebound
if [ -t 0 ]; then
    stty stop undef
    stty werase undef
fi

alias ll="ls -al"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
