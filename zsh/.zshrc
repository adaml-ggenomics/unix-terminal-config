# 1) Allow prompt substitution for parse_git_branch etc.
setopt PROMPT_SUBST

# 2) Define DOTFILES
DOTFILES="$HOME/.dotfiles"

# 3) Source common utilities (aliases, functions, history, prompt)
for f in "$DOTFILES/common/"*.sh; do
  # shellcheck disable=SC1090
  source "$f"
done

# 4) Source Zsh-specific plugins
if [ -f "$DOTFILES/zsh/plugins.sh" ]; then
  source "$DOTFILES/zsh/plugins.sh"
fi

# 5) Zsh-only tweaks
export EDITOR=vim