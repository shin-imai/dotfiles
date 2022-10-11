#!/bin/bash

brew install neovim

pip3 install pynvim

if [ ! command -v npm ];then
	npm i -g neovim
fi

mkdir -p ~/.local/share/nvim/site/spell

curl -fLo ~/.local/share/nvim/site/spell/uk.utf-8.spl 'https://raw.githubusercontent.com/MashMB/nvim-ide/master/nvim/spell/uk.utf-8.spl'


curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim

git clone https://github.com/MashMB/nvim-ide.git && \
	tar c -C  nvim-ide/nvim/config ./ | tar x -C ~/.config/nvim/ && \
	tar c -C nvim-ide/nvim-go/config ./ | tar x -C ~/.config/nvim/ && \
	rm -rf nvim-ide

sed -i "" 's#/root#~#' ~/.config/nvim/init.vim

nvim --headless +PlugInstall +qall 2>/dev/null

mkdir -p ~/.config/coc/extensions

go install golang.org/x/tools/gopls@latest

COC='coc-css coc-eslint coc-html coc-json coc-sh coc-sql coc-tsserver coc-yaml coc-go'

cd ~/.config/coc/extensions && npm install $(echo $COC) --global --only=prod && cd -

cd ~/.config/nvim/plugins/vimspector && python3 install_gadget.py --enable-go && go install github.com/go-delve/delve/cmd/dlv@latest && cd -


