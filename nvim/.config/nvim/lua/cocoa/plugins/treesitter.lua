return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- Install parsers
			require("nvim-treesitter").install({
				"bash",
				"c",
				"cmake",
				"cpp",
				"css",
				"csv",
				"dockerfile",
				"gitignore",
				"go",
				"html",
				"java",
				"javascript",
				"json",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"proto",
				"python",
				"regex",
				"rust",
				"sql",
				"ssh_config",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			})

			-- Enable treesitter highlighting for all filetypes
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			-- Enable treesitter-based indentation
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			-- Enable treesitter-based folding
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },

		config = function()
			local ts_textobjects = require("nvim-treesitter-textobjects")
			local ts_select = require("nvim-treesitter-textobjects.select")
			local ts_swap = require("nvim-treesitter-textobjects.swap")

			ts_textobjects.setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
					include_surrounding_whitespace = true,
				},
			})

			local select_maps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ao"] = "@comment.outer",
				["ic"] = "@class.inner",
				["as"] = "@local.scope",
			}

			for key, query in pairs(select_maps) do
				vim.keymap.set({ "x", "o" }, key, function()
					ts_select.select_textobject(query)
				end)
			end

			vim.keymap.set("n", "<leader>a", function()
				ts_swap.swap_next("@parameter.inner")
			end, { desc = "Swap with next parameter" })

			vim.keymap.set("n", "<leader>A", function()
				ts_swap.swap_previous("@parameter.inner")
			end, { desc = "Swap with previous parameter" })
		end,
	},
}
