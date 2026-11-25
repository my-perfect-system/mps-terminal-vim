#!/usr/bin/env bash
# Deploy mps-terminal-vim to the current user's home. Idempotent.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VIM_SRC="${SRC}/config/vim"

# .vimrc is config: deploy (overwrite) on every install.
install -m 0644 "${VIM_SRC}/.vimrc" "${HOME}/.vimrc"

# NERDTree bookmarks are user state: deploy the seed only if none exists yet —
# never overwrite what the user bookmarked.
[[ -f "${HOME}/.NERDTreeBookmarks" ]] || install -m 0644 "${VIM_SRC}/.NERDTreeBookmarks" "${HOME}/.NERDTreeBookmarks"

echo "mps-terminal-vim deployed to ${HOME}/.vimrc. Run: vi"