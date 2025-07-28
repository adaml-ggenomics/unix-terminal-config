# ~/.dotfiles/common/history.sh

# 1️⃣ Where to store your history
export HISTFILE="${HISTFILE:-$HOME/.history}"

if [ -n "${BASH_VERSION-}" ]; then
  ### — Bash history setup — ###
  # Number of entries in memory/history-file
  export HISTSIZE=5000
  export HISTFILESIZE=20000

  # Don’t record duplicates or commands starting with a space
  export HISTCONTROL=ignoredups:ignorespace
  # Commands to ignore entirely
  export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

  # Store timestamp in history
  export HISTTIMEFORMAT='%F %T '

  # Always append, don’t overwrite on shell exit
  shopt -s histappend

  # Immediately write to the history file, so other shells see it
  PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

  # Make reverse-search (Ctrl-R) incremental and case-insensitive
  bind '"\e[A": history-search-backward'
  bind '"\e[B": history-search-forward'
  bind 'set show-all-if-ambiguous on'
  bind 'set completion-ignore-case on'

elif [ -n "${ZSH_VERSION-}" ]; then
  ### — Zsh history setup — ###
  # Number of entries in memory & to save to file
  HISTSIZE=5000
  SAVEHIST=20000

  # Share history across sessions and append, don’t overwrite
  setopt APPEND_HISTORY       # append new commands
  setopt SHARE_HISTORY        # share across all zsh sessions

  # Ignore duplicate commands & those that start with space
  setopt HIST_IGNORE_DUPS
  setopt HIST_IGNORE_SPACE

  # Record timestamp (epoch + human-readable) for each entry
  setopt EXTENDED_HISTORY

  # Make fzf-style Ctrl-R if you have fzf-history-widget
  if type fzf-history-widget &>/dev/null; then
    bindkey '^R' fzf-history-widget
  fi
fi