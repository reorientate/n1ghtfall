# ============================================================================
# n1ghtfall v2 - Zsh Configuration
# A really cool dark terminal theme for Zsh
# ============================================================================

# Initialization
autoload -Uz compinit && compinit
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
  print -P "%F{$colors[secondary]}     ___       _   _   ___     _ _ %f"
  print -P "%F{$colors[accent]} ___|_  |  ___| |_| |_|  _|___| | |%f"
  print -P "%F{$colors[tertiary]}|   |_| |_| . |   |  _|  _| .'| | |%f"
  print -P "%F{$colors[quaternary]}|_|_|_____|_. |_|_|_| |_| |__,|_|_|%f"
  print -P "%F{$colors[highlight]}     n1ght%f%F{105}|___|%f%F{$colors[highlight]}fall.sh%f"
  print ""
  print -P "[%F{073}==%f] %F{085}Loaded!%f"
  print ""
}

display_banner

# ============================================================================
# Prompt Configuration
# ============================================================================
PROMPT=$'╭─[%F{025}%~%f]─[%F{056}%n@n1ghtfall%f]─[%F{056}+%f]>\n╰──%F{025}%B$%b%f '

# Reset terminal colors before executing commands
preexec() { echo -ne "\e[0m" }

# ============================================================================
# Alternative Prompt (uncomment to use)
# ============================================================================
# PROMPT="[%F{025}%~%f] %F{053}n%f%F{056}1%f%F{061}g%f%F{098}h%f%F{105}t%f%F{111}f%f%F{117}all%f %F{056}$%f "
