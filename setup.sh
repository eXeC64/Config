#!/bin/bash

#This script exists to set up my preferred environment on a clean install of
#Linux. It is currently designed to work on Arch Linux and Ubuntu, though it
#shouldn't be difficult to add support for other Linux distributions.

#Global options
config_dir="$HOME/Config"

print_usage() { echo "Usage: $0 <install|config|everything>"; }

if [[ $# -lt 1 ]]; then
  print_usage
  exit -1
fi

if [[ -f "/etc/arch-release" ]]; then
  os="Arch"
elif [[ -f "/etc/lsb-release" ]]; then
  os="Ubuntu"
fi

arch=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

if [[ $USER == "root" ]]; then
  echo "Please run this script as an ordinary user."
  exit -1
fi

check_sudo() {
  sudo echo -n
  if [[ $? -ne 0 ]]; then
    echo "You don't have permission to use sudo. Aborting."
    exit -1
  fi
}

common_packages=(
  clang
  evince
  git
  htop
  i3
  python
  rsync
  rxvt-unicode
  scrot
  sudo
  thunderbird
  ttf-dejavu
  ttf-freefont
  unrar
  unzip
  weechat
  wget
  zsh
 )

arch_packages=(
  ${common_packages[@]}
  base-devel
  gvim
  inxi
  openssh
  slim
  the_silver_searcher
  ttf-inconsolata
  ttf-symbola
  xorg
)

ubuntu_packages=(
  ${common_packages[@]}
  build-essential
  openssh-client
  openssh-server
  silversearcher-ag
  vim-gnome
)

do_install() {
  echo " * Installing system"
  echo "   - Checking sudo"
  check_sudo
  echo "   - Installing packages"
  if [[ $os == "Arch" ]]; then
    sudo pacman -Sy --quiet --needed --noconfirm ${arch_packages[@]}
  elif [[ $os == "Ubuntu" ]]; then
    sudo apt-get update
    sudo apt-get install -y ${ubuntu_packages[@]}
  fi
}

do_config() {
  echo " * Configuring system"

  if [[ -d $config_dir ]]; then
    echo "   - Config repo exists"
  else
    echo "   - Fetching config repo"
    git clone http://github.com/eXeC64/Config "$config_dir"
  fi

  #Create configuration symlinks
  echo "   - Updating symlinks"
  if [[ -e $HOME/bin ]]; then
    echo "     - $HOME/bin already exists - skipping"
  else
    echo "     - Linking bin to $HOME/bin"
    ln -s "$config_dir/bin" "$HOME/bin"
  fi

  for filename in $config_dir/dotfiles/*; do
    if [[ $filename == $config_dir'/dotfiles/*' ]]; then
      continue
    fi
    linkname="$HOME/$(basename $filename | sed 's/^_/./')"
    if [[ -e $linkname ]]; then
      echo "     - $linkname already exists - skipping"
    else
      echo "     - Linking $linkname to $filename"
      ln -s "$filename" "$linkname"
    fi
  done

  echo "   - Applying .Xresources"
  xrdb -merge $HOME/.Xresources

  if [[ ! -d $HOME/.vim/bundle/Vundle.vim ]]; then
    echo "   - Installing Vundle"
    git clone http://github.com/gmarik/Vundle.vim "$HOME/.vim/bundle/Vundle.vim"
  else
    echo "   - Vundle already installed"
  fi

  echo "   - Disabling Vim colorscheme"
  sed -i 's/^\s\+colorscheme/"&/' $HOME/.vimrc

  echo "   - Installing Vundle plugins"
  vim +PluginClean +PluginInstall +qall

  if [[ ! -e $HOME/.vim/colors ]]; then 
    echo "   - Installing colors symlink for solarized"
    ln -s $HOME/.vim/bundle/vim-colors-solarized/colors $HOME/.vim/colors
  elif
    [[ -L $Home/.vim/colors ]]; then
    echo "   - Colors symlink for solarized already in place"
  else
    echo "   - Colors directory exists - not creating symlink"
  fi

  echo "   - Re-enabling Vim colorscheme"
  sed -i 's/^"\(\s\+colorscheme\)/\1/' $HOME/.vimrc

  if [[ $SHELL != "/bin/zsh" ]]; then
    echo "   - Changing shell to zsh"
    chsh -s /bin/zsh
  else
    echo "   - Shell is correct"
  fi

}

case $1 in
install)
  do_install
;;
config)
  do_config
;;
everything)
  do_install
  do_config
;;
*)
  print_usage
  exit -1
;;
esac
