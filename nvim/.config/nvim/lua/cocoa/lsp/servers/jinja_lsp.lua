return {
	-- Jinja LSP for Jinja2 template files
	-- More info: https://github.com/uros-5/jinja-lsp
	settings = {
		jinja = {
			-- Use recursive search pattern to find templates anywhere in the project
			templates = "**/templates", -- Recursively search for any 'templates' directory
			backend = { "django", "jinja2" }, -- Supported template backends
			lang = "python", -- Backend language
			-- Custom template extensions
			templateExtensions = { ".jinja", ".jinja2", ".j2", ".html" },
			-- Additional file patterns to recognize as templates
			templateGlobs = {
				"*.jinja",
				"*.jinja2",
				"*.j2",
				"*.html.jinja",
				"templates/**/*.html",
				"templates/**/*.j2",
			},
		},
	},
	filetypes = { "jinja", "jinja2", "j2", "html.jinja", "htmljinja" },
}
