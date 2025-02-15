<p align="center">
  <img src="https://user-images.githubusercontent.com/6705160/118490159-f064bb00-b71d-11eb-883e-4affbd020074.png" alt="nvim-lsp-installer" width="60%" />
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/6705160/130315792-43865221-9574-4f24-90fb-3de745fff1ef.gif" width="650" />
</p>

## About

Companion plugin for [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) that allows you to seamlessly install
LSP servers locally (inside `:echo stdpath("data")`).

On top of just providing commands for installing & uninstalling LSP servers, it:

-   provides configurations for servers that aren't supported by nvim-lspconfig (`eslint`)
-   provides Lua APIs for non-standard LSP functionalities, for example `_typescript.applyRenameFile`
-   has support for a variety of different install methods (e.g., [google/zx](https://github.com/google/zx))
-   common install tasks are abstracted behind Lua APIs
-   provides adapters that offer out-of-the-box integrations with other plugins

Inspired by [nvim-lspinstall](https://github.com/kabouzeid/nvim-lspinstall).

## Installation

Requires:

-   neovim `>= 0.5.0`
-   [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
-   bash(1), git(1), wget(1), unzip(1), tar(1)
-   (optional) Node.js (LTS) & npm. Some LSP servers will need a Node runtime.
-   (optional) Python3 & pip3. Some LSP servers will need a Python3 runtime.
-   (optional) go. Some LSP servers will need a Go runtime.
-   (optional) javac. Some LSP servers will need a Javac (1.8+) compiler.

### [Packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    'neovim/nvim-lsp-config',
    'williamboman/nvim-lsp-installer',
}
```

### vim-plug

```vim
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
```

## Usage

### Commands

-   `:LspInstall <server>` - installs/reinstalls a language server
-   `:LspUninstall <server>` - uninstalls a language server
-   `:LspUninstallAll` - uninstalls all language servers
-   `:LspPrintInstalled` - prints all installed language servers

### Setup

```lua
local lsp_installer = require("nvim-lsp-installer")

function common_on_attach(client, bufnr)
    -- ... set up buffer keymaps, etc.
end

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = common_on_attach,
    }

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
```

For more advanced use cases you may also interact with more APIs nvim-lsp-installer has to offer, for example the following (refer to `:help nvim-lsp-installer` for more docs):

```lua
local lsp_installer = require'nvim-lsp-installer'

local ok, rust_analyzer = lsp_installer.get_server("rust_analyzer")
if ok then
    if not rust_analyzer:is_installed() then
        rust_analyzer:install()
    end
end
```

## Available LSPs

| Language                      | Server name              |
| ----------------------------- | ------------------------ |
| Angular                       | `angularls`              |
| Ansible                       | `ansiblels`              |
| Bash                          | `bashls`                 |
| C#                            | `omnisharp`              |
| C++                           | `clangd`                 |
| CMake                         | `cmake`                  |
| CSS                           | `cssls`                  |
| Clojure                       | `clojure_lsp`            |
| Deno                          | `denols`                 |
| Docker                        | `dockerls`               |
| EFM (general purpose server)  | `efm`                    |
| ESLint [(docs)][eslintls]     | `eslintls`               |
| Elixir                        | `elixirls`               |
| Elm                           | `elmls`                  |
| Ember                         | `ember`                  |
| Fortran                       | `fortls`                 |
| Go                            | `gopls`                  |
| GraphQL                       | `graphql`                |
| Groovy                        | `groovyls`               |
| HTML                          | `html`                   |
| Haskell                       | `hls`                    |
| JSON                          | `jsonls`                 |
| Jedi                          | `jedi_language_server`   |
| Kotlin                        | `kotlin_language_server` |
| LaTeX                         | `texlab`                 |
| Lua                           | `sumneko_lua`            |
| PHP                           | `intelephense`           |
| PureScript                    | `purescriptls`           |
| Python                        | `pylsp`                  |
| Python                        | `pyright`                |
| Rome                          | `rome`                   |
| Ruby                          | `solargraph`             |
| Rust                          | `rust_analyzer`          |
| SQL                           | `sqlls`                  |
| SQL                           | `sqls`                   |
| Stylelint                     | `stylelint_lsp`          |
| Svelte                        | `svelte`                 |
| Tailwind CSS                  | `tailwindcss`            |
| Terraform                     | `terraformls`            |
| Terraform [(docs)][tflint]    | `tflint`                 |
| TypeScript [(docs)][tsserver] | `tsserver`               |
| VimL                          | `vimls`                  |
| Vue                           | `vuels`                  |
| YAML                          | `yamlls`                 |

[eslintls]: ./lua/nvim-lsp-installer/servers/eslintls/README.md
[tflint]: ./lua/nvim-lsp-installer/servers/tflint/README.md
[tsserver]: ./lua/nvim-lsp-installer/servers/tsserver/README.md

## Custom servers

You can create your own installers by using the same APIs nvim-lsp-installer itself uses. Refer to
[CUSTOM_SERVERS.md](./CUSTOM_SERVERS.md) for more information.

## Adapters (experimental)

Make sure to only attempt connecting adapters once the plugin(s) involved have been loaded.

### [kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)

```lua
require'nvim-lsp-installer.adapters.nvim-tree'.connect()
```

Supported capabilities:

-   `_typescript.applyRenameFile`. Automatically executes the rename file client request when renaming a node.

## Logo

Illustrations in the logo are derived from [@Kaligule](https://schauderbasis.de/)'s "Robots" collection.

## Roadmap

-   Managed versioning of installed servers
-   Command (and corresponding Lua API) to update outdated servers (e.g., `:LspUpdate {server}`)
-   Cross-platform CI for all server installers
