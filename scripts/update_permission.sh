#!/usr/bin/env bash
set -euo pipefail

# Script to ensure correct user permissions for Neovim configuration and data directories.
# This is useful if directories were created with root privileges or have incorrect ownership.

echo "[*] Ensuring correct user permissions for Neovim directories..."

# Get the current user's name
CURRENT_USER=$(whoami)

# Define common Neovim-related directories relative to user's home
# Using XDG Base Directory Specification for better compatibility
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
NVIM_SHARE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
NVIM_STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/nvim"
NVIM_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/nvim"

# Add npm cache directory
NPM_CACHE_DIR="${HOME}/.npm" # Default npm cache location

# Array of directories to fix permissions for
declare -a DIRS_TO_FIX=(
    "${NVIM_CONFIG_DIR}"
    "${NVIM_SHARE_DIR}"
    "${NVIM_STATE_DIR}"
    "${NVIM_CACHE_DIR}"
    "${NPM_CACHE_DIR}"
)

for dir in "${DIRS_TO_FIX[@]}"; do
    # Check if the directory exists and is not a symlink
    if [ -d "$dir" ] && ! [ -L "$dir" ]; then
        # Get the current owner of the directory
        CURRENT_OWNER=$(stat -c '%U' "$dir" 2>/dev/null || echo "unknown")

        if [ "$CURRENT_OWNER" = "$CURRENT_USER" ]; then
            echo "    - Permissions already correct for: $dir (owner: $CURRENT_OWNER)"
        else
            echo "    - Fixing ownership for: $dir (current owner: $CURRENT_OWNER, desired: $CURRENT_USER)"
            # Set owner to CURRENT_USER. The group will automatically be set to the user's primary group.
            sudo chown -R "${CURRENT_USER}" "$dir"
        fi
    else
        # If it's a symlink, we generally don't want to change ownership of the target.
        # If it doesn't exist, we can't change its ownership.
        echo "    - Directory not found or is a symlink (skipping ownership check): $dir"
    fi
done

echo "[+] Permissions updated successfully (or already correct)."
