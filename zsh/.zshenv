# Environment variables - loaded for ALL shells

if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

# Go
if command -v go >/dev/null 2>&1 || [[ -d "$HOME/.local/share/go" ]]; then
  export GOPATH="$HOME/.local/share/go"
fi

# pyenv
if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
fi

# Rust
if [[ -d "$HOME/.cargo" ]]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

# User binaries
[[ -d "$HOME/bin" && ":$PATH:" != *":$HOME/bin:"* ]] && export PATH="$HOME/bin:$PATH"
