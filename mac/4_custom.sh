#!/bin/zsh

# Setup custom zsh
cat <<'EOF' > ~/.zshrc_custom
alias vi=lvim
alias lg=lazygit
alias gf="git flow"
bindkey "^R" history-incremental-search-backward
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.local/bin:$PATH"
export EDITOR=nvim

# --- Tmux aliases ---
alias tvsp="tmux split-window -h -c \"#{pane_current_path}\""
alias tsp="tmux split-window -v -c \"#{pane_current_path}\""
alias tdp="tmux display-panes"

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat -----

export BAT_THEME=tokyonight_night

# --- Set up eza ---
alias ls="eza --git"
export EZA_ICONS_AUTO=always
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
# set -g @resurrect-capture-pane-contents 'on'
# set -g @continuum-save-interval '15'
EOF
fi
