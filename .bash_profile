### General ###
set -o vi
export EDITOR=vi
export TERM=xterm-256color
export LOCALBIN=~/.local/bin

if [ -d $LOCALBIN ];then
	PATH=$PATH:$LOCALBIN
fi

### Command history ###
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

### Include others ###
. ~/.bash_aliases
. ~/.bash_prompt
. ~/.bash_func
. ~/.kuberc

### vi scheme ###
if [ ! -d ~/.vim/pack/default/start/gruvbox ];then
	git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox
fi

### git setup ###
if which git &>/dev/null && ! grep -q vimdiff .gitconfig;then
	git config --global difftool.prompt false
	git config --global diff.tool vimdiff
	git config --global merge.tool vimdiff
fi


