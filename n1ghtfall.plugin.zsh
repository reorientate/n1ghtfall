#!/usr/bin/env zsh
# n1ghtfall.plugin.zsh
# ZSH plugin entrypoint for n1ghtfall
# Author: reorientate
# License: MIT
# Description: Entrypoint that sources the plugin implementation in lib/ and registers completions.

# Guard: only run under zsh
if [[ -z "${ZSH_VERSION-}" ]]; then
  return 0
fi

# Determine the directory this file lives in (absolute path)
# ${(%):-%x} expands to the current script name in zsh; :A makes it absolute; :h gives the directory
PLUGIN_DIR="${${(%):-%x}:A:h}"

# Helper to source a file if it exists
_n1ghtfall_source() {
  local file="$1"
  if [[ -f "$file" ]]; then
    # shellcheck disable=SC1090
    source "$file"
  fi
}

# Enable colors in terminal (required for LS_COLORS and prompt colors)
export CLICOLOR=1

# Set LS_COLORS for colored ls output (dircolors-like output)
# This provides the default color scheme for ls
if [[ -z "$LS_COLORS" ]]; then
  export LS_COLORS='di=01;34:ln=01;36:so=01;35:pi=01;35:ex=01;32:bd=01;33:cd=01;33:su=01;32:sg=01;32:tw=01;32:ow=01;32'
fi

# Prefer implementation in lib/n1ghtfall.zsh, fall back to n1ghtfall.zsh at repo root
_n1ghtfall_source "$PLUGIN_DIR/lib/n1ghtfall.zsh"
_n1ghtfall_source "$PLUGIN_DIR/n1ghtfall.zsh"

# If completions are provided, add them to fpath and initialize completion system if needed
if [[ -d "$PLUGIN_DIR/completions" ]]; then
  # Prepend so plugin completions take precedence
  fpath=("$PLUGIN_DIR/completions" ${fpath[@]})
  # Ensure compinit is available
  autoload -Uz compinit 2>/dev/null || true
  # Initialize completion system if not already (avoid reinitializing in other plugins)
  if [[ -z "${_N1GHTFALL_COMPINIT_DONE-}" ]]; then
    compinit -u 2>/dev/null || true
    _N1GHTFALL_COMPINIT_DONE=1
  fi
fi

# Disable oh-my-zsh theme to use n1ghtfall's custom prompt
# This ensures the PROMPT variable set in n1ghtfall.zsh is used
if [[ -n "${ZSH-}" ]]; then
  # Unset ZSH_THEME if it was set by oh-my-zsh
  unset ZSH_THEME
fi

# Provide lightweight hooks for customization before/after plugin load
# Users can define N1GHTFALL_BEFORE_INIT and N1GHTFALL_AFTER_INIT in their zshrc
if typeset -f N1GHTFALL_BEFORE_INIT >/dev/null 2>&1; then
  N1GHTFALL_BEFORE_INIT
fi

if typeset -f N1GHTFALL_AFTER_INIT >/dev/null 2>&1; then
  N1GHTFALL_AFTER_INIT
fi
