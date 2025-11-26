# =============================================================================
# ~/.zshrc – The Definitive 2025 Setup
# Features: eza • Starship • zinit (fastest) • Vi mode toggle • gorgeous UX
# =============================================================================

# ────────────────────────────── 1. Core zsh options ──────────────────────────────
setopt AUTO_CD                    # Type a directory name → cd into it
setopt CORRECT                    # Suggest command corrections (gentle)
setopt COMPLETE_IN_WORD           # Complete inside words
setopt ALWAYS_TO_END              # Move cursor to end after completion
setopt MENU_COMPLETE              # Immediately show menu (no double-tab needed)
setopt AUTO_MENU                  # Tab again → cycle through menu
setopt LIST_PACKED                # Compact completion lists
setopt SHARE_HISTORY              # Share history across all sessions
setopt HIST_IGNORE_ALL_DUPS       # Never store duplicates
setopt HIST_IGNORE_SPACE          # Don't save commands starting with space
setopt HIST_SAVE_NO_DUPS
setopt EXTENDED_HISTORY           # Save timestamps in history
setopt APPEND_HISTORY             # Append, don't overwrite history file

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
zinit ice lucid wait atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions                  # Fish-like suggestions

zinit ice lucid wait
zinit light zdharma-continuum/fast-syntax-highlighting     # Blazing-fast highlighting

zinit ice lucid wait 
zinit light zsh-users/zsh-completions                      # Extra completions

zinit ice lucid wait
zinit snippet OMZP::colored-man-pages                      # Colored man pages

# ────────────────────────────── 5. Completion appearance ──────────────────────────────
zstyle ':completion:*' menu select                          # Arrow-key driven menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colorize completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:descriptions' format '%F{yellow}%B─── %d ───%b%f'
zstyle ':completion:*' group-name ''

# ────────────────────────────── 6. Prompt – Starship (2025 default) ──────────────────────────────
if command -v starship >/dev/null; then
    export STARSHIP_CONFIG="${HOME}/.config/starship-zsh.toml"
    eval "$(starship init zsh)"
else
    autoload -U colors && colors
    PROMPT='%F{magenta}%n%f@%F{cyan}%m%f %F{yellow}%~%f %# '
fi

# ────────────────────────────── 7. eza – the only ls you need in 2025 ──────────────────────────────
if command -v eza >/dev/null; then
    alias ls='eza --color=auto --group-directories-first --icons=auto'
    alias l='eza -1a --icons=auto'                                    # quick list
    alias ll='eza -la --git --icons=auto --time-style=long-iso --group-directories-first'
    alias la='eza -a --icons=auto'
    alias tree='eza --tree --icons=auto --level=3 --git-ignore'
    alias lt='eza --tree --icons=auto --level=4'
    alias ldot='eza -ld .*'                                           # hidden files only
    alias lS='eza -la --sort=size --reverse'                          # biggest last
else
    alias ls='ls --color=auto -F'
    alias ll='ls -lah --color=auto'
    alias l='ls -1A --color=auto'
fi

# ────────────────────────────── 8. Modern tool replacements ──────────────────────────────
command -v bat    >/dev/null && alias cat='bat --style plain'
command -v batcat >/dev/null && alias cat='batcat --style plain'   # Ubuntu
command -v dust   >/dev/null && alias du='dust'
command -v procs  >/dev/null && alias ps='procs'
command -v btop   >/dev/null && alias top='btop'
command -v zoxide >/dev/null && eval "$(zoxide init zsh)" && alias cd='z'
command -v fzf    >/dev/null && eval "$(fzf --zsh)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# ────────────────────────────── 9. Classic aliases (with color) ──────────────────────────────
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# Safety first
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias glog="git log --graph --all --decorate --oneline --color=always"

# ────────────────────────────── 10. Key bindings ──────────────────────────────
# Default: Emacs style (Ctrl-A, Ctrl-E, etc.)
bindkey -e

# →→→ Uncomment the next 3 lines to switch to Vi mode permanently ←←←
# bindkey -v                    # Vi normal/insert mode
# export KEYTIMEOUT=1           # No lag when hitting Esc
# bindkey '^?' backward-delete-char  # Fix backspace in vi mode

# Accept zsh-autosuggestions with Tab only (2025 muscle memory)
bindkey -r '^[[Z'                     # remove any old Shift+Tab binding
bindkey '^I' autosuggest-accept       # Tab = accept suggestion


# ────────────────────────────── 11. Final polish ──────────────────────────────
# Auto-start tmux (uncomment if you want)
# [[ -z "$TMUX" && -x "$(command -v tmux)" ]] && exec tmux new-session -A -s main
