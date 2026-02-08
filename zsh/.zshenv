# Environment variables - loaded for ALL shells

# Homebrew setup (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]; then
  if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
  elif [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # Ensure Homebrew bin is first (override path_helper behavior)
  if [[ -d "/opt/homebrew/bin" ]]; then
    PATH="${PATH//\/opt\/homebrew\/bin:/}"  # Remove from middle
    PATH="${PATH//\/opt\/homebrew\/bin/}"   # Remove from end
    export PATH="/opt/homebrew/bin:$PATH"
  fi
fi

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
  eval "$(pyenv init - zsh)"
fi

# Rust
if [[ -d "$HOME/.cargo" ]]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

# User binaries
[[ -d "$HOME/bin" && ":$PATH:" != *":$HOME/bin:"* ]] && export PATH="$HOME/bin:$PATH"
