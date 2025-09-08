-- Mason tool installer setup
local M = {}

function M.setup(servers, additional_tools)
	-- Ensure the servers and tools above are installed
	--
	-- To check the current status of installed tools and/or manually install
	-- other tools, you can run
	--    :Mason
	--
	-- You can press `g?` for help in this menu.
	--
	-- `mason` had to be setup earlier: to configure its options see the
	-- `dependencies` table for `nvim-lspconfig` above.
	--
	-- You can add other tools here that you want Mason to install
	-- for you, so that they are available from within Neovim.
	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, additional_tools)
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
end

return M