#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
# if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# fi

# PROMPT=$'%(?.%F{green}√.%F{red}\U2718)%f %B%F{33}%4~%f%b %# '
PROMPT=$'%f%B%F{33}%4~%f%b %# '
#
alias vi=nvim
alias sshwh='ssh -p 5550 warehouse'
alias jd='cd ~/.dotfiles'
alias trn='tmux rename-window'
alias swn='tmux rename-window `basename $PWD`'
alias gst='git status'
alias nav='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias r='ranger'
alias pvr='pipenv run'
alias pvp='pipenv run python'
alias cinit='INIT=~/bin/conda-init ; source "$INIT" ; CENV="$(basename "$PWD")" ; echo Activating conda environment $CENV ; conda activate $CENV'

alias todo="ag --color-line-number '1;36' --color-path '1;36' --ignore-case --print-long-lines --silent '(?:<!-- *)?(?:#|//|/\*+|<!--|--) *(TODO|FIXME|FIX|BUG|UGLY|HACK|NOTE|IDEA|REVIEW|DEBUG|OPTIMIZE)(?:\([^(]+\))?:?(?!\w)(?: *-->| *\*/|(?= *(?:[^:]//|/\*+|<!--|@|--))|((?: +[^\n@]*?)(?= *(?:[^:]//|/\*+|<!--|@|--))|(?: +[^@\n]+)?))'"
alias utc='date -u'

# SFDX-related aliases
# alias sfol='sfdx force:org:list'
# alias sfpl='sfdx force:package:list'
# alias sfo='sfdx force:org:open'
# alias sfop='sfdx force:org:open --path /lightning/n/LexNewTeamPage'
# alias sfpush='sfdx force:source:push'
# alias sfpull='sfdx force:source:pull'
# alias sfstat='sfdx force:source:status'

# Change to lab dir and set window title
cld () {
    cd ~/lab/$1 ; tmux rename-window $1
}

# Change to project root dir and maybe one in
cdp () {
    cd `git rev-parse --show-toplevel`/$1
}

# Current project aliases.
alias sbp='source bin/prep.sh'

# Docker-related aliases
alias dk='docker'
dksh() { docker exec -it $1 bash }
# alias denv='eval "$(docker-machine env default)"'
# alias dpg='docker rm $(docker ps -a -q -f status=exited) && docker images -q --filter "dangling=true" | xargs docker rmi'
# alias dcu='docker-compose up'
# alias dcub='docker-compose up --build --remove-orphans'
# alias dcs='docker-compose stop'
# alias dcr='docker-compose restart'
# alias dcl='docker-compose logs'
# alias dps='docker ps -a'

# Free up Ctrl-S and Ctrl-Q for mappings
stty -ixon -ixoff

# Vim integration per "Text Triumverate" guidelines
export EDITOR="/usr/local/bin/nvim"
bindkey -v 

export CLICOLOR=1

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward  

# blade guard off rm and clobbering
# unalias rm
setopt clobber

# twf integration.
alias cv='cd $(twf)'
twf-widget() {
  local selected=$(twf --height=0.5)
  BUFFER="$BUFFER$selected"
  zle reset-prompt
  zle end-of-line
  return $ret
}
zle -N twf-widget
bindkey '^V' twf-widget

# fzf integration.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable 'z' directory changing
source /usr/local/etc/profile.d/z.sh

# Add my local bin and locally-installed Python commands to path
path+=('~/bin' '/usr/local/bin' '/Users/jeffgarbers/Library/Python/3.7/bin' $path)

# Add Go tools to path
export PATH=$PATH:~/go/bin

# add pip --user tools to path
export PATH=$PATH:~/.local/bin
#
# add my own tools to path
export PATH=$PATH:~/bin

# add my local python libraries and encode with UTF-8
export PYTHONPATH=~/lab/vllib
export PYTHONIOENCODING=UTF-8

# and enable virtualenvwrapper
export PIPENV_IGNORE_VIRTUALENVS=1

# VL account info
export VL_ACCOUNTS=$HOME/lab/vlocity/instance/accounts.csv

# Theme thing
# export POWERLEVEL9K_MODE='nerdfont-complete'

# FZF options
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--preview "bat --color always {}" --bind ctrl-a:select-all'

# Essentials.
export COWPATH=$HOME/.cowsay

# Pyenv.
# export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_ROOT=~/.pyenv
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
# export PIPENV_PYTHON="$PYENV_ROOT/shims/python"

# C++ dev
# export CPLUS_INCLUDE_PATH=/usr/local/include
# export LIBRARY_PATH=/usr/local/lib

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Clean up path
typeset -U path

