#!/bin/bash

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

preview() {
  local base_dir="$1"
  local pkg_name="$2"
  local pkg_path="$base_dir/$pkg_name"

  echo "Preview: stow $pkg_name from $base_dir"

  # Find all top-level symlink targets inside the stow package
  find "$pkg_path" -mindepth 1 -maxdepth 1 -print0 | while IFS= read -r -d '' item; do
    # Compute relative path from stow package root (e.g. .config)
    local rel_path="${item#$pkg_path/}"

    # Full target path = $HOME + relative path (e.g. ~/.config)
    local target_path="$HOME/$rel_path"
    target_path="${target_path/#$HOME/~}"  # Pretty output with ~

    # If it's a directory (like .config), list subdirs inside it (e.g. nvim, tmux)
    if [[ -d "$item" ]]; then
      find "$item" -mindepth 1 -maxdepth 1 -type d -print0 | while IFS= read -r -d '' subitem; do
        local sub_rel_path="${subitem#$pkg_path/}"
        local sub_target_path="$HOME/$sub_rel_path"
        sub_target_path="${sub_target_path/#$HOME/~}"

        echo "     $sub_target_path -> $(realpath "$subitem")"
      done
    else
      echo "     $target_path -> $(realpath "$item")"
    fi
  done
}

install_packages() {
  local dir="$1"

  local pkg
  for pkg in "$dir"/*/; do
    [ -d "$pkg" ] || continue
    pkg_name=$(basename "$pkg")

    # If --only is set, skip all other packages that do not match
    if [[ -n "$TARGET_PACKAGE" && "$pkg_name" != "$TARGET_PACKAGE" ]]; then
      continue
    fi
    
    case "$MODE" in
      install)
        echo "🔗 Stowing $pkg_name from $dir..."
        (cd "$dir" && stow -v -R -t "$HOME" "$pkg_name")
        ;;
      uninstall)
        echo "🔗 Unstowing $pkg_name from $dir..."
        (cd "$dir" stow -v -D -t "$HOME" "$pkg_name")
        ;;
      preview)
        preview "$dir" "$pkg_name"
        ;;
    esac
  done
}

post_install() {
  echo "Running post-install hooks..."

  if [[ -n "$TARGET_PACKAGE" || "$TARGET_PACKAGE" == "tmux" ]]; then
    local tpm_dir="$HOME/.config/tmux/plugins/tpm"

    if [[ ! -d "$tpm_dir" ]]; then
      echo "Installing TPM (Tmux Plugin Manager)..."
      git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    else
      echo "TPM already installed at $tpm_dir"
    fi

    if command -v tmux >/dev/null 2>&1;then
      echo "Installing tmux plugins..."
      tmux start-server
      tmux new-session -d
      "$tpm_dir/bin/install_plugins"
      tmux kill-server
    else
      echo "Error: tmux not found! Skipping plugin install"
    fi
  fi


  echo "Post-install complete!"
}

# -----------------------------------------------------------------------------
# Main Flow
# -----------------------------------------------------------------------------

# Fast-fail: stops script immediately on failure with non-zero exit code
set -e
# Forces script to run from root
cd "$(dirname $0)" 

# Check if stow is installed
if ! command -v stow >/dev/null 2>&1; then
  echo "❌ Error: 'stow' is not installed."
  echo "👉 Please install it using your package manager:"
  echo "  - macOS: brew install stow"
  echo "  - Arch Linux: sudo pacman -S stow"
  exit 1
fi

# Detect OS
OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM="macOS" ;;
  Linux)  PLATFORM="linux" ;;
  *)      echo "❌ Unsupported OS: $OS"; exit 1 ;;
esac

# Modes
MODE="install"
for arg in "$@"; do
  case "$arg" in
    -p | --preview) 
      MODE="preview"
      ;;
    --target=*)
      TARGET_PACKAGE="${arg#--target=}"
      ;;
    -u | --uninstall)       
      MODE="uninstall"
      ;;
    *)
      echo "❌ Unknown option: $1"
      exit 1
  esac
done

echo "Platform: $PLATFORM | Mode: $MODE"
echo "---------------------------------"
if [[ -n $TARGET_PACKAGE ]]; then
  echo "Target: $TARGET_PACKAGE"
  echo ""
fi

install_packages "common"
install_packages "$PLATFORM"

if [[ "$MODE" == "install" ]]; then
  post_install 
fi
