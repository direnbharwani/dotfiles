-- Automatically loads all server configurations from individual files
-- Add new server files to this directory and they'll be automatically included

local M = {}

-- List of server files to load (without .lua extension)
local server_files = {
	"basedpyright",
	"bashls",
	"marksman",
	"lua_ls",
	"rust_analyzer",
}

-- Load all server configurations
M.servers = {}
for _, server in ipairs(server_files) do
	M.servers[server] = require("cocoa.lsp.servers." .. server)
end

return M
