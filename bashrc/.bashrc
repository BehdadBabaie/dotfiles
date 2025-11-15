#
# ~/.bashrc
#

export EDITOR="nvim"
export MANPAGER="bat -p -l man"
export TERMINAL="alacritty"
export EZA_ICON_SPACING=2

# If not running interactively, don't do anything
 [[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach

 # ---- 1. History Tweaks ----
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
HISTTIMEFORMAT="%F %T "
shopt -s histappend
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# ---- 2. Aliases ----
alias ls='eza -a --icons --group-directories-first --color=always'
alias ll='eza -al --no-time --icons --group-directories-first --git'
alias la='eza -lha --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons'
alias vim='nvim'
alias cat="bat"
alias cdwm='vim ~/.local/src/dwm/config.h'
alias mdwm='cd ~/.local/src/dwm/; sudo make clean install;'
alias mcdwm='cd ~/.local/src/dwm/; sudo make clean install; cd-'
alias ff='fzf --preview "bat --style=numbers --color=always {} | head -200" --height 90% --border --preview-window=right:60%'

# Handy utilities
alias grep='grep --color=auto'
alias h='history | grep'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear && printf "\e[3J"'   # full screen clear
alias please='sudo $(history -p \!\!)' # rerun last command as sudo
alias mkcd='mkdir -p "$1" && cd "$1"'


# ---- 3. Bash Completion ----
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

# ---- 4. FZF (fuzzy finder) ----
eval "$(fzf --bash)"
# ---- 5. Starship Prompt ----
eval "$(starship init bash)"

# ---- 7. Welcome message ----
if [[ $- == *i* ]]; then
  echo -e "\e[1;32mWelcome back, $(whoami)! 󰣇 Arch ready.\e[0m"
fi

PS1='[\u@\h \W]\$ '

[[ ${BLE_VERSION-} ]] && ble-attach 

