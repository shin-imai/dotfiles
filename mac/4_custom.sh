#!/bin/zsh

# Setup custom zsh
cat <<'EOF' > ~/.zshrc_custom
alias lg=lazygit
alias gf="git flow"
alias ls=exa
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
set -g status-position top
set -g detach-on-destroy off
tmux_conf_theme_window_bg='colour240'
tmux_conf_theme_highlight_focused_pane=true
tmux_conf_theme_focused_pane_fg='default'
tmux_conf_theme_focused_pane_bg='#002b36'
tmux_conf_theme_status_right_bg='#080808' # dark gray,
tmux_conf_theme_left_separator_main='\uE0B0'
tmux_conf_theme_left_separator_sub='\uE0B1'
tmux_conf_theme_right_separator_main='\uE0B2'
tmux_conf_theme_right_separator_sub='\uE0B3'
tmux_conf_theme_window_status_format="#I #W#{?window_bell_flag,🔔,}#{?window_zoomed_flag,🔍,}"
tmux_conf_theme_window_status_current_format="#I #W#{?window_zoomed_flag,🔍,}"

# Change Prefix to T
unbind C-b
unbind C-c
set -g prefix C-t
bind C-t send-prex

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

# Gitmux
tmux_conf_theme_status_left=' 🍺 #S '
#tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized} %R , %d %b | #{username}#{root} | #{hostname} | #(/bin/bash $HOME/.tmux-kube/kube.tmux 250 red cyan) | #(gitmux "#{pane_current_path}")'
#tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized} %R , %d %b | #{username} | #{root} | #($HOME/.local/bin/gitmux "#{pane_current_path}")'
tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized} %R , %d %b , #(/bin/bash $HOME/.tmux/kube-tmux/kube.tmux 250 red cyan) , #($HOME/.local/bin/gitmux "#{pane_current_path}")'

# Catppuccin Theme
# set -g @plugin 'catppuccin/tmux'
# set -g @catppuccin_window_left_separator ""
# set -g @catppuccin_window_right_separator " "
# set -g @catppuccin_window_middle_separator " █"
# set -g @catppuccin_window_number_position "right"
# set -g @catppuccin_window_default_fill "number"
# set -g @catppuccin_window_default_text "#W"
# set -g @catppuccin_window_current_fill "number"
# set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
# set -g @catppuccin_status_modules_right "directory meetings date_time"
# set -g @catppuccin_status_modules_left "session"
# set -g @catppuccin_status_left_separator  " "
# set -g @catppuccin_status_right_separator " "
# set -g @catppuccin_status_right_separator_inverse "no"
# set -g @catppuccin_status_fill "icon"
# set -g @catppuccin_status_connect_separator "no"
# set -g @catppuccin_directory_text "#{b:pane_current_path}"
# set -g @catppuccin_meetings_text "#($HOME/.config/tmux/scripts/cal.sh)"
# set -g @catppuccin_date_time_text "%H:%M"
EOF
fi
