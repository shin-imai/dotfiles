#!/bin/zsh

cat ~/Library/Application\ Support/Code/User/settings.json |jq '. += {"terminal.integrated.fontFamily": "FiraCode Nerd Font"}'
