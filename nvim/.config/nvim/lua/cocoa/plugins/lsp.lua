return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				automatic_enable = {
					exclude = {
						-- needs external plugin (install manually through Mason)
						"jdtls",
					},
				},
			},
		},
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		{ "mfussenegger/nvim-jdtls" }, -- Java LSP support

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		require("cocoa.lsp.config.autocommands").setup()
		require("cocoa.lsp.config.diagnostics").setup()

		local original_capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

		local servers = require("cocoa.lsp.servers").servers
		local additional_tools = require("cocoa.lsp.tools").tools

		require("cocoa.lsp.config.mason").setup(servers, additional_tools)
		require("cocoa.lsp.config.lspconfig").setup(servers, capabilities)
	end,
}
