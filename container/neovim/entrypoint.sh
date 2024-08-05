#!/bin/zsh

function init() {
  (
    mkdir -p ~/.config/dotfiles
    cd ~/.config/dotfiles
    git clone https://github.com/imaimaibah/dotfiles.git .
    sed -i 's#git@github.com:#https://github.com/#' .git/config .gitmodules
    git submodule update --init --recursive
  )

  (
    cd ~/.config/dotfiles
    ./3_ohmyzsh.sh
    ./5_setup_tools.sh
    ./7_setup_git.sh
  )

  pipx install pre-commit
}

function main() {
  if [ ! -d ~/.config/dotfiles ];then
    init
  fi
  /bin/zsh $@
}

main $@
