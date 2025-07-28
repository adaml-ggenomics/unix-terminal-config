# 1) Load the system’s bash completion framework
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
elif [ -n "$(brew --prefix 2>/dev/null)" ] && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  source "$(brew --prefix)/etc/bash_completion"
fi

# 2) fzf integration for Bash
if [ -f "${HOME}/.fzf/shell/completion.bash" ]; then
  source "${HOME}/.fzf/shell/completion.bash"
  source "${HOME}/.fzf/shell/key-bindings.bash"
fi

# 3) Menu-style & cycling completions
bind '"\e[Z":menu-complete'   # Shift-TAB for menu-complete
bind '"\t":complete'          # Tab for normal completion

# 4) Simple fzf-based autosuggest (right-arrow)
if type fzf-history-widget >/dev/null 2>&1; then
  bind -x '"\e[C": fzf-history-widget'
fi