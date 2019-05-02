#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias v="vi"
alias va=". venv/bin/activate"
alias sshwh='ssh -p 5550 warehouse'
alias sshpi='ssh pi@vlpi.local'
alias jd='j ~/.dotfiles'
alias trn='tmux rename-window'
alias gst='git status'
alias r='ranger'
alias sshpibot='ssh pi@pibot.local'

# SFDX-related aliases
alias sfol='sfdx force:org:list'
alias sfpl='sfdx force:package:list'
alias sfo='sfdx force:org:open'
alias sfop='sfdx force:org:open --path /lightning/n/LexNewTeamPage'
alias sfpush='sfdx force:source:push'
alias sfpull='sfdx force:source:pull'
alias sfstat='sfdx force:source:status'

# Taskwarrior-related aliases
alias ta='task add'
alias ts='task sync'

# Docker-related aliases
# alias dk='docker'
# alias denv='eval "$(docker-machine env default)"'
# alias dpg='docker rm $(docker ps -a -q -f status=exited) && docker images -q --filter "dangling=true" | xargs docker rmi'
# alias dcu='docker-compose up'
# alias dcub='docker-compose up --build --remove-orphans'
# alias dcs='docker-compose stop'
# alias dcr='docker-compose restart'
# alias dcl='docker-compose logs'
# alias dps='docker ps -a'
# dksh() { docker exec -it $1 bash }

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

# blade guard off rm and clobbering
unalias rm
setopt clobber

# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# add my local bin and locally-installed Python commands to path
# export PATH=~/bin:$PATH:~/Library/Python/2.7/bin
export PATH=~/bin:/usr/local/opt/python@2/bin:$PATH

# add Android ADB to path
export PATH=$PATH:~/Library/Android/sdk/platform-tools

# add PlatformIO to path
export PATH=$PATH:~/.platformio/penv/bin

# add my local python libraries and encode with UTF-8
export PYTHONPATH=~/lab/vllib
export PYTHONIOENCODING=UTF-8

# and enable virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/lab
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@2/bin/python2
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

# VL account info
export VL_ACCOUNTS=$HOME/lab/vlocity/instance/accounts.csv

# Theme thing
export POWERLEVEL9K_MODE='nerdfont-complete'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
