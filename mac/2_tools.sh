#!/bin/zsh

# Install helm plugins
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/jkroepke/helm-secrets

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

# Set up tmuxbar
if ! grep -q '^#   ___  _ __(_) __ _(_)_ __   __ _| |' ~/.tmux.conf.local;then
cat <<'EOF' > ~/.tmux.conf.local.custom
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
bind C-t send-prefix

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
#tmux_conf_theme_status_left_bg='#8a8a8a,#ff00af,#00afff'  # yellow, pink, white blue
tmux_conf_theme_status_left=' 💩 #S '
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
# set -g @resurrect-capture-pane-contents 'on'
# set -g @continuum-save-interval '15'
EOF
fi
