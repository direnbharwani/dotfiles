#!/bin/bash

# Dotfiles Installation Script
# Usage: ./install.sh [tool1] [tool2] ... or ./install.sh (installs all)

set -e

# Available dotfile packages
COMMON_PACKAGES=("zsh" "vim" "nvim" "tmux" "oh-my-posh")

# macOS-specific packages
# added to available packages if on macOS
MACOS_PACKAGES=("aerospace" "borders")

# ------------------------------------------------------------------------------
# Shared Functions
# ------------------------------------------------------------------------------

get_all_packages() {
    local all_packages=("${COMMON_PACKAGES[@]}")
    if [[ "$OSTYPE" == "darwin"* ]]; then
        all_packages+=("${MACOS_PACKAGES[@]}")
    fi
    echo "${all_packages[@]}"
}

# ------------------------------------------------------------------------------
# Logging
# ------------------------------------------------------------------------------
 
# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info    ()  { printf "${BLUE}[INFO]${NC}    %s\n" "$1"; }
log_success ()  { printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"; }
log_warning ()  { printf "${YELLOW}[WARNING]${NC} %s\n" "$1"; }
log_error   ()  { printf "${RED}[ERROR]${NC}   %s\n" "$1"; }

# ------------------------------------------------------------------------------
# Helper Function
# ------------------------------------------------------------------------------

show_help() {
    echo "Dotfiles Installation Script"
    echo ""
    echo "Usage:"
    echo "  $0                    Install all available packages"
    echo "  $0 [packages...]      Install specific packages"
    echo "  $0 -u [packages...]   Uninstall specific packages"
    echo "  $0 -h, --help         Show this help"
    echo ""
    echo "Available packages:"

    local all_packages=($(get_all_packages))
    for package in "${all_packages[@]}"; do
        echo "- $package"
    done
    echo ""
}

check_stow() {
    if ! command -v stow >/dev/null 2>&1; then
        log_error "GNU Stow is required but not installed."
        log_info "Install it with:"
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "  brew install stow"
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo "  sudo pacman -S stow      # Arch"
        fi
        exit 1
    fi
}

# Generic package operation function
process_package() {
    local operation="$1"
    local package="$2"
    local stow_flag="$3"
    
    if [[ ! -d "$package" ]]; then
        log_warning "Package '$package' not found, skipping..."
        return 1
    fi
    
    log_info "${operation} $package..."
    
    if stow -t ~ $stow_flag "$package"; then
        log_success "Successfully ${operation}ed $package"
        return 0
    else
        log_error "Failed to $operation $package"
        return 1
    fi
}

install_package() {
    process_package "install" "$1" ""
}

uninstall_package() {
    process_package "uninstall" "$1" "-D"
}

# ------------------------------------------------------------------------------
# Entry Point
# ------------------------------------------------------------------------------

main() {
    cd "$(dirname "$0")"
    
    check_stow

    local all_packages=($(get_all_packages))
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -u)
                shift
                if [[ $# -eq 0 ]]; then
                    log_error "No packages specified for uninstallation"
                    exit 1
                fi
                
                for package in "$@"; do
                    uninstall_package "$package"
                done
                exit 0
                ;;
            -*)
                log_error "Unknown option: $1"
                show_help
                exit 1
                ;;
            *)
                break
                ;;
        esac
    done
    
    failed_packages=()

    if [[ $# -eq 0 ]]; then
        # Install all packages
        log_info "Installing all available packages..."
        
        for package in "${all_packages[@]}"; do
            if ! install_package "$package"; then
                failed_packages+=("$package")
            fi
        done
    else
        for package in "$@"; do
            if [[ " ${all_packages[*]} " =~ " $package " ]]; then
                if ! install_package "$package"; then
                    failed_packages+=("$package")
                fi
            else
                log_error "Unknown package: $package"
                log_info "Available packages: ${all_packages[*]}"
                failed_packages+=("$package")
            fi
        done
    fi

    if [[ ${#failed_packages[@]} -eq 0 ]]; then
        log_success "All packages installed successfully!"
    else
        log_warning "Some packages failed to install: ${failed_packages[*]}"
    fi

    log_warning "This script only symlink's dotfiles and does not check if the packages have been installed."
}

main "$@"
