#!/bin/bash
#
# Referred to https://github.com/MashMB/nvim-ide
# Also, kickstart nvim is a good place to look. https://github.com/nvim-lua/kickstart.nvim
# Check out these videos or repos.
# - https://www.youtube.com/watch?v=stqUbv-5u2s
# - https://www.youtube.com/watch?v=NL8D8EkphUw
# - https://github.com/LunarVim/Neovim-from-scratch
# - https://www.youtube.com/watch?v=jrFjtwm-R94
# Also consider using pre-configured/packaged versions
# - https://www.lunarvim.org/
# - https://nvchad.com/
# - https://www.lazyvim.org/

# Install nvim language supprt and tools
pip3 install pynvim
npm i -g neovim

# Install vim plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Configure nvim
mkdir -p ~/.config/nvim
#git clone https://github.com/imaimaibah/nvim-ide.git && \
#	 tar c -C  nvim-ide/nvim/config ./ | tar x -C ~/.config/nvim/ && \
#	 tar c -C nvim-ide/nvim-go/config ./ | tar x -C ~/.config/nvim/ && \
#	 rm -rf nvim-ide
curl https://api.github.com/repos/imaimaibah/nvim-ide/tarball/master -L |
  tar zx --strip-components=3 -C ~/.config/nvim '*/nvim/config' 

sed -i "" 's#/root#~#' ~/.config/nvim/init.vim
#sed -i "" '16,25s#.*#"&#' ~/.config/nvim/coc/coc.vim
sed -i "" '16,25s#^#"#' ~/.config/nvim/coc/coc.vim

# Install plugins
nvim --headless +PlugInstall +qall 2>/dev/null

# Set up COC
mkdir -p ~/.config/coc/extensions
go install golang.org/x/tools/gopls@latest
COC='coc-css coc-eslint coc-html coc-json coc-sh coc-sql coc-tsserver coc-yaml coc-go'
cd ~/.config/coc/extensions && npm install $(echo $COC) --global --only=prod && cd -
cd ~/.config/nvim/plugins/vimspector && python3 install_gadget.py --enable-go && go install github.com/go-delve/delve/cmd/dlv@latest && cd -
