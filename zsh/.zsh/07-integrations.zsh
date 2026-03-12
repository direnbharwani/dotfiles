# Shell integrations and terminal setup

export TERM="xterm-256color"

# Interactive shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# pyenv init (interactive shells only)
if [[ -d "$HOME/.pyenv" ]]; then
  eval "$(pyenv init - zsh)"
fi

# global direnv activation
eval "$(direnv hook zsh)"

# Worktrunk
if command -v wt >/dev/null 2>&1; then 
  eval "$(command wt config shell init zsh)";
fi

# Startup display
fastfetch
echo ""
