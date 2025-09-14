-- Additional tools to install via Mason
-- These are tools like formatters, linters, etc. that aren't LSP servers

local M = {}

M.tools = {
	"codespell", -- Used for spell checking
	"shfmt", -- Used to format bash scripts
	"stylua", -- Used to format Lua code
	"prettierd", -- Used to format javascript and typescript code
}

return M
