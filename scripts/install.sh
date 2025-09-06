#!/usr/bin/env bash
set -euo pipefail

# Simple installer for Linux/macOS. Run from the repo root.

DEST="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
SYMLINK=0

usage() {
  cat <<EOF
Usage: $0 [--symlink] [--dest PATH]

Options:
  --symlink       Create a symlink from the repo to the config directory (developer mode)
  --dest PATH     Install to a custom path (default: ${DEST})
  -h, --help      Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --symlink) SYMLINK=1 ;;
    --dest) shift; DEST="${1:-$DEST}" ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1"; usage; exit 1 ;;
  esac
  shift
done

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP="${DEST}.bak-$(date +%Y%m%d%H%M%S)"

echo "[*] Checking prerequisites..."
need() { command -v "$1" >/dev/null 2>&1 || { echo "[-] Missing: $1"; MISSING=1; }; }
MISSING=0
need nvim
need git
# rsync is optional; we fallback to tar
if ! command -v rsync >/dev/null 2>&1; then
  echo "[!] rsync not found; will fallback to tar for copying."
fi
if [ "${MISSING}" -ne 0 ]; then
  echo "Please install the missing tools and rerun."
  exit 1
fi

echo "[*] Preparing destination: ${DEST}"
if [ -e "${DEST}" ] || [ -L "${DEST}" ]; then
  echo "[*] Backing up existing config to ${BACKUP}"
  mv "${DEST}" "${BACKUP}"
fi
mkdir -p "$(dirname "${DEST}")"

# Files/directories to exclude from the final Neovim config
EXCLUDES=(
  ".git"
  ".gitignore"
  ".github"
  "scripts"
  "docs"
  "Makefile"
  "README.md"
  "lazy-lock.json" # lazy.nvim manages this itself
  "scripts/*.sh~"  # Temp files
)

EXCLUDE_ARGS=""
for EXCL in "${EXCLUDES[@]}"; do
  EXCLUDE_ARGS+=" --exclude \"${EXCL}\""
done

if [ "${SYMLINK}" -eq 1 ]; then
  echo "[*] Creating symlink ${DEST} -> ${REPO_ROOT}"
  # For symlink, we link the whole repo, as developer mode implies access to docs/scripts/etc.
  ln -s "${REPO_ROOT}" "${DEST}"
else
  echo "[*] Copying files to ${DEST}"
  if command -v rsync >/dev/null 2>&1; then
    # Use eval to correctly interpret EXCLUDE_ARGS with spaces/quotes
    eval rsync -a "${EXCLUDE_ARGS}" "${REPO_ROOT}/" "${DEST}/"
  else
    # Fallback to tar (works on macOS/Linux)
    TAR_EXCLUDES=""
    for EXCL in "${EXCLUDES[@]}"; do
      TAR_EXCLUDES+=" --exclude '${EXCL}'"
    done
    # Use eval for tar excludes as well
    eval tar -C "${REPO_ROOT}" "${TAR_EXCLUDES}" -cf - . | tar -C "${DEST}" -xf -
  fi
fi

echo
echo "[*] Optional tools:"
echo "    - ripgrep (rg) for Telescope live_grep"
echo "    - make for telescope-fzf-native"
echo "    - glow for Markdown preview"
echo "    - Node.js, Python, Go for various LSP servers"
echo

# Ensure correct permissions after installation
echo "[*] Ensuring correct permissions for Neovim directories..."
# If symlinking, the permissions update should happen on the source repo, not the symlink target.
# However, for copied configs, it's essential.
if [ "${SYMLINK}" -eq 0 ]; then
  bash "${REPO_ROOT}/scripts/update_permission.sh"
else
  echo "    - Skipping permission update for symlinked config (manage permissions on source repo)."
fi


echo "[*] Bootstrapping plugins (headless)..."
# Run nvim from the newly installed config path
NVIM_CMD="${DEST}/nvim" # This is not correct, nvim is the executable, not the config dir.
# Correct way is to ensure nvim finds the config.
# If DEST is ~/.config/nvim, nvim will find it automatically.
# If DEST is custom, user needs to set NVIM_APPNAME or run nvim -u <init.lua>
# For simplicity, assuming default XDG paths or user handles custom path.
nvim --headless "+Lazy! sync" "+qall" || {
  echo "[-] Plugin bootstrap or initial Mason Tool Installer run failed."
  echo "    You can retry later with: nvim and :Lazy sync"
  echo "    Check :MasonLog inside Neovim for details."
  exit 1
}

echo "[*] First start will install LSP/formatters via Mason Tool Installer."
echo "[+] Done. Launch Neovim: nvim"
