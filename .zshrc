reset
autoload -Uz compinit && compinit
setopt correct_all
alias ll='ls -lah'
alias lll='ls -laAh'
print -P "%F{057}n1ghtfall (v2.5.3)%f"
print -P "%F{053}     ___       _   _   ___     _ _ %f"
print -P "%F{056} ___|_  |  ___| |_| |_|  _|___| | |%f"
print -P "%F{061}|   |_| |_| . |   |  _|  _| .'| | |%f"
print -P "%F{098}|_|_|_____|_. |_|_|_| |_| |__,|_|_|%f"
print -P "%F{161}     n1ght%f%F{105}|___|%f%F{161}fall.sh%f"
print ""
print -P "[%F{073}==%f] %F{088}Loaded%f"
print ""
PROMPT="[%F{025}%~%f] %F{053}n%f%F{056}1%f%F{061}g%f%F{098}h%f%F{105}t%f%F{111}f%f%F{117}all%f %F{056}$%f "
