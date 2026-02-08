return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			java = { "palantir_java_format" },
		},
		formatters = {
			palantir_java_format = {
				command = vim.fn.expand("~/.local/share/formatters/palantir-java-format-native"),
				args = { "--palantir", "-" },
				stdin = true,
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
