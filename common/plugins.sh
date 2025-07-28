if [ -f "${HOME}/.fzf/shell/completion.zsh" ] && [ -n "${ZSH_VERSION-}" ]; then
  source "${HOME}/.fzf/shell/completion.zsh"
elif [ -f "${HOME}/.fzf/shell/completion.bash" ] && [ -n "${BASH_VERSION-}" ]; then
  source "${HOME}/.fzf/shell/completion.bash"
fi

if [ -f "${HOME}/.fzf/shell/key-bindings.zsh" ] && [ -n "${ZSH_VERSION-}" ]; then
  source "${HOME}/.fzf/shell/key-bindings.zsh"
elif [ -f "${HOME}/.fzf/shell/key-bindings.bash" ] && [ -n "${BASH_VERSION-}" ]; then
  source "${HOME}/.fzf/shell/key-bindings.bash"
fi