#!/usr/bin/env bash
# Install mps-terminal-vim system packages on Debian (apt). Idempotent.
# Toggles (defaults match the odem.terminal.vim role):
#   MPS_VIM_ENABLE_PACKAGES / MPS_VIM_ENABLE_LUA / MPS_VIM_ENABLE_XCLIP
set -euo pipefail

ENABLE_PACKAGES="${MPS_VIM_ENABLE_PACKAGES:-1}"
ENABLE_LUA="${MPS_VIM_ENABLE_LUA:-1}"
ENABLE_XCLIP="${MPS_VIM_ENABLE_XCLIP:-1}"

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

if [[ "${ENABLE_PACKAGES}" = 1 ]]; then
    ${SUDO} apt-get install -y \
        vim-nox vim-addon-manager vim-airline vim-gruvbox vim-ale vim-autopep8 \
        vim-ctrlp vim-fugitive vim-gitgutter vim-snippets vim-syntastic \
        vim-youcompleteme
fi
if [[ "${ENABLE_LUA}" = 1 ]]; then
    ${SUDO} apt-get install -y liblua5.3-dev liblua5.1-dev lua5.1 lua5.3
fi
if [[ "${ENABLE_XCLIP}" = 1 ]]; then
    ${SUDO} apt-get install -y xclip
fi
echo "mps-terminal-vim packages installed (debian)."