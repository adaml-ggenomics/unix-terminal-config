# PATH exports from user's current zshrc
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/Library/Application Support/iODBC/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Docker CLI completions (macOS specific)
if [[ "$(uname)" == "Darwin" ]]; then
    # The following lines have been added by Docker Desktop to enable Docker CLI completions.
    fpath=(/Users/$USER/.docker/completions $fpath)
    autoload -Uz compinit
    compinit
    # End of Docker CLI completions
fi
