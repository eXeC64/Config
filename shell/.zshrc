HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt PROMPT_SUBST

bindkey -e
zstyle :compinstall filename '/home/harry/.zshrc'

TERMINAL=urxvt

autoload -Uz compinit
autoload -U colors && colors
compinit

function git_prompt()
{
  git branch 2>/dev/null | grep '*' | sed 's/^* //'
}

PROMPT='╭─%{$fg[blue]%}%n@%M %{$fg[green]%}%~/ $fg[red]$(git_prompt) %{$reset_color%}
╰─[%?]»'

alias ls="ls -hF  --color=auto"
alias ll="ls -lhF --color=auto"
alias la="ls -alhF --color=auto"

alias cp="cp -ri"
alias mv="mv -i"
alias rm="rm -i"

alias g="git"
alias gi="git"

alias gdb="gdb --quiet"

alias vol="alsamixer"

alias dup="( urxvt & ) &>/dev/null"

alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip'

alias pacman="sudo pacman --color auto"

eval $(dircolors ~/.dircolors)

export GOPATH=$HOME/Coding/golang
export EDITOR=vim
