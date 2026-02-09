return {
	-- mini.icons
	{
		"echasnovski/mini.icons",
		version = "*",
		opts = {},
	},
	-- mini.comments
	{
		"echasnovski/mini.comment",
		version = "*",
		opts = {},
	},
	-- mini.tabline
	{
		"echasnovski/mini.tabline",
		version = "*",
		opts = {
			show_icons = true,
			format = function(buf_id, label)
				local suffix = vim.bo[buf_id].modified and " [+]" or ""
				return MiniTabline.default_format(buf_id, label) .. suffix
			end,
		},
	},
	-- mini.ai
	{
		"echasnovski/mini.ai",
		version = "*",
		opts = {},
	},
	-- mini.surround
	{
		"echasnovski/mini.surround",
		version = "*",
		opts = {},
	},
	-- mini.pairs
	{
		"echasnovski/mini.pairs",
		version = "*",
		opts = {},
	},
}
