#!/usr/bin/env zsh

# ——— 1) Enable and configure zsh's completion system ———
# Case-insensitive tab completion (matches your zshrc)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

autoload -U +X bashcompinit && bashcompinit

# Tab completion
autoload -Uz compinit
autoload -U +X compinit
compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ——— 2) Kubectl completion ———
# Source kubectl completion and set up alias completion
source <(kubectl completion zsh)
complete -F __start_kubectl kk

# ——— 3) zsh-autosuggestions ———
# (Shows you the rest of your command as you type, accept with →)
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ——— 4) zsh-syntax-highlighting ———
# (Highlights valid commands green, errors red, etc.)
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi