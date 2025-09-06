#!/usr/bin/env bash
set -euo pipefail

# Script to uninstall Neovim configuration.
# It cleans up cache directories and backs up/removes the config directory.

DEST="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
BACKUP_DIR_PREFIX="${DEST}.bak-"
CLEAN_CACHE_SCRIPT="$(dirname "${BASH_SOURCE[0]}")/clean_nvim_cache.sh"

echo "[*] Starting Neovim configuration uninstallation..."

# 1. Clean Neovim cache
if [ -f "${CLEAN_CACHE_SCRIPT}" ]; then
  echo "[*] Running cache cleanup script: ${CLEAN_CACHE_SCRIPT}"
  bash "${CLEAN_CACHE_SCRIPT}"
else
  echo "[-] Cache cleanup script not found at ${CLEAN_CACHE_SCRIPT}. Skipping cache cleanup."
  echo "    Consider running 'rm -rf ~/.local/share/nvim/lazy ~/.cache/nvim/luacache ~/.local/share/nvim/mason/ ~/.local/state/nvim/shada/*.shada' manually."
fi

# 2. Handle the Neovim config directory
if [ -e "${DEST}" ] || [ -L "${DEST}" ]; then
  # Determine if it's a symlink
  if [ -L "${DEST}" ]; then
    echo "[*] Detected a symlinked Neovim config: ${DEST}"
    echo "[*] Removing symlink: ${DEST}"
    rm "${DEST}"
    echo "[+] Symlink removed."
  else
    # It's a regular directory, back it up
    TIMESTAMP=$(date +%Y%m%d%H%M%S)
    BACKUP_PATH="${BACKUP_DIR_PREFIX}${TIMESTAMP}"
    echo "[*] Backing up existing Neovim config to ${BACKUP_PATH}"
    mv "${DEST}" "${BACKUP_PATH}"
    echo "[+] Configuration backed up and removed from ${DEST}."
  fi
else
  echo "[*] Neovim configuration directory '${DEST}' does not exist. Nothing to uninstall."
fi

echo "[+] Neovim configuration uninstallation complete."
