local server = require "nvim-lsp-installer.server"
local path = require "nvim-lsp-installer.path"
local zx = require "nvim-lsp-installer.installers.zx"

local root_dir = server.get_server_root_path "terraform"

return server.Server:new {
    name = "terraformls",
    root_dir = root_dir,
    installer = zx.file "./install.mjs",
    default_options = {
        cmd = { path.concat { root_dir, "terraform-ls", "terraform-ls" }, "serve" },
    },
}
