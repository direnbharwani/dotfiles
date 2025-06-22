#!/bin/bash

# -----------------------------------------------------------------------------
# Logging
# -----------------------------------------------------------------------------

logf() {
  local color="$1"; shift
  local label="$1"; shift
  local fmt="$1"; shift

  if [[ -n "$label" ]]; then
      printf "\033[%sm%s %s\033[0m\n" "$color" "$label" "$(printf "$fmt" "$@")"
  else
      printf "\033[%sm%s\033[0m\n" "$color" "$(printf "$fmt" "$@")"
  fi
}

info()    { logf "1"      ""          "$@"; }  # bold default
success() { logf "1;32"   "[SUCCESS]" "$@"; }  # bold green
warn()    { logf "1;33"   "[WARN]"    "$@"; }  # bold yellow
error()   { logf "1;31"   "[ERROR]"   "$@"; }  # bold red
note()    { logf "1;36"   ""          "$@"; }  # bold cyan

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

detect_package_manager() {
  local package_managers=(
    "brew"
    "pacman"
    "apt"
  )

  for package_manager in "${package_managers[@]}"; do
    if command_exists "$package_manager"; then
      echo "$package_manager"
      return
    fi
  done
}


# -----------------------------------------------------------------------------
# Package Management Functions
# -----------------------------------------------------------------------------

preview() {
  local base_dir="$1"
  local pkg_name="$2"
  local pkg_path="$base_dir/$pkg_name"

  info "Preview: stow $pkg_name from $base_dir"

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

        note "    $sub_target_path -> $(realpath "$subitem")"
        echo ""
      done
    else
      note "    $target_path -> $(realpath "$item")"
      echo ""
    fi
  done
}

install_package_configs() {
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
        echo "Stowing $pkg_name from $dir..."
        (cd "$dir" && stow -v -R -t "$HOME" "$pkg_name")
        ;;
      uninstall)
        echo "Unstowing $pkg_name from $dir..."
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

    if command_exists tmux; then
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

# Vars
OS="$(uname -s)"
MODE="install"
PACKAGE_MANAGER=""

# Check if stow is installed
if ! command_exists stow; then
  error "'stow' is not installed."
  note  "Please install it using your package manager:"
  note  "  - macOS: brew install stow"
  note  "  - Arch Linux: sudo pacman -S stow"
  exit 1
fi

# Detect OS
case "$OS" in
  Darwin) PLATFORM="macOS" ;;
  Linux)  PLATFORM="linux" ;;
  *)      error "Unsupported OS: $OS"; exit 1 ;;
esac

# Modes
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
      echo "Unknown option: $1"
      exit 1
  esac
done


package_manager=$(detect_package_manager)
if [[ -z "$package_manager" ]]; then
  error "No supported package manager found. Refer to help page or README."
  exit 1
fi

echo "--------------------------------"
echo "Install Script Info"
echo "--------------------------------"
info "%-16s %-5s" "Platform:" "$PLATFORM"
info "%-16s %-5s" "Package Manager:" "$package_manager"
info "%-16s %-5s" "Mode:" "$MODE"
echo "--------------------------------"
echo ""

if [[ -n $TARGET_PACKAGE ]]; then
  echo "Target: $TARGET_PACKAGE"
  echo ""
fi

install_package_configs "common"
install_package_configs "$PLATFORM"

# if [[ "$MODE" == "install" ]]; then
#   post_install 
# fi
