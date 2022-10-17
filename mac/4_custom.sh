#!/bin/zsh
#
cat <<'EOF' > ~/.zshrc_custom
set -o vi
alias vi=nvim
alias lg=lazygit
alias gf="git flow"
bindkey "^R" history-incremental-search-backward
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export EDITOR=nvim
EOF

echo 'source ~/.zshrc_custom' >> ~/.zshrc
