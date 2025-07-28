
# Colors
RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
BLUE='\[\e[34m\]'
RESET='\[\e[0m\]'


# Function to get the current git branch (if inside a git repo)
parse_git_branch() {
  # Only proceed if inside a git repo
  git rev-parse --is-inside-work-tree &>/dev/null || return

  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  dirty=$(git status --porcelain 2>/dev/null)

  # Append a * if dirty
  if [[ -n $dirty ]]; then
    echo " (on ${branch}*)"
  else
    echo " (on ${branch})"
  fi
}

# 2) Detect Bash vs Zsh
if [ -n "${BASH_VERSION-}" ]; then
  # —— Bash setup —— #
  # Define colors (non-printing with \[ \])
  RED='\[\e[31m\]'
  GREEN='\[\e[32m\]'
  BLUE='\[\e[34m\]'
  RESET='\[\e[0m\]'

  # Export PS1
  export PS1="${BLUE}\u@\h ${GREEN}\w${RED}\$(parse_git_branch)${RESET}\n\$ "

elif [ -n "${ZSH_VERSION-}" ]; then
  # —— Zsh setup —— #
  # Tell zsh to allow $(…) in PROMPT
  setopt PROMPT_SUBST

  # Use zsh’s built-in %F{color} escapes (zero-width for you)
  # You can also load `autoload -U colors; colors` and use $fg, but we'll use %F directly:
  PROMPT='%F{blue}%n@%m %F{green}%~%F{red}$(parse_git_branch)%f
$ '

else
  # Neither bash nor zsh? Fallback to plain
  export PS1='\u@\h \w\$ '
fi