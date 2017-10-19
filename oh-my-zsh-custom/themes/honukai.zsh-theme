# Based on the great ys theme (http://ysmood.org/wp/2013/03/my-ys-terminal-theme/)

ZSH_THEME_MACHINE_PROMPT_PREFIX1=" %{$fg[white]%}at%{$reset_color%} "
ZSH_THEME_MACHINE_PROMPT_PREFIX2="%{$fg[green]%}"
ZSH_THEME_MACHINE_PROMPT_SUFFIX=" %{$reset_color%} "

# Machine name.
function box_name {
	# Only show box name for SSH sessions
	if [[ -n "$SSH_CONNECTION" ]]; then
		echo -n "$ZSH_THEME_MACHINE_PROMPT_PREFIX1"
		echo -n "$ZSH_THEME_MACHINE_PROMPT_PREFIX2"
		echo -n [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
        echo -n "$ZSH_THEME_MACHINE_PROMPT_SUFFIX"
	fi
}
local machine_name='$(box_name)'

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✖︎"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}●"

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $
PROMPT="
%{$terminfo[bold]$fg[blue]%}%#%{$reset_color%} \
%{$fg[cyan]%}%n \
${machine_name}\
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${git_info}
%{$terminfo[bold]$fg[red]%}➡ %{$reset_color%}"

