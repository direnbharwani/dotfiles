-- [[ Boostrap lazy.nvim: A Neovim Plugin Manager]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Checks for existence of lazy.nvim installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none", -- partial clone
		"--branch=stable", -- Latest Stable Release
		lazyrepo,
		lazypath,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
	end
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({
	{ import = "cocoa.plugins" },
	{ import = "cocoa.plugins.git" },
	{ import = "cocoa.plugins.markdown" },
	{ import = "cocoa.plugins.themes" },
	{ import = "cocoa.plugins.utils" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
