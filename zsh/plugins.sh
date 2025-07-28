# ~/.dotfiles/zsh/plugins.sh

# ——— 1) Enable and configure zsh's completion system ———
autoload -Uz compinit
# Prevent “compinit insecure directory” warnings if you’re symlinking
compinit -u

# Make the completion list interactive
zstyle ':completion:*:default' menu select
# Case-insensitive matching (“git st” → git status)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ——— 2) Bind TAB to cycle matches ———
# Complete-word will cycle through alternatives on repeated TAB
bindkey '^I' complete-word

# ——— 3) fzf integration (fuzzy search) ———
# If you’ve installed fzf in ~/.fzf, this wiring gives you:
#  - Ctrl-R to fuzzy-search history
#  - Tab to fuzzy-complete filenames/commands
if [ -d "${HOME}/.fzf" ]; then
  source "${HOME}/.fzf/shell/completion.zsh"   # completions
  source "${HOME}/.fzf/shell/key-bindings.zsh"  # key bindings
else
  # optional: auto-install if missing
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --bin                       # installs key-bindings & completion
  source ~/.fzf/shell/completion.zsh
  source ~/.fzf/shell/key-bindings.zsh
fi

# ——— 4) zsh-autosuggestions ———
# (Shows you the rest of your command as you type, accept with →)
AUTO_PLUGIN_DIR="${ZDOTDIR:-$HOME}/.dotfiles/zsh/plugins"
if [ ! -d "${AUTO_PLUGIN_DIR}/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "${AUTO_PLUGIN_DIR}/zsh-autosuggestions"
fi
source "${AUTO_PLUGIN_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ——— 5) zsh-syntax-highlighting ———
# (Highlights valid commands green, errors red, etc.)
if [ ! -d "${AUTO_PLUGIN_DIR}/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${AUTO_PLUGIN_DIR}/zsh-syntax-highlighting"
fi
source "${AUTO_PLUGIN_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"