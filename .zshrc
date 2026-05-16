# ============================================================================
# n1ghtfall v2 - Zsh Configuration
# A really cool dark terminal theme for Zsh
# ============================================================================

# Initialization
autoload -Uz compinit && compinit -iu
setopt correct_all

# ============================================================================
# Color Definitions
# ============================================================================
typeset -A colors
colors[primary]=057
colors[secondary]=053
colors[accent]=056
colors[tertiary]=061
colors[quaternary]=098
colors[highlight]=161

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
      echo -e "\n${YELLOW}[n1ghtfall]${NC} A new update is available!"
      echo -e "${BLUE}Run 'nf-update' to install it.${NC}\n"
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
    echo -e "${RED}Error: n1ghtfall is not installed.${NC}"
    return 1
  fi
  
  echo -e "${YELLOW}Updating n1ghtfall...${NC}"
  
  (
    cd "$install_dir"
    git pull origin main 2>/dev/null
    
    if [ $? -eq 0 ]; then
      # Update the .zshrc file
      cp "$install_dir/.zshrc" "$zshrc_path"
      echo -e "${GREEN}✓ Update complete!${NC}"
      echo -e "${BLUE}Restart your terminal or run:${NC}"
      echo -e "${YELLOW}  source ~/.zshrc${NC}"
    else
      echo -e "${RED}Error: Failed to update n1ghtfall.${NC}"
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
alias ll='ls -lah'
alias lll='ls -laAh'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias rmf='rm -rf'
alias cat='cat -v'
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

# ============================================================================
# Utility Aliases
# ============================================================================
alias cc='clear'
alias cls='clear'
alias grep='grep --color=auto'
alias less='less -R'
alias tree='tree -L 2'
alias nf-uninstall='curl -O "https://raw.githubusercontent.com/reorientate/n1ghtfall/refs/heads/main/uninstall.sh" && bash uninstall.sh && rm uninstall.sh'

# ============================================================================
# n1ghtfall Banner
# ============================================================================
display_banner() {
  print -P "%F{$colors[primary]}n1ghtfall (v2)%f"
  print -P "%F{$colors[primary]}(%D{%d/%m/%Y}%@) %y%f"
  print -P "%F{$colors[secondary]}     ___       _   _   ___     _ _ %f"
  print -P "%F{$colors[accent]} ___|_  |  ___| |_| |_|  _|___| | |%f"
  print -P "%F{$colors[tertiary]}|   |_| |_| . |   |  _|  _| .'| | |%f"
  print -P "%F{$colors[quaternary]}|_|_|_____|_. |_|_|_| |_| |__,|_|_|%f"
  print -P "%F{$colors[highlight]}     n1ght%f%F{105}|___|%f%F{$colors[highlight]}fall.sh%f"
  print ""
  print -P "[%F{073}==%f] %F{161}Loaded!%f"
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
