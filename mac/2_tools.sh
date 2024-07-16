#!/bin/zsh

# Install tools via brew
# Not sure if fzf is needed. I might remove fzf from neovim, too.
# Remove git-delta & diff-so-fancy
brew instal kubectl tmux git-flow-avh bat eza go nodejs glow lazygit fzf fd ripgrep jq yq neovim colima helm helmfile terraform mdomke/git-semver/git-semver

# install stuff via cask
brew install --cask iterm2 visual-studio-code slack

# Install helm plugins
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/jkroepke/helm-secrets

# This is usuful tool to obtain values from tfstate. https://github.com/fujiwara/tfstate-lookup
# brew install fujiwara/tap/tfstate-lookup

# File Encryption tool https://github.com/FiloSottile/age/
# brew install age

# Secret operations. https://github.com/getsops/sops

# vals is a tool to get values from remote storage/secret services. https://github.com/helmfile/vals


# Install Krew and plugins
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
  ~/.krew/bin/kubectl-krew install ctx ns stern
)

# Install tmux stuff
## tmux bar
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf .tmux.conf
cp .tmux/.tmux.conf.local .
cd -

## Gitmux
LOCALBIN=~/.local/bin
mkdir -p $LOCALBIN
URL=$(curl -fLsq https://api.github.com/repos/arl/gitmux/releases/latest | 
  awk '$1~/download_url/ && $2~/macOS_arm64/ {print $2}' | tr -d '"')
curl -Lsqf $URL | tar zx -C $LOCALBIN/ && chmod +x $LOCALBIN/gitmux || echo "Downloadin gitmux failed"

## kube-tmux
git clone https://github.com/imaimaibah/kube-tmux.git ~/.tmux/kube-tmux
