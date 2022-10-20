#!/bin/zsh

tmp=mktemp

cat ~/Library/Application\ Support/Code/User/settings.json |jq '. += {"terminal.integrated.fontFamily": "FiraCode Nerd Font"}' > $tmp
cat $tmp > ~/Library/Application\ Support/Code/User/settings.json
rm -f $tmp
