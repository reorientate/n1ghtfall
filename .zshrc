# ============================================================================
# n1ghtfall v2.5 - Zsh Configuration
# A really cool dark terminal theme for Zsh
# ============================================================================

# Initialization
autoload -Uz compinit && compinit -u
setopt correct_all
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# ============================================================================
# PATH(s) (you can add PATHs here under this box)
# ============================================================================
# export PATH="<absolute_path>:$PATH"

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
  
  # Only check if the install directory exists
  if [ ! -d "$install_dir" ]; then
    return
  fi
  
  # Check if we should run the update check (based on interval)
  local current_time=$(date +%s)
  if [ -f "$check_file" ]; then
    local last_check=$(cat "$check_file")
    local time_diff=$((current_time - last_check))
    if [ $time_diff -lt $check_interval ]; then
      return
    fi
  fi
  
  # Update the check timestamp
  echo "$current_time" > "$check_file"
  
  # Check for updates in the background
  (
    cd "$install_dir"
    
    # Fetch the latest changes
    git fetch origin main 2>/dev/null || return
    
    # Compare local and remote versions
    local local_version=$(git rev-parse HEAD 2>/dev/null)
    local remote_version=$(git rev-parse origin/main 2>/dev/null)
    
    if [ "$local_version" != "$remote_version" ]; then
      echo -e "\n%F{226}[n1ghtfall]%f A new update is available!"
      echo -e "%F{027}Run 'nf-update' to install it.%f\n"
    fi
  ) &
}

# ============================================================================
# Update Function
# ============================================================================
nf-update() {
  local install_dir="${HOME}/.n1ghtfall"
  local zshrc_path="${HOME}/.zshrc"
  
  if [ ! -d "$install_dir" ]; then
    echo -e "%F{196}Error: n1ghtfall is not installed.%f"
    return 1
  fi
  
  echo -e "%F{226}Updating n1ghtfall...%f"
  
  (
    cd "$install_dir"
    git pull origin main 2>/dev/null
    
    if [ $? -eq 0 ]; then
      # Update the .zshrc file
      cp "$install_dir/.zshrc" "$zshrc_path"
      echo -e "%F{046}✓ Update complete!%f"
      echo -e "%F{027}Restart your terminal or run:%f"
      echo -e "%F{226}  source ~/.zshrc%f"
    else
      echo -e "%F{196}Error: Failed to update n1ghtfall.%f"
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

# ============================================================================
# File Management Aliases
# ============================================================================
alias ll='ls -lah --color'
alias ls='ls --color'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias rmf='rm -rf'
# removed alias for cat since '-v' can sometimes make output harder to read
alias df='df -h'
alias du='du -h'

# ============================================================================
# System Information Aliases
# ============================================================================
alias ps='ps aux'
alias top='top -u $USER'
alias ping='ping -c 5'
alias ports='netstat -tuln'
alias myip='curl -s https://ipinfo.io/ip'

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
alias gbr='git branch'
alias gco='git checkout'
alias gdiff='git diff'

# ============================================================================
# Development Aliases
# ============================================================================
alias python='python3'
alias pip='pip3'
alias vi='vim'
alias mkexec='chmod +x'

# ============================================================================
# Utility Aliases
# ============================================================================
alias cc='clear'
alias cls='clear'
alias grep='grep --color=auto'
alias less='less -R'
alias tree='tree -L 2'
alias nf-uninstall='curl -O "https://raw.githubusercontent.com/reorientate/n1ghtfall/refs/heads/main/uninstall.sh" && bash uninstall.sh && rm uninstall.sh'
alias 0-256colors='for c in {0..256}; do printf "\e[38;5;${c}m██████████ ║${c}║ ██████████\e[0m\n"; done'

# ============================================================================
# n1ghtfall Banner
# ============================================================================
display_banner() {
  print -P "%F{057}n1ghtfall (v2.5)%f"
  print -P "%F{057}(%D{%m/%d/%Y}%@) %y%f"
  print -P "%F{053}     ___       _   _   ___     _ _ %f"
  print -P "%F{056} ___|_  |  ___| |_| |_|  _|___| |%B*%b|%f"
  print -P "%F{061}|   |_| |_| . |   |  _|  _| .'| | |%f"
  print -P "%F{098}|_|_|_____|_. |_|_|_| |_| |__,|_|_|%f"
  print -P "%F{161}     n1ght%f%F{105}|___|%f%F{161}fall.sh%f"
  print ""
  print -P "[%F{073}nf%f] %F{111}Loaded!%f"
  print ""
}

display_banner

# ============================================================================
# Prompt Configuration
# ============================================================================
PROMPT=$'╭──[%F{025}%~%f]─[%F{056}%n@n1ghtfall%f]─[%F{056}+%f]>\n╰──[%F{056}#%f]───[%F{032}%B%b%f '

# Reset terminal colors before executing commands
preexec() { echo -ne "\e[0m" }

# ============================================================================
# Run Update Check on Shell Start
# ============================================================================
check_and_update_n1ghtfall

# ============================================================================
# Alternative Prompt (uncomment to use)
# ============================================================================
# PROMPT="[%F{025}%~%f] %F{053}n%f%F{056}1%f%F{061}g%f%F{098}h%f%F{105}t%f%F{111}f%f%F{117}all%f %F{056}$%f "
