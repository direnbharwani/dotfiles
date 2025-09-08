return {
	-- Config options: https://github.com/DetachHead/basedpyright/blob/main/docs/settings.md
	settings = {
		basedpyright = {
			disableOrganizeImports = true, -- Using Ruff's import organizer
			disableLanguageServices = false,
			analysis = {
				ignore = { "*" }, -- Ignore all files for analysis to exclusively use Ruff for linting
				typeCheckingMode = "off",
				diagnosticMode = "openFilesOnly", -- Only analyze open files
				useLibraryCodeForTypes = true,
				autoImportCompletions = true, -- whether pyright offers auto-import completions
			},
		},
	},
}