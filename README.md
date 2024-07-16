# Dependencies
## Lazygit
- [lazygit](https://github.com/jesseduffield/lazygit)
## Telescope fzf native
- cmake and build tools
## Telescope live grep
- [ripgrep](https://github.com/BurntSushi/ripgrep)
## Copilot and CopilotChat
- Node.js (nvm recommended)

# Local configurations
In the configuration directory (`:echo stdpath('config')`) a folder called data will be created the first time, inside the folder two files will be created, lsps and projects. This files are not tracked by git, they are inteded to list your local lsps and projects paths so each machine can have their own. 
## LSP
First install the lsps you want to use using `:Mason` command, then add the lsp name to the lsps file, one per line.

```txt
clangd
pyright
lua_ls
```
## Projects
Add the paths to the projects you want to be discovered by neovim-project. One per line.

Don't end the line with a slash `/`, or the plugin will not detect the path correctly.

```txt
~/.config/nvim
~/src/*
```

# Plugins
Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim), the plugins themselves are in the `lua/plugins/` directory.
