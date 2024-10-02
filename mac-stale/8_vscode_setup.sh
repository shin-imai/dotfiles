#!/bin/zsh


if [ -f ~/Library/Application\ Support/Code/User/settings.json ];then
  tmp=mktemp
  cat ~/Library/Application\ Support/Code/User/settings.json |jq '. += {"terminal.integrated.fontFamily": "FiraCode Nerd Font"}' > $tmp
  cat $tmp > ~/Library/Application\ Support/Code/User/settings.json
  rm -f $tmp
else
  echo "{}" |jq '. += {"terminal.integrated.fontFamily": "FiraCode Nerd Font"}' > ~/Library/Application\ Support/Code/User/settings.json
fi

