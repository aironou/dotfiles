export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"

CASE_SENSITIVE="false"

HYPHEN_INSENSITIVE="true"

DISABLE_AUTO_UPDATE="false"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="yyyy-mm-dd"

plugins=(command-not-found compleat dircycle git httpie pip screen sudo)

source $ZSH/oh-my-zsh.sh

if [[ ! $DISPLAY ]]; then
  export EDITOR='vim'
else
  export EDITOR='atom -w'
fi

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin
