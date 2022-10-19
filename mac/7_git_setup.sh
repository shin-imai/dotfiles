#!/bin/zsh


git config --global user.name "Shin Imai"
git config --global user.email "binaryninja0101@yahoo.com"
git config --global difftool.vscode.cmd "code --wait --diff \$LOCAL \$REMOTE"
git config --global difftool.prompt false
git config --global merge.tool vimdiff
git config --global pull.rebase true
git config --global core.editor nvim
git config --global alias.d difftool
git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit"
git config --global alias.lola "log --graph --decorate --pretty=oneline --abbrev-commit --all"
git config --global alias.root "\!pwd"
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto