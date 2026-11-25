#!/usr/bin/env bash
# Deploy mps-terminal-vim to the current user's home. Idempotent.
# OS-specific packages live in install-debian.sh / install-fedora.sh and are
# installed best-effort before the config deploy.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VIM_SRC="${SRC}/config/vim"

#--- Distro detection -----------------------------------------------------------
detect_distro() {
    local id
    id="$(grep -sE '^ID=' /etc/os-release | head -1 | cut -d= -f2 | tr -d '\"')"
    case "${id}" in
        debian|ubuntu) echo "debian" ;;
        fedora|rhel)   echo "fedora" ;;
        *)
            if command -v apt-get >/dev/null 2>&1; then echo "debian"
            elif command -v dnf >/dev/null 2>&1; then echo "fedora"
            else echo "none"; fi ;;
    esac
}

#--- System packages (best-effort: config deploys even without sudo rights) ----
case "$(detect_distro)" in
    debian) "${SRC}/install-debian.sh" || echo "==> WARN: install-debian.sh failed; deploying config only" ;;
    fedora)  "${SRC}/install-fedora.sh" || echo "==> WARN: install-fedora.sh failed; deploying config only" ;;
    *)       echo "==> Unsupported distro — skipping system packages" ;;
esac

#--- Config deploy ---------------------------------------------------------------
# .vimrc is config: deploy (overwrite) on every install.
install -m 0644 "${VIM_SRC}/.vimrc" "${HOME}/.vimrc"

# NERDTree bookmarks are user state: deploy the seed only if none exists yet —
# never overwrite what the user bookmarked.
[[ -f "${HOME}/.NERDTreeBookmarks" ]] || install -m 0644 "${VIM_SRC}/.NERDTreeBookmarks" "${HOME}/.NERDTreeBookmarks"

echo "mps-terminal-vim deployed to ${HOME}/.vimrc. Run: vi"