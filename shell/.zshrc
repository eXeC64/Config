HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/harry/.zshrc'

TERMINAL=urxvt

autoload -Uz compinit
autoload -U colors && colors
compinit

PROMPT="%{$fg[blue]%}%n@%M %{$fg[green]%}%~/%{$reset_color%}
[%?] » "

alias ls="ls -F --color=auto"
alias ll="ls -lF --color=auto"
alias la="ls -alF --color=auto"

alias cp="cp -ri"
alias mv="mv -i"
alias rm="rm -i"

alias g="git"

alias vol="alsamixer"

alias dup="( urxvt & ) &>/dev/null"

alias pacman="sudo pacman --color auto"

eval $(dircolors ~/.dircolors)

export GOPATH=$HOME/Coding/golang
export EDITOR=vim
