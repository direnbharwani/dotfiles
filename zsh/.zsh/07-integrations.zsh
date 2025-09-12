# Shell integrations and terminal setup

export TERM="xterm-256color"

# Interactive shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Startup display
fastfetch
echo ""