# Use precmd hook to print a blank line before each new prompt (but not the first one)
# Doing this way means the PROMPT doesn't have to, which helps in iTerm2 with marks so
# that the mark is placed on the prompt line and not the blank link preceding it.
precmd() {
  precmd() {
    echo
  }
}

# Set default prompt color, change to red if previous command exited non-zero
prompt_color=%(?.$fg[yellow].$fg[red])

PROMPT="%{$terminfo[bold]$prompt_color%}❯ %{$reset_color%}"
RPROMPT=
