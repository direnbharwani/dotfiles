-- Additional tools to install via Mason
-- These are tools like formatters, linters, etc. that aren't LSP servers

local M = {}

M.tools = {
	"stylua", -- Used to format Lua code
	"prettierd", -- Used to format javascript and typescript code
	"shfmt", -- Used to format bash scripts
}

return M

