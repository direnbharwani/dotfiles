local M = {}

function M.setup()
	-- Project-specific workspace directory
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

	-- Mason jdtls installation paths
	local mason_jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
	local launcher_jar = vim.fn.glob(mason_jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
	local config_dir = mason_jdtls_path .. "/config_mac_arm" -- Apple Silicon config
	local lombok_jar = mason_jdtls_path .. "/lombok.jar"

	local config = {
		-- Command to start jdtls with Lombok support
		cmd = {
			"java", -- Apple JDK 21 from PATH

			-- Lombok support for Spring Boot projects
			"-javaagent:" .. lombok_jar,

			-- Standard jdtls JVM arguments
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens", "java.base/java.util=ALL-UNNAMED",
			"--add-opens", "java.base/java.lang=ALL-UNNAMED",

			-- jdtls launcher and configuration
			"-jar", launcher_jar,
			"-configuration", config_dir,
			"-data", workspace_dir,
		},

		-- Project root detection (Maven, Gradle, Git)
		root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "build.gradle", "pom.xml" }),

		-- Enhanced Java settings
		settings = {
			java = {
				eclipse = {
					downloadSources = true,
				},
				configuration = {
					updateBuildConfiguration = "interactive",
				},
				maven = {
					downloadSources = true,
				},
				implementationsCodeLens = {
					enabled = true,
				},
				referencesCodeLens = {
					enabled = true,
				},
				references = {
					includeDecompiledSources = true,
				},
				format = {
					enabled = true,
				},
			},
		},

		-- Language server initialization options
		init_options = {
			bundles = {},
		},

		-- Integration with blink.cmp for completions
		capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}

	-- Start or attach to jdtls
	require("jdtls").start_or_attach(config)
end

return M
