#!/usr/bin/env bash
# Install mps-terminal-vim system packages on Fedora (dnf). Idempotent.
# Toggles (defaults match the odem.terminal.vim role):
#   MPS_VIM_ENABLE_PACKAGES / MPS_VIM_ENABLE_LUA / MPS_VIM_ENABLE_XCLIP
set -euo pipefail

ENABLE_PACKAGES="${MPS_VIM_ENABLE_PACKAGES:-1}"
ENABLE_LUA="${MPS_VIM_ENABLE_LUA:-1}"
ENABLE_XCLIP="${MPS_VIM_ENABLE_XCLIP:-1}"

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

if [[ "${ENABLE_PACKAGES}" = 1 ]]; then
    ${SUDO} dnf install -y vim-enhanced
fi
if [[ "${ENABLE_LUA}" = 1 ]]; then
    ${SUDO} dnf install -y lua lua-devel
fi
if [[ "${ENABLE_XCLIP}" = 1 ]]; then
    ${SUDO} dnf install -y xclip
fi
echo "mps-terminal-vim packages installed (fedora)."