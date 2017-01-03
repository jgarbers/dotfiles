#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias v="mvim"
alias sshwh='ssh -p 5550 warehouse'
alias jd='j ~/.dotfiles'

alias trn='tmux rename-window'

# Docker-related aliases
alias dk='docker'
alias denv='eval "$(docker-machine env default)"'
alias dpg='docker rm $(docker ps -a -q -f status=exited) && docker images -q --filter "dangling=true" | xargs docker rmi'
alias dcu='docker-compose up'
alias dcub='docker-compose up --build'
alias dcs='docker-compose stop'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs'
alias dps='docker ps -a'
alias dkbi='echo Rebuilding "${PWD##*/}" &&  docker build -t ranger/"${PWD##*/}" .'
alias dkr='echo Running solo service "${PWD##*/}" &&  docker build -t ranger/"${PWD##*/}" . && docker run -p 5000:5000 ranger/"${PWD##*/}"'
alias dkrt='echo Running tests for "${PWD##*/}" &&  docker run -t ranger/"${PWD##*/}" python -m unittest discover /ranger/tests'
alias dkip='docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'

dksh() { docker exec -it $1 bash }

# IPMI work aliases
alias ipt='ipmitool -I lanplus -H 127.0.0.1 -p 9001 -U admin -P password'

# Free up Ctrl-S and Ctrl-Q for mappings
stty -ixon -ixoff

# Vim integration per "Text Triumverate" guidelines
export EDITOR="vim"
bindkey -v 

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward  

# blade guard off rm
unalias rm

# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# add my local bin and locally-installed Python commands to path
export PATH=~/bin:$PATH:~/Library/Python/2.7/bin/
