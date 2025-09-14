return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- Spell checking
			markdown = { "codespell" },
			text = { "codespell" },
			gitcommit = { "codespell" },
			python = { "codespell" },
			lua = { "codespell" },
			sh = { "codespell" },
			bash = { "codespell" },
			zsh = { "codespell" },
			javascript = { "codespell" },
			typescript = { "codespell" },
			rust = { "codespell" },
			go = { "codespell" },
			c = { "codespell" },
			cpp = { "codespell" },
			java = { "codespell" },
			vim = { "codespell" },
			dockerfile = { "codespell" },
			json = { "codespell" },
			jsonc = { "codespell" },
			toml = { "codespell" },
			ini = { "codespell" },
			conf = { "codespell" },
			config = { "codespell" },
			yaml = { "codespell" },
			yml = { "codespell" },

			-- Makefiles
			make = { "checkmake" },
		}

		-- Custom ansible-lint for Ansible files only
		local function is_ansible_file()
			local filename = vim.fn.expand("%:t")
			local filepath = vim.fn.expand("%:p")

			-- Check for common Ansible file patterns
			return filename:match("%.ya?ml$")
				and (
					filepath:match("/playbooks/")
					or filepath:match("/roles/")
					or filepath:match("/inventory/")
					or filename:match("^playbook")
					or filename:match("%-playbook%.")
					or filename == "site.yml"
					or filename == "site.yaml"
					or filename == "main.yml"
					or filename == "main.yaml"
				)
		end

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				-- Run ansible-lint on Ansible files
				if is_ansible_file() then
					require("lint").try_lint("ansible-lint")
				end
				-- Run regular linters
				lint.try_lint()
			end,
		})
	end,
}

