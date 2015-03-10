#!/bin/bash

config_dir=$(dirname $0)

declare -a platforms
declare -A update_command
declare -A upgrade_command
declare -A install_command

. $config_dir/system.conf

detect_platform

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

declare -A packages

#used in system.conf
add_package() {
  if [[ $# -lt 3 ]]; then
    return -1
  fi
  group=$1

  declare -i i j
  for ((i=2; i + 1<= $#; i += 2))
  do
    j=i+1
    pkg_platform=${!i}
    package=${!j}

    if [[ $pkg_platform == $platform || $pkg_platform == all ]]; then
      packages[$group]="${packages[$group]} $package"
    fi
  done
}

add_packages

do_install() {
  echo " * Installing system"
  echo "   - Checking sudo"
  require_sudo
  echo "   - Updating package lists"
  out=$(sudo ${update_command[$platform]:?"error: update_command not set for $platform"} 2>&1)
  if [[ $? -ne 0 ]]; then
    echo "==============================================="
    echo "Error whilst updating package lists. Log below:"
    echo "==============================================="
    echo "$out"
    exit -1
  fi
  echo "   - Upgrading installed packages"
  out=$(sudo ${upgrade_command[$platform]:?"error: upgrade_command not set for $platform"} 2>&1)
  if [[ $? -ne 0 ]]; then
    echo "=================================================="
    echo "Error whilst upgrading installed lists. Log below:"
    echo "=================================================="
    echo "$out"
    exit -1
  fi
  to_install=""
  for group in "${!packages[@]}"
  do
    read -p "   - Install packages in \"$group\"? [Yn]: " choice
    if [[ $choice =~ ^y || $choice =~ ^Y || -z $choice ]]; then
      to_install="$to_install ${packages[$group]}"
    fi
  done
  to_install=$(echo $to_install | sed 's/^\s*//;s/\s*$//;')
  echo "   - Installing packages:"
  for package in $to_install; do
    echo "     - $package"
  done
  out=$(sudo ${install_command[$platform]:?"error: install_command not set for $platform"} $to_install 2>&1)
  if [[ $? -ne 0 ]]; then
    echo "============================================"
    echo "Error whilst installing packages. Log below:"
    echo "============================================"
    echo "$out"
    exit -1
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

print_usage() { echo "Usage: $0 <install|config|everything>"; }

if [[ $# -lt 1 ]]; then
  print_usage
  exit -1
fi

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
