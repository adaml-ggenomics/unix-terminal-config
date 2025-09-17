# Docker Compose & PHP/Laravel aliases
alias dcp="dc exec app php artisan"
alias phptest="dc exec test php artisan test"
alias pa="php artisan"
alias patest="php artisan test"
alias dc="docker compose"
alias dcr="dc down && dc up -d"
alias dcrr="dc down && dc up -d --build"

# Git aliases
alias gaa="git add ."
alias gc="git commit"
alias gs="git status"
alias gp="git pull"
alias gf="git fetch"
alias gd="git diff"
alias gcb="git checkout -b"

# System aliases
alias ll="ls -alh"
alias ..="cd .."
alias zshedit="vim ~/.zshrc"
alias refresh="source ~/.zshrc"

# Kubernetes
alias kk="kubectl"

