source ~/.git-prompt.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_HIDE_IF_PWD_IGNORED=1

# Make terminal title show currently running command or
# pwd if no currently running command
trap 'echo -ne "\033]0;${BASH_COMMAND%% *}\007"' DEBUG

function show_name { 
    if [[ -n "$BASH_COMMAND" ]]; then
      echo -en "\033]0;`basename ${PWD}`\007"
    fi 
}
export PROMPT_COMMAND='show_name'

# Make the ls command use colored output by default
export CLICOLOR=1

# this is a bugfix for certain terminals so that all emacs bindings work
# without it, things like C-w and C-s can't be rebound
if [ -t 0 ]; then
    stty stop undef
    stty werase undef
fi

alias ll="ls -al"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
