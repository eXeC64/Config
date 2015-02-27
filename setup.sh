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

require_sudo() {
  sudo echo -n
  if [[ $? -ne 0 ]]; then
    echo "You don't have permission to use sudo. Aborting."
    exit -1
  fi
}

declare -A arch_packages ubuntu_packages

add_package() {
  if [[ $# -lt 3 ]]; then
    return -1
  fi
  group=$1

  declare -i i j
  for ((i=2; i + 1<= $#; i += 2))
  do
    j=i+1
    platform=${!i}
    package=${!j}

    case $platform in
    all)
      arch_packages[$group]=$(echo "${arch_packages[$group]} $package" | sed 's/^\s*//')
      ubuntu_packages[$group]=$(echo "${ubuntu_packages[$group]} $package" | sed 's/^\s*//')
    ;;
    arch)
      arch_packages[$group]=$(echo "${arch_packages[$group]} $package" | sed 's/^\s*//')
    ;;
    ubuntu)
      ubuntu_packages[$group]=$(echo "${ubuntu_packages[$group]} $package" | sed 's/^\s*//')
    ;;
    *)
      echo "Unknown platform: $platform"
      exit -1
    ;;
    esac

  done
}

add_package term all zsh
add_package term all htop
add_package term all python
add_package term all rsync
add_package term arch the_silver_searcher ubuntu silversearcher-ag
add_package term all sudo
add_package term all unrar
add_package term all unzip
add_package term all weechat
add_package term all wget
add_package term all zsh
add_package term arch inxi
add_package term arch openssh ubuntu "openssh-client openssh-server"

add_package desktop all evince
add_package desktop all i3
add_package desktop arch gvim ubuntu vim-gnome
add_package desktop all rxvt-unicode
add_package desktop all scrot
add_package desktop all thunderbird
add_package desktop all ttf-dejavu
add_package desktop all ttf-freefont
add_package desktop arch ttf-inconsolata
add_package desktop arch ttf-symbola
add_package desktop arch xorg

add_package devel arch base-devel ubuntu build-essential
add_package devel arch clang ubuntu "clang-3.5 clang-format-3.5"
add_package devel all cppcheck
add_package devel arch ctags ubuntu exuberant-ctags
add_package devel all git

do_install() {
  echo " * Installing system"
  echo "   - Checking sudo"
  require_sudo
  echo "   - Installing packages"
  if [[ $os == "Arch" ]]; then
    to_install=""
    for group in "${!arch_packages[@]}"
    do
      read -p "     - Install packages in \"$group\"? [Yn]: " choice
      if [[ $choice =~ ^y || $choice =~ ^Y || -z $choice ]]; then
        to_install="$to_install ${arch_packages[$group]}"
      fi
    done
    echo "     - Installing $to_install"
    sudo pacman -Sy --quiet --needed --noconfirm $to_install
  elif [[ $os == "Ubuntu" ]]; then
    to_install=""
    for group in "${!ubuntu_packages[@]}"
    do
      read -p "     - Install packages in \"$group\"? [Yn]: " choice
      if [[ $choice =~ ^y || $choice =~ ^Y || -z $choice ]]; then
        to_install="$to_install ${ubuntu_packages[$group]}"
      fi
    done
    echo "     - Installing $to_install"
    sudo apt-get update
    sudo apt-get install -y $to_install
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
