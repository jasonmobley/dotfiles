# Use precmd hook to print a blank line before each new prompt (but not the first one)
# Doing this way means the PROMPT doesn't have to, which helps in iTerm2 with marks so
# that the mark is placed on the prompt line and not the blank link preceding it.
precmd() {
  precmd() {
    echo
  }
}

# Set prompt char and color, change symbol and color if previous command exited non-zero
# prompt_char_with_color=%(?.$fg[cyan]❯.$fg[red]✘)

# Set default prompt color, change to red if previous command exited non-zero
prompt_color=%(?.$fg[cyan].$fg[red])

# Plain chevron
prompt_text=❯

# Powerline rightward pointing triangle
#prompt_text=`print '\uE0B0'` # 

# Powerline rightward pointing triangle plus one full block left of it
#prompt_text=`print '\u2588\uE0B0'` # █

PROMPT="%{$terminfo[bold]$prompt_color%}$prompt_text %{$reset_color%}"
RPROMPT=
