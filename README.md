# mps-terminal-vim

Vim configuration of the [my-perfect-system](https://github.com/my-perfect-system) (mps) terminal stack — a lean `.vimrc` plus NERDTree bookmarks seed.

## Install

| Method | Description |
|---|---|
| Default | `bootstrap.sh` clones to the system-wide mps repo dir and runs `install.sh` |
| Ansible | can be used by installing via the `odem.terminal.vim` role of [odem-terminal](https://github.com/my-perfect-system/odem-terminal) |
| Standalone | clone the repo, then run `./install.sh` inside it; no network needed |

### Install (Default)

```bash
curl -fsSL https://raw.githubusercontent.com/my-perfect-system/mps-terminal-vim/main/bootstrap.sh | bash
```

All methods deploy `config/vim/.vimrc` to the current user's `~/.vimrc` and seed
`~/.NERDTreeBookmarks` only if absent (bookmarks are user state — never
overwritten). One clone per host
(`${MPS_REPO_DIR:-/srv/repo/github/my-perfect-system/mps}`), shared by all users.

## Usage

```bash
vi file.txt                      # open a file in vim
sv /etc/hosts                    # sudo vim (alias from mps-terminal-bash-aliases)
cfg-vim                          # edit ~/.vimrc
```