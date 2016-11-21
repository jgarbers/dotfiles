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
alias sshbh='ssh -i ~/.ssh/bluehost eitwoonl@ei2online.org'
alias jd='j ~/.dotfiles'

alias trn='tmux rename-window'

alias denv='eval "$(docker-machine env default)"'
alias dpg='docker rm $(docker ps -a -q -f status=exited)'
alias dcu='docker-compose up'
alias dcs='docker-compose stop'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs'
alias dps='docker ps -a'
dsh() { docker exec -it $1 bash }

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
