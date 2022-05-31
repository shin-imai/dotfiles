### General ###
set -o vi
export EDITOR=vi
export TERM=xterm-256color
export LOCALBIN=~/.local/bin

### Locale ###
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
export LC_ALL=en_US.UTF-8

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

export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/golib
clear
