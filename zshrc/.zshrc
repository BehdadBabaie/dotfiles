# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# ~/.zshrc – Clean, Fast & Fully Working 2025 Setup
# =============================================================================

# ────────────────────────────── 1. Core zsh options ──────────────────────────────
setopt AUTO_CD
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt LIST_PACKED
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt AUTO_MENU
setopt MENU_COMPLETE

HISTFILE="$HOME/.zsh_history"
HISTSIZE=500000
SAVEHIST=500000

# ────────────────────────────── 2. Environment ──────────────────────────────
export ZDOTDIR="${ZDOTDIR:-$HOME}"
export ZSH_COMPDUMP="$ZDOTDIR/.zcompdump"

export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# ────────────────────────────── 3. zinit – fastest plugin manager ──────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname $ZINIT_HOME)"
[[ ! -d $ZINIT_HOME/.git ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# ────────────────────────────── 4. Plugins (turbo mode) ──────────────────────────────
# Autosuggestions
zinit ice lucid wait atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting
zinit ice lucid wait
zinit light zdharma-continuum/fast-syntax-highlighting

# Extra completions
zinit ice lucid wait
zinit light zsh-users/zsh-completions

# Install Powerlevel10k via zinit
zinit ice lucid wait
zinit light romkatv/powerlevel10k

# OMZ colored man pages
zinit ice lucid wait
zinit snippet OMZP::colored-man-pages

# ────────────────────────────── 5. Initialize completion system (correct order!) ──────────────────────────────
autoload -Uz compinit
compinit -C

# After compinit → now safe to replay plugin compdefs
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:descriptions' format '%F{yellow}%B─── %d ───%b%f'
zstyle ':completion:*' group-name ''

# ────────────────────────────── 6. Prompt – Starship/Powerlevel10k  ──────────────────────────────

#if command -v starship >/dev/null; then
#    export STARSHIP_CONFIG="${HOME}/.config/starship-zsh.toml"
#    eval "$(starship init zsh)"
#else
#    autoload -U colors && colors
#    PROMPT='%F{magenta}%n%f@%F{cyan}%m%f %F{yellow}%~%f %# '
#fi

# ────────────────────────────── 7. eza replacements ──────────────────────────────
if command -v eza >/dev/null; then
    alias ls='eza -a --color=auto --group-directories-first --icons=auto'
    alias l='eza -1a --icons=auto'
    alias ll='eza -la --git --icons=auto --time-style=long-iso --group-directories-first'
    alias la='eza -a --icons=auto'
    alias tree='eza --tree --icons=auto --level=3 --git-ignore'
    alias lt='eza --tree --icons=auto --level=4'
    alias ldot='eza -ld .*'
    alias lS='eza -la --sort=size --reverse'
else
    alias ls='ls --color=auto -F'
    alias ll='ls -lah --color=auto'
    alias l='ls -1A --color=auto'
fi

# ────────────────────────────── 8. Modern tool replacements ──────────────────────────────
command -v bat >/dev/null && alias cat='bat --style plain'
command -v batcat >/dev/null && alias cat='batcat --style plain'
command -v dust >/dev/null && alias du='dust'
command -v procs >/dev/null && alias ps='procs'
command -v btop >/dev/null && alias top='btop'
command -v zoxide >/dev/null && eval "$(zoxide init zsh)" && alias cd='z'
command -v fzf >/dev/null && eval "$(fzf --zsh)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# ────────────────────────────── 9. Aliases ──────────────────────────────
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias glog="git log --graph --all --decorate --oneline --color=always"

# ────────────────────────────── 10. Key bindings ──────────────────────────────
bindkey -e      # Emacs mode

# TAB = normal completion
bindkey '^I' complete-word

# SHIFT+TAB = accept autosuggestion
bindkey '^[[Z' autosuggest-accept

# ────────────────────────────── 11. Optional: auto-start tmux ──────────────────────────────
# [[ -z "$TMUX" && -x "$(command -v tmux)" ]] && exec tmux new-session -A -s main

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
