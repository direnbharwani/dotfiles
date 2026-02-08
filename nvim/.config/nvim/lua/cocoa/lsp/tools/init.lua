-- Additional tools to install via Mason
-- These are tools like formatters, linters, etc. that aren't LSP servers

local M = {}

M.tools = {
	"codespell", -- Spell Checker
	"prettierd", -- JavaScript & TypeScript Formatting
	"shfmt", -- Bash Formatting
	"stylua", -- Lua Formatting
}

return M
