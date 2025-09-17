# system
alias ll="ls -alh"
alias ..="cd .."
alias zshedit="vim ~/.zshrc"
alias zshrefresh="source ~/.zshrc"
alias bashedit="vim ~/.bashrc"
alias bashrefresh="source ~/.bashrc"
alias cls="clear"

# git
alias g="git"
alias gaa="git add ."
alias gc="git commit"
alias gs="git status"
alias gp="git pull"
alias gf="git fetch"
alias gd="git diff"
alias gds="git diff --staged"
alias gcb="git checkout -b"
alias ggm="git checkout main"

# docker
alias dc="docker compose"
alias dcp="dc exec app php artisan"
alias dcea="dc exec app"
alias dcr="dc down && dc up -d"
alias dcrr="dc down && dc up -d --build"
alias dcl="dc logs -f"
alias dcps="dc ps"
alias dps="docker ps"

# Laravel/Php (in docker)
alias reseed="dcp migrate:fresh --seed"
alias swagger="dcp l5-swagger:generate"

# Kubernetes
alias k="kubectl"
alias kgp='kubectl get pods'          
alias kgs='kubectl get svc'           
alias kgd='kubectl get deployments'   
alias kctx='kubectl config use-context'
alias kns='kubectl config set-context --current --namespace'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'

