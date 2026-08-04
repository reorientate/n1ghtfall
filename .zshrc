# ============================================================================
# n1ghtfall v3.0.0 - Zsh Configuration
# A really cool dark terminal theme for Zsh
#
# NOTE: `nf-update` pulls the stock .zshrc from the reorientate/n1ghtfall
# GitHub repo and overwrites this file, which would wipe these additions.
# If you want your customizations to survive an update, consider moving
# anything you keep tweaking into ~/.zshrc.local (sourced at the very end
# of this file) instead of editing this file directly.
# ============================================================================

# ============================================================================
# Initialization
# ============================================================================
autoload -Uz compinit && compinit -u
autoload -Uz add-zsh-hook
zmodload zsh/complist
zmodload zsh/datetime 2>/dev/null
setopt correct_all

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{093}-- %d --%f'

# ============================================================================
# History Configuration
# ============================================================================
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY       # Save timestamps
setopt HIST_EXPIRE_DUPS_FIRST # Trim dupes first when history is full
setopt HIST_IGNORE_DUPS       # Don't record a line twice in a row
setopt HIST_IGNORE_ALL_DUPS   # Older duplicate lines are removed
setopt HIST_IGNORE_SPACE      # Lines starting with a space aren't recorded
setopt HIST_VERIFY            # Expand !-history before running it
setopt SHARE_HISTORY          # Share history across all open sessions
setopt INC_APPEND_HISTORY     # Write to HISTFILE immediately, not on exit

# ============================================================================
# Shell Options
# ============================================================================
setopt AUTO_CD                # Type a dir name to cd into it
setopt AUTO_PUSHD             # cd pushes onto the directory stack
setopt PUSHD_IGNORE_DUPS      # No duplicate entries in the dir stack
setopt EXTENDED_GLOB          # Extra globbing operators (e.g. ^, ~)
setopt INTERACTIVE_COMMENTS   # Allow # comments in the interactive shell
setopt NO_BEEP                # Quiet down
setopt COMPLETE_IN_WORD       # Complete from both ends of a word

# ============================================================================
# Key Bindings
# ============================================================================
# Prefix-aware history search: type part of a command, then Up/Down
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Home / End / Delete
bindkey "^[[H"  beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[3~" delete-char

# Ctrl+Left / Ctrl+Right to jump by word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# ============================================================================
# PATH(s) (you can add PATHs here under this box)
# ============================================================================
# export PATH="<path>:$PATH"

# ============================================================================
# Configuration
# ============================================================================
# Update check interval (in seconds)
# Default: 86400 (24 hours)
# Examples:
#   3600   = 1 hour
#   21600  = 6 hours
#   43200  = 12 hours
#   86400  = 24 hours (default)
#   604800 = 7 days
N1GHTFALL_CHECK_INTERVAL=${N1GHTFALL_CHECK_INTERVAL:-3600}

# ============================================================================
# Update Check Function
# ============================================================================
check_and_update_n1ghtfall() {
  local install_dir="${HOME}/.n1ghtfall"
  local check_file="${HOME}/.n1ghtfall-update-check"
  local check_interval=$N1GHTFALL_CHECK_INTERVAL
  
  if [ ! -d "$install_dir" ]; then
    return
  fi
  
  local current_time=$(date +%s)
  if [ -f "$check_file" ]; then
    local last_check=$(cat "$check_file")
    local time_diff=$((current_time - last_check))
    if [ $time_diff -lt $check_interval ]; then
      return
    fi
  fi
  
  echo "$current_time" > "$check_file"
  
  (
    cd "$install_dir"
    
    # Fetch the latest changes
    git fetch origin main 2>/dev/null || return

    local local_version=$(git rev-parse HEAD 2>/dev/null)
    local remote_version=$(git rev-parse origin/main 2>/dev/null)
    
    if [ "$local_version" != "$remote_version" ]; then
      print -P "%F{057}[%f%F{093}nf%f%F{057}]%f %F{057}A new update is available!%f"
      print -P "%F{057}[%f%F{093}nf%f%F{057}]%f %F{057}Run 'nf-update' to install it.%f\n"
    fi
  ) &>/dev/null &!
}

# ============================================================================
# Update Function
# ============================================================================
nf-update() {
  local install_dir="${HOME}/.n1ghtfall"
  local zshrc_path="${HOME}/.zshrc"
  
  if [ ! -d "$install_dir" ]; then
    print -P "%F{057}[%f%F{093}nf%f%F{057}]%f %F{057}Error: n1ghtfall is not installed.%f"
    return 1
  fi
  
  print -P "%F{057}[%f%F{093}nf%f%F{057}]%f %F{057}Updating n1ghtfall...%f"
  
  (
    cd "$install_dir"
    git pull origin main 2>/dev/null
    
    if [ $? -eq 0 ]; then
      # Update the .zshrc file
      cp "$install_dir/.zshrc" "$zshrc_path"
      print -P "%F{057}[%f%F{093}nf%f%F{057}]%f %F{057}✓ Update complete!%f"
      print -P "%F{057}[%f%F{093}nf%f%F{057}]%f %F{057}Restart your terminal or run:%f"
      print -P "%F{057}[%f%F{093}nf%f%F{057}]%f %F{057}  source ~/.zshrc%f"
    else
      print -P "%F{057}[%f%F{093}nf%f%F{057}]%f %F{057}Error: Failed to update n1ghtfall.%f"
      return 1
    fi
  )
}

# ============================================================================
# Directory Navigation Aliases
# ============================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd..='cd ..'
alias mkdir='mkdir -p'
alias bd='cd -'

# ============================================================================
# File Management Aliases
# ============================================================================
alias ll='ls -lah --color'
alias ls='ls --color'
alias lt='ls -laht --color'
alias lsize='ls -lahS --color'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias rmrf='rm -rf'
alias catv='cat -v'
alias df='df -h'
alias du='du -h'
alias duh='du -sh -- * 2>/dev/null | sort -rh'
alias count='find . -type f | wc -l'

# ============================================================================
# System Information Aliases
# ============================================================================
alias ps='ps aux'
alias ping='ping -c 5'
alias ports='netstat -tuln'
alias myip='curl -s https://ipinfo.io/ip'
alias path='echo $PATH | tr ":" "\n"'
alias reload='source ~/.zshrc'

# ============================================================================
# Git Aliases
# ============================================================================
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gcl='git clone'
alias gp='git push'
alias gpl='git pull'
alias glog='git log --oneline -10'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gbr='git branch'
alias gco='git checkout'
alias gnb='git checkout -b'
alias gdiff='git diff'
alias gcam='git add -A && git commit -m'
alias gundo='git reset --soft HEAD~1'
alias gclean='git branch --merged | grep -Ev "\*|main|master" | xargs -r git branch -d'

# ============================================================================
# Development Aliases
# ============================================================================
alias python='python3'
alias py='python3'
alias pip='pip3'
alias pipstall='pip3 install'
alias pyhttpserver='python3 -m http.server'
alias vi='vim'
alias mkexec='chmod +x'
alias zshrc='subl -n ~/.zshrc'
alias subln='subl -n'
alias jsonpp='python3 -m json.tool'

# ============================================================================
# Utility Aliases
# ============================================================================
alias cc='clear'
alias cls='clear'
alias grep='grep --color=auto'
alias less='less -R'
alias tree='tree -C'
alias nf-uninstall='curl -O "https://raw.githubusercontent.com/reorientate/n1ghtfall/refs/heads/main/uninstall.sh" && bash uninstall.sh && rm uninstall.sh'
alias 0-256colors='for c in {0..256}; do printf "\e[38;5;${c}m██████████ ║${c}║ ██████████\e[0m\n"; done'
alias please='sudo $(fc -ln -1)'
alias copy='clipboard'

# A few purely-for-fun aliases (all safe, all optional)
alias starwars='telnet towel.blinkenlights.nl'   # classic ASCII Star Wars
alias parrot='curl -s parrot.live'                # party parrot animation
if command -v cmatrix &>/dev/null; then
  alias matrix='cmatrix -C cyan'
fi
if command -v fortune &>/dev/null && command -v cowsay &>/dev/null; then
  alias moo='fortune | cowsay'
fi

# ============================================================================
# Optional Plugins (loaded only if already installed - never errors)
# ============================================================================
for _n1ghtfall_plugin in \
  "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"; do
  if [[ -f "$_n1ghtfall_plugin" ]]; then
    source "$_n1ghtfall_plugin"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245"
    break
  fi
done
unset _n1ghtfall_plugin

# ============================================================================
# FZF Integration (only runs if fzf is installed)
# ============================================================================
if command -v fzf &>/dev/null; then
  for _n1ghtfall_fzf_rc in \
    "/usr/share/doc/fzf/examples/key-bindings.zsh" \
    "/usr/share/fzf/key-bindings.zsh" \
    "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"; do
    [[ -f "$_n1ghtfall_fzf_rc" ]] && source "$_n1ghtfall_fzf_rc" && break
  done
  for _n1ghtfall_fzf_rc in \
    "/usr/share/doc/fzf/examples/completion.zsh" \
    "/usr/share/fzf/completion.zsh" \
    "/opt/homebrew/opt/fzf/shell/completion.zsh"; do
    [[ -f "$_n1ghtfall_fzf_rc" ]] && source "$_n1ghtfall_fzf_rc" && break
  done
  unset _n1ghtfall_fzf_rc

  # Fuzzy-cd into a subdirectory of $1 (or cwd)
  fcd() {
    local dir
    dir=$(find "${1:-.}" -type d 2>/dev/null | fzf +m) && cd -- "$dir"
  }

  # Fuzzy-checkout a local or remote git branch
  fco() {
    local branch
    branch=$(git branch --all 2>/dev/null | grep -v HEAD | sed 's/.* //' | sed 's#remotes/[^/]*/##' | sort -u | fzf) \
      && git checkout "$branch"
  }

  # Fuzzy-kill a process (defaults to SIGTERM, pass a signal as $1)
  fkill() {
    local pid
    pid=$(ps aux | sed 1d | fzf -m | awk '{print $2}')
    [[ -n "$pid" ]] && echo "$pid" | xargs kill -"${1:-9}"
  }
fi

# ============================================================================
# Useful Functions
# ============================================================================

# Make a directory and cd into it in one step
mkcd() {
  if [[ -z "$1" ]]; then
    echo "Usage: mkcd <dir>"
    return 1
  fi
  mkdir -p -- "$1" && cd -- "$1"
}
take() { mkcd "$@" }

# Go up N directories (default 1): `up 3` == cd ../../..
up() {
  local levels=${1:-1} path=""
  for ((i = 0; i < levels; i++)); do path="../$path"; done
  cd -- "$path"
}

# Universal archive extractor
extract() {
  if [[ -z "$1" ]]; then
    echo "Usage: extract <archive>"
    return 1
  fi
  if [[ ! -f "$1" ]]; then
    echo "'$1' is not a valid file"
    return 1
  fi
  case "$1" in
    *.tar.bz2) tar xjf "$1"    ;;
    *.tar.gz)  tar xzf "$1"    ;;
    *.tar.xz)  tar xJf "$1"    ;;
    *.tar)     tar xf "$1"     ;;
    *.tbz2)    tar xjf "$1"    ;;
    *.tgz)     tar xzf "$1"    ;;
    *.bz2)     bunzip2 "$1"    ;;
    *.gz)      gunzip "$1"     ;;
    *.zip)     unzip "$1"      ;;
    *.rar)     unrar x "$1"    ;;
    *.7z)      7z x "$1"       ;;
    *.Z)       uncompress "$1" ;;
    *)         echo "'$1': unrecognized archive type" ;;
  esac
}

# Timestamped backup copy of a file
backup() {
  if [[ -z "$1" ]]; then
    echo "Usage: backup <file>"
    return 1
  fi
  cp -- "$1" "$1.bak.$(date +%Y%m%d%H%M%S)"
}

# Random password generator: genpass [length]
genpass() {
  local length=${1:-20}
  LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*()_+=' < /dev/urandom | head -c "$length"
  echo
}

# Quick ASCII weather report: weather [city]
weather() {
  curl -s "https://wttr.in/${1:-}"
}

# Cheatsheet lookup: cheat tar
cheat() {
  if [[ -z "$1" ]]; then
    echo "Usage: cheat <topic>"
    return 1
  fi
  curl -s "https://cheat.sh/$1"
}

# Find files by (partial, case-insensitive) name under the cwd
ff() {
  if [[ -z "$1" ]]; then
    echo "Usage: ff <name-pattern>"
    return 1
  fi
  find . -iname "*$1*" 2>/dev/null
}

# grep through the process list
psg() {
  ps aux | grep -i --color=auto -- "$1" | grep -v grep
}

# Quick system summary
sysinfo() {
  print -P "%F{057}OS:%f     $(uname -srm)"
  print -P "%F{057}Host:%f   $(hostname)"
  print -P "%F{057}Uptime:%f $(uptime -p 2>/dev/null || uptime)"
  print -P "%F{057}Shell:%f  zsh $ZSH_VERSION"
  print -P "%F{057}Term:%f   $TERM"
}

# Cross-platform clipboard copy: cat file | clipboard  (or its alias: copy)
clipboard() {
  if command -v pbcopy &>/dev/null; then
    pbcopy
  elif command -v xclip &>/dev/null; then
    xclip -selection clipboard
  elif command -v xsel &>/dev/null; then
    xsel --clipboard --input
  elif command -v clip.exe &>/dev/null; then
    clip.exe
  else
    echo "No clipboard utility found (try installing xclip or xsel)"
    return 1
  fi
}

# urlencode "some string", urldecode "some%20string"
urlencode() {
  python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))" "$1"
}
urldecode() {
  python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))" "$1"
}

# ============================================================================
# n1ghtfall Banner
# ============================================================================
display_banner() {
  print -P "%F{057}n1ghtfall (%f%F{093}v3.0.0%f%F{057})%f"
  print -P "%F{057}(%f%F{093}%D{%m/%d/%Y}%@%f%F{057}) %y%f"
  print -P "%F{053}     ___       _   _   ___     _ _ %f"
  print -P "%F{056} ___|_  |  ___| |_| |_|  _|___| |%B*%b|%f"
  print -P "%F{061}|   |_| |_| . |   |  _|  _| .'| | |%f"
  print -P "%F{098}|_|_|_____|_. |_|_|_| |_| |__,|_|_|%f"
  print -P "%F{105}      %f%F{89}--|=%f%F{105}|___|%f%F{89}=>%f"
  print ""
  print -P "%F{057}[%f%F{093}nf%f%F{057}] %f%F{057}Loaded!%f"

  # local -a _n1ghtfall_tips=(
  #   "Try 'mkcd myproject' to create and enter a directory in one step."
  #   "Try 'extract file.tar.gz' to unpack (almost) any archive."
  #   "Try 'weather' for a quick ASCII forecast in your terminal."
  #   "Try 'ff partial-name' to fuzzy-find files under the current directory."
  #   "Type 'reload' any time to re-source this config."
  #   "Press the Up arrow after typing a few letters to search matching history."
  #   "Try 'sysinfo' for a quick summary of this machine."
  #   "Try 'genpass 24' to generate a random password."
  # )
  # local _n1ghtfall_tip_idx=$(( (RANDOM % ${#_n1ghtfall_tips[@]}) + 1 ))
  # print -P "%F{105}Tip:%f %F{247}${_n1ghtfall_tips[$_n1ghtfall_tip_idx]}%f"
  print ""
}

display_banner

# ============================================================================
# Prompt Configuration
# ============================================================================
setopt PROMPT_SUBST

typeset -g N1GHTFALL_LAST_EXIT=0
typeset -g N1GHTFALL_CMD_START=
typeset -g N1GHTFALL_CMD_DURATION=

# Reset terminal colors before executing commands, and start a command timer
_n1ghtfall_preexec() {
  echo -ne "\e[0m"
  N1GHTFALL_CMD_START=$EPOCHREALTIME
}
add-zsh-hook preexec _n1ghtfall_preexec

# Capture exit status + command duration for the prompt
_n1ghtfall_precmd() {
  N1GHTFALL_LAST_EXIT=$?
  N1GHTFALL_CMD_DURATION=""
  if [[ -n "$N1GHTFALL_CMD_START" ]]; then
    local elapsed=$(( EPOCHREALTIME - N1GHTFALL_CMD_START ))
    (( elapsed > 3 )) && N1GHTFALL_CMD_DURATION=$(printf "%.1fs" "$elapsed")
    N1GHTFALL_CMD_START=
  fi
}
add-zsh-hook precmd _n1ghtfall_precmd

# Show the current git branch (if inside a repo), plain-text for max font compatibility
n1ghtfall_git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || branch=$(git rev-parse --short HEAD 2>/dev/null)
  [[ -n "$branch" ]] && print -n "─[%F{111}git:$branch%f]"
}

# Green check on success, red X on failure
n1ghtfall_exit_status() {
  if [[ "${N1GHTFALL_LAST_EXIT:-0}" -eq 0 ]]; then
    print -n "%F{040}✓%f"
  else
    print -n "%F{196}✗%f"
  fi
}

# Show how long the last command took, only if it was slow (> 3s)
n1ghtfall_duration() {
  [[ -n "$N1GHTFALL_CMD_DURATION" ]] && print -n "─[%F{220}⏱ $N1GHTFALL_CMD_DURATION%f]"
}

PROMPT=$'╭──[%F{025}%~%f]─[%F{056}%n@n1ghtfall%f]─[%F{056}+%f]$(n1ghtfall_git_branch)$(n1ghtfall_duration)─[$(n1ghtfall_exit_status)]>\n╰──[%F{056}#%f]───[%F{032}%B%b%f '

# ============================================================================
# Run Update Check on Shell Start
# ============================================================================
check_and_update_n1ghtfall

# ============================================================================
# Personal Overrides (kept separate so `nf-update` won't ever wipe them out)
# ============================================================================
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"

# ============================================================================
# Alternative Prompt (uncomment to use)
# ============================================================================
# PROMPT="[%F{025}%~%f] %F{053}n%f%F{056}1%f%F{061}g%f%F{098}h%f%F{105}t%f%F{111}f%f%F{117}all%f %F{056}$%f "
