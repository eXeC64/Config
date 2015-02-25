TERMINAL=urxvt
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
setopt SHARE_HISTORY
setopt PROMPT_SUBST
bindkey -e
zstyle :compinstall filename $HOME/.zshrc

autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit
autoload -Uz colors && colors
eval $(dircolors ~/.dircolors)

#Exported variables
export GOPATH=$HOME/Coding/golang
export EDITOR=vim

#Prompt configuration
print_timestamp() { date +"$fg[blue][%T]$reset_color" }
add-zsh-hook preexec print_timestamp
git_prompt() { git branch 2>/dev/null | sed -e '/^* /!d' -e 's/^* //' }
PROMPT='\
╭─%{$fg[blue]%}%n@%M %{$fg[green]%}%~/ $fg[red]$(git_prompt) %{$fg[blue]%}$(date +"[%T]") %{$reset_color%}
╰─[%?]»'

#Aliases
alias ag='ag --pager "less -FRS"'
alias apt-get="sudo apt-get"
alias cp="cp -ri"
alias dup="( $TERMINAL & ) &>/dev/null"
alias g=git
alias gi=git
alias gdb="gdb --quiet"
alias j=jobs
alias ls="ls -hF  --color=auto"
alias ll="ls -lhF --color=auto"
alias la="ls -alhF --color=auto"
alias mv="mv -i"
alias pacman="sudo pacman --color auto"
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip'
alias vol=alsamixer

fg() { builtin fg %$1 }
bg() { builtin bg %$1 }
