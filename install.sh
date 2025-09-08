#!/bin/bash

# Dotfiles Installation Script
# Usage: ./install.sh [tool1] [tool2] ... or ./install.sh (installs all)

set -e

# Available dotfile packages
AVAILABLE_PACKAGES=("zsh")

# macOS-specific packages
# added to available packages if on macOS
MACOS_PACKAGES=("aerospace")
if [[ "$OSTYPE" == "darwin"* ]]; then
    AVAILABLE_PACKAGES+=("${MACOS_PACKAGES[@]}")
fi

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
    for package in "${AVAILABLE_PACKAGES[@]}"; do
        echo "  - $package"
    done
    echo ""
    if [[ ${#MACOS_PACKAGES[@]} -gt 0 ]]; then
        echo "macOS-specific packages:"
        for package in "${MACOS_PACKAGES[@]}"; do
            echo "  - $package"
        done
        echo ""
    fi
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

install_package() {
    local package="$1"
    
    if [[ ! -d "$package" ]]; then
        log_warning "Package '$package' not found, skipping..."
        return 1
    fi
    
    log_info "Installing $package..."
    
    if stow -t ~ "$package"; then
        log_success "Successfully installed $package"
        return 0
    else
        log_error "Failed to install $package"
        return 1
    fi
}

uninstall_package() {
    local package="$1"
    
    if [[ ! -d "$package" ]]; then
        log_warning "Package '$package' not found, skipping..."
        return 1
    fi
    
    log_info "Uninstalling $package..."
    
    if stow -t ~ -D "$package"; then
        log_success "Successfully uninstalled $package"
        return 0
    else
        log_error "Failed to uninstall $package"
        return 1
    fi
}

# ------------------------------------------------------------------------------
# Entry Point
# ------------------------------------------------------------------------------

main() {
    cd "$(dirname "$0")"
    
    check_stow
    
    # Parse arguments
    if [[ $# -eq 0 ]]; then
        # Install all packages
        log_info "Installing all available packages..."
        failed_packages=()
        
        for package in "${AVAILABLE_PACKAGES[@]}"; do
            if ! install_package "$package"; then
                failed_packages+=("$package")
            fi
        done
        
        if [[ ${#failed_packages[@]} -eq 0 ]]; then
            log_success "All packages installed successfully!"
        else
            log_warning "Some packages failed to install: ${failed_packages[*]}"
        fi
        
    elif [[ "$1" == "-h" || "$1" == "--help" ]]; then
        show_help
        
    elif [[ "$1" == "-u" ]]; then
        # Uninstall mode
        shift
        if [[ $# -eq 0 ]]; then
            log_error "No packages specified for uninstallation"
            exit 1
        fi
        
        for package in "$@"; do
            uninstall_package "$package"
        done
        
    else
        # Install specific packages
        failed_packages=()
        
        for package in "$@"; do
            if [[ " ${AVAILABLE_PACKAGES[*]} " =~ " $package " ]]; then
                if ! install_package "$package"; then
                    failed_packages+=("$package")
                fi
            else
                log_error "Unknown package: $package"
                log_info "Available packages: ${AVAILABLE_PACKAGES[*]}"
                failed_packages+=("$package")
            fi
        done
        
        if [[ ${#failed_packages[@]} -eq 0 ]]; then
            log_success "All specified packages installed successfully!"
        else
            log_warning "Some packages failed to install: ${failed_packages[*]}"
        fi
    fi
}

main "$@"
