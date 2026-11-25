#!/usr/bin/env bash
# Bootstrap mps-terminal-vim: clone/update the system-wide mps repo dir, run install.sh.
# Standalone usage:
#   curl -fsSL https://raw.githubusercontent.com/my-perfect-system/mps-terminal-vim/main/bootstrap.sh | bash
set -euo pipefail

#--- Repo configuration -------------------------------------------------------
REPO_NAME="mps-terminal-vim"
REPO_URL="https://github.com/my-perfect-system/${REPO_NAME}.git"
# Default system-wide mps repo dir — one clone per host, shared by every user
# and by the odem.terminal.vim ansible role (identity_default_repo_dir_mps).
# Override per invocation with the MPS_REPO_DIR env var.
REPO_DIR_DEFAULT="/srv/repo/github/my-perfect-system"

REPO_DIR="${MPS_REPO_DIR:-${REPO_DIR_DEFAULT}}"
DEST="${REPO_DIR}/${REPO_NAME}"

# The system repo dir is root-owned; clone/pull need elevation as a user.
# sudo prompts read the terminal tty, not the curl pipe.
SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

if [ -d "${DEST}/.git" ]; then
    echo "==> Updating ${DEST}"
    # Users without sudo rights keep the clone an admin installed.
    ${SUDO} git -C "${DEST}" pull --ff-only || echo "==> Pull failed, keeping existing clone"
else
    echo "==> Cloning ${REPO_URL}"
    ${SUDO} install -d -m 0755 "${REPO_DIR}"
    ${SUDO} git clone --depth 1 "${REPO_URL}" "${DEST}"
fi

# install.sh runs as the invoking user and deploys to their own home.
exec bash "${DEST}/install.sh"