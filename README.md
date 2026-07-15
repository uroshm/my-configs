# my-configs

My personal dotfiles for a macOS terminal-based dev environment. Everything is Tokyo Night / Rose Pine themed and Vim-driven.

## What's here

| Path | Tool | Highlights |
|------|------|-----------|
| `ghostty/config` | [Ghostty](https://ghostty.org) terminal | Tokyo Night palette, JetBrainsMono Nerd Font, 95% opacity, hidden titlebar, zsh as default shell |
| `tmux/.tmux.conf` | tmux | Backtick (`` ` ``) prefix, vim-style pane nav (`h/j/k/l`), mouse on, status bar on top, Rose Pine theme |
| `zsh/.zshrc` | Zsh | Starship prompt, ghost-complete, Homebrew, aliases for git/gradle/npm/docker, secrets loaded from macOS Keychain |
| `nvim/` | Neovim (kickstart-based) | lazy.nvim, Telescope, LSP + Mason, blink.cmp, Treesitter, conform, nvim-tree, snacks (inline images), Tokyo Night |
| `vim/.vimrc` | Legacy Vim | vim-plug with NERDTree, fzf, coc.nvim (Java LSP) |

## Notable choices

- **Editor:** Neovim is the primary editor (`nvim/`); the `.vimrc` is a lighter legacy fallback.
- **Neovim plugins** are pinned via `nvim/lazy-lock.json`; personal specs live in `nvim/lua/plugins.lua`, core config in `nvim/init.lua` (leader = `<Space>`).
- **Secrets:** API keys (Anthropic, AWS) are never stored in files - they're pulled from the macOS Keychain at shell startup via a `keychain_secret` helper. Add one with:
  ```sh
  security add-generic-password -U -a "$USER" -s NAME -w
  ```
- **Java toolchain:** `JAVA_HOME` points at Temurin 21; lots of Gradle aliases (`ts`, `br`, `grdb`, `sp`, ...).
