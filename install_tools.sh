#!/bin/bash

OS=$(uname | tr '[:upper:]' '[:lower:]')

### Local bin ###
LOCALBIN=~/.local/bin

if [ ! -d $LOCALBIN ];then
	mkdir -p $LOCALBIN
fi


if ! command -v curl &>/dev/null;then
	echo "curl isn't installed"
	exit 127
fi

if ! command -v git &>/dev/null;then
	echo "git isn't installed"
	exit 127
fi

install_kubectl(){
	local VER=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
	curl -o $LOCALBIN/kubectl -fLsq \
		https://storage.googleapis.com/kubernetes-release/release/${VER}/bin/linux/amd64/kubectl &&
	chmod +x $LOCALBIN/kubectl
}

install_yq(){
	local URL
	URL=$(curl -Lfsq https://api.github.com/repos/mikefarah/yq/releases/latest |
		awk '$1~/download_url/ && $2~/yq_'${OS}'_amd64"$/ {print $2}'|tr -d '"')
	curl -o $LOCALBIN/yq -Lsqf $URL && chmod +x $LOCALBIN/yq || echo "Downloadin yq failed"
}

install_jq(){
	local URL
	URL=$(curl -fLsq https://api.github.com/repos/stedolan/jq/releases/latest |
		awk '$1~/download_url/ && $2~/'${OS}'64/ {print $2}' | tr -d '"')
	curl -o $LOCALBIN/jq -Lsqf $URL  && chmod +x $LOCALBIN/jq || echo "Downloading jq failed"
}

install_gitmux(){
	local URL
	URL=$(curl -fLsq https://api.github.com/repos/arl/gitmux/releases/latest | 
		awk '$1~/download_url/ && $2~/'${OS}'_amd64/ {print $2}' | tr -d '"')
	curl -Lsqf $URL | tar zx -C $LOCALBIN/ && chmod +x $LOCALBIN/gitmux || echo "Downloadin gitmux failed"
}

install_tmuxbar(){
	cd
	git clone https://github.com/gpakosz/.tmux.git
	ln -s -f .tmux/.tmux.conf
	cp .tmux/.tmux.conf.local .
  cd -
}

if ! command -v kubectl &>/dev/null;then
	install_kubectl
fi

if ! command -v yq &>/dev/null;then
	install_yq
fi

if ! command -v jq &>/dev/null;then
	install_jq
fi

### gitmux install
if ! command -v gitmux &>/dev/null;then
	install_gitmux
fi

### tmuxbar install
if [ ! -d ~/.tmux ] && command -v git &>/dev/null;then
	install_tmuxbar
fi

### kube-ps1 install
if [ ! -f ~/.local/bin/kube-ps1.sh ];then
	curl https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh >\
		~/.local/bin/kube-ps1.sh
fi

### krew & ctx/ns ###
if [ ! -f ~/.krew/bin/kubectl-krew ];then
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
  ~/.krew/bin/kubectl-krew install ctx ns
)
fi


