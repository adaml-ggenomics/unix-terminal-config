# 1) Load the system’s bash completion framework
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
elif [ -n "$(brew --prefix 2>/dev/null)" ] && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  source "$(brew --prefix)/etc/bash_completion"
fi

# 3) Menu-style & cycling completions
bind '"\e[Z":menu-complete'   # Shift-TAB for menu-complete
bind '"\t":complete'          # Tab for normal completion
