#
# ~/.bashrc
#

export EDITOR="nvim"
export MANPAGER="bat -p -l man"
export TERMINAL="alacritty"
export EZA_ICON_SPACING=2

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza --icons --color'
alias ll='eza -al --icons --color --no-time'
alias cat='bat'
alias grep='grep --color=auto'
alias shutdown='sudo shutdown now'


PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"
eval "$(fzf --bash)"
