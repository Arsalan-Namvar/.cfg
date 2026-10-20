# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

# >>> omarchy-pc-bundle: blesh >>>
# Fish-like autosuggestions, syntax highlighting, and enhanced completion for Bash.
if [[ $- == *i* ]] && [[ -r /usr/share/blesh/ble.sh ]]; then
  source /usr/share/blesh/ble.sh
fi
# <<< omarchy-pc-bundle: blesh <<<

# >>> aliases >>>
alias herdrcoder="herdr --remote main.dev.arsalan-namvar.coder"
alias activate="source .venv/bin/activate"
alias config='git --git-dir="$HOME/.cfg" --work-tree="$HOME"'
alias lconfig='lazygit --git-dir="$HOME/.cfg" --work-tree="$HOME"'
# <<< aliases <<<
. "$HOME/.local/share/../bin/env"

# >>> yazi exit in CWD >>>
function y() {
	local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
	command rm -f -- "$tmp"
}
# <<< yazi exit CWD <<<
