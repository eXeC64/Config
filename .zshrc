# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/harry/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT="%n@%M %# "
RPROMPT=""

alias ls="ls -F --color=auto"
alias ll="ls -lF --color=auto"
alias la="ls -alF --color=auto"

alias cp="cp -ri"
alias mv="mv -i"
alias rm="rm -i"

eval $(dircolors ~/.dircolors)
