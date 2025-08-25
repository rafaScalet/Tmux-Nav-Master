#!/usr/bin/env bash

is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'" # credit to christoomey, raviqqe and leviticusnelson. See https://github.com/christoomey/vim-tmux-navigator/blob/master/vim-tmux-navigator.tmux
is_fzf="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?fzf$'"
is_lazygit="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?lazygit$'"

# Smart pane navigation with Vim/fzf/lazygit awareness
tmux bind -N "Select pane on the left"  -n C-h if "$is_vim"                           "send C-h" "select-pane -L"
tmux bind -N "Select pane below"        -n C-j if "$is_vim || $is_fzf || $is_lazygit" "send C-j" "select-pane -D"
tmux bind -N "Select pane above"        -n C-k if "$is_vim || $is_fzf || $is_lazygit" "send C-k" "select-pane -U"
tmux bind -N "Select pane on the right" -n C-l if "$is_vim"                           "send C-l" "select-pane -R"

# Send keys directly
tmux bind -N "Send C-h to the active pane" -r C-h send C-h
tmux bind -N "Send C-j to the active pane" -r C-j send C-j
tmux bind -N "Send C-k to the active pane" -r C-k send C-k
tmux bind -N "Send C-l to the active pane" -r C-l send C-l

# Swap panes
tmux bind -N "Swap the active pane with the pane on the left"  H swap-pane -s "{left-of}"
tmux bind -N "Swap the active pane with the pane below"        J swap-pane -s "{down-of}"
tmux bind -N "Swap the active pane with the pane above"        K swap-pane -s "{up-of}"
tmux bind -N "Swap the active pane with the pane on the right" L swap-pane -s "{right-of}"

# Resize panes with Ctrl + Arrow
tmux bind -N "Resize pane left by 3"  -n C-Left  if "$is_vim" "send C-Left"  "resize-pane -L 3"
tmux bind -N "Resize pane down by 3"  -n C-Down  if "$is_vim" "send C-Down"  "resize-pane -D 3"
tmux bind -N "Resize pane up by 3"    -n C-Up    if "$is_vim" "send C-Up"    "resize-pane -U 3"
tmux bind -N "Resize pane right by 3" -n C-Right if "$is_vim" "send C-Right" "resize-pane -R 3"

# Copy-mode (VI) navigation
tmux bind -N "Select pane on the left"  -T copy-mode-vi C-h select-pane -L
tmux bind -N "Select pane below"        -T copy-mode-vi C-j select-pane -D
tmux bind -N "Select pane above"        -T copy-mode-vi C-k select-pane -U
tmux bind -N "Select pane on the right" -T copy-mode-vi C-l select-pane -R

# Copy-mode (VI) resize
tmux bind -N "Resize pane left by 3"  -T copy-mode-vi C-Left  resize-pane -L 3
tmux bind -N "Resize pane down by 3"  -T copy-mode-vi C-Down  resize-pane -D 3
tmux bind -N "Resize pane up by 3"    -T copy-mode-vi C-Up    resize-pane -U 3
tmux bind -N "Resize pane right by 3" -T copy-mode-vi C-Right resize-pane -R 3

# Window and Client navigation
tmux bind -N "Select the previous window" h previous-window
tmux bind -N "Switch to next client"      j switch-client -n
tmux bind -N "Switch to previous client"  k switch-client -p
tmux bind -N "Select the next window"     l next-window

# Swap windows
tmux bind -N "Swap window with previous" C-M-h 'swap-window -t:-1; previous-window'
tmux bind -N "Swap window with next"     C-M-l 'swap-window -t:+1; next-window'

