#!/bin/zsh

# Setup custom zsh
cat <<'EOF' > ~/.zshrc_custom
alias vi=nvim
alias lg=lazygit
alias gf="git flow"
bindkey "^R" history-incremental-search-backward
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.local/bin:$PATH"
export EDITOR=nvim
EOF
if ! grep -q .zshrc_custom ~/.zshrc ;then
  echo 'source ~/.zshrc_custom' >> ~/.zshrc
fi

# Set up tmuxbar
if ! grep -q '^#   ___  _ __(_) __ _(_)_ __   __ _| |' ~/.tmux.conf.local;then
cat <<'EOF' >> ~/.tmux.conf.local
#             _       _             _
#   ___  _ __(_) __ _(_)_ __   __ _| |
#  / _ \| '__| |/ _` | | '_ \ / _` | |
# | (_) | |  | | (_| | | | | | (_| | |
#  \___/|_|  |_|\__, |_|_| |_|\__,_|_|
#               |___/

tmux_conf_theme_window_bg='colour240'
tmux_conf_theme_highlight_focused_pane=true
tmux_conf_theme_focused_pane_fg='default'
tmux_conf_theme_focused_pane_bg='#002b36'
tmux_conf_theme_status_right_bg='#080808' # dark gray,
tmux_conf_theme_left_separator_main='\uE0B0'
tmux_conf_theme_left_separator_sub='\uE0B1'
tmux_conf_theme_right_separator_main='\uE0B2'
tmux_conf_theme_right_separator_sub='\uE0B3'


# Change Prefix to T
unbind C-b
unbind C-c
set -g prefix C-t

# Window Switch
bind-key -n F1 select-window -t :1
bind-key -n F2 select-window -t :2
bind-key -n F3 select-window -t :3
bind-key -n F4 select-window -t :4
bind-key -n F5 select-window -t :5
bind-key -n F6 select-window -t :6

# Synchronize Panes
#bind C-c set-window-option synchronize-panes
bind C-n set-window-option synchronize-panes

# Gitbar
#source-file "$HOME/.tmux-gitbar/tmux-gitbar.tmux"
#tmux_conf_theme_status_left_bg='#8a8a8a,#ff00af,#00afff'  # yellow, pink, white blue
tmux_conf_theme_status_left=' 🍺 #S '
#tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized} %R , %d %b | #{username}#{root} | #{hostname} | #(/bin/bash $HOME/.tmux-kube/kube.tmux 250 red cyan) | #(gitmux "#{pane_current_path}")'
#tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized} %R , %d %b | #{username} | #{root} | #($HOME/.local/bin/gitmux "#{pane_current_path}")'
tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized} %R , %d %b , #(/bin/bash $HOME/.tmux/kube-tmux/kube.tmux 250 red cyan) , #($HOME/.local/bin/gitmux "#{pane_current_path}")'
EOF
fi

cat <<EOF > ~/.local/bin/docker
#!/bin/sh
set -eu
: "${LIMA_INSTANCE:=docker}"

export LIMA_INSTANCE
exec lima docker "$@"
EOF
chmod +x ~/.local/bin/docker
