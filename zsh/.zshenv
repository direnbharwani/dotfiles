# Environment variables - loaded for ALL shells

if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# Go
if command -v go >/dev/null 2>&1 || [[ -d "$HOME/.local/share/go" ]]; then
  export GOPATH="$HOME/.local/share/go"
fi

# Rust
if [[ -d "$HOME/.cargo" ]]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

# User binaries
[[ -d "$HOME/bin" && ":$PATH:" != *":$HOME/bin:"* ]] && export PATH="$HOME/bin:$PATH"
