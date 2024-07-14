return {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		lazy = true,
		dependencies = {
			{
				"SmiteshP/nvim-navbuddy",
			},
			{
				"Fildo7525/pretty_hover",
				event = "LspAttach",
				opts = {}
			}
		},
		config = function()
			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set loclist" })

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
					vim.keymap.set("n", "K", function()
						require("pretty_hover").hover()
					end, { buffer = ev.buf, desc = "Hover" })
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
						{ buffer = ev.buf, desc = "Go to implementation" })
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature help" })
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder,
						{ buffer = ev.buf, desc = "Add workspace folder" })
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder,
						{ buffer = ev.buf, desc = "Remove workspace folder" })
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, { buffer = ev.buf, desc = "List workspace folders" })
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition,
						{ buffer = ev.buf, desc = "Go to type definition" })
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action,
						{ buffer = ev.buf, desc = "Code action" })
					vim.keymap.set({ "n", "v" }, "fs", require("telescope.builtin").lsp_document_symbols,
						{ buffer = ev.buf, desc = "Document symbols" })
					vim.keymap.set(
						{ "n", "v" },
						"<leader>fs",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						{ buffer = ev.buf, desc = "Workspace symbols" }
					)
					vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references,
						{ buffer = ev.buf, desc = "References" })
					vim.keymap.set("n", "<space>f", function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = ev.buf, desc = "Format" })
				end,
			})

			local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				underline = {
					severity = vim.diagnostic.severity.ERROR,
				},
				signs = {
					severity = { max = vim.diagnostic.severity.HINT },
				},
				update_in_insert = true,
				severity_sort = false,
				virtual_text = {
					spacing = 4,
					prefix = "<",
					severity = vim.diagnostic.severity.ERROR,
				},
				float = {
					show_header = true,
					border = "single",
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
	},
	{
		"nvim-neotest/nvim-nio",
		ops = {}
	},
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()

			local dap, dapui = require("dap"), require("dapui")

			vim.keymap.set("n", "<F9>", function()
				require("nvim-dap-projects").search_project_config()
				require("dap").continue()
			end, { desc = "Continue" })
			vim.keymap.set("n", "<F5>", function()
				dapui.toggle()
			end, { desc = "Toggle DAP UI" })
			vim.keymap.set("n", "<F8>", function()
				require("dap").step_over()
			end, { desc = "Step over" })
			vim.keymap.set("n", "<F7>", function()
				require("dap").step_into()
			end, { desc = "Step into" })
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_out()
			end, { desc = "Step out" })
			vim.keymap.set("n", "<leader>b", function()
				require("dap").toggle_breakpoint()
			end, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<M-k>", function()
				require("dapui").eval()
			end, { silent = true, desc = "Evaluate expression under cursor" })

			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				desc = "prevent colorscheme clears self-defined DAP icon colors.",
				callback = function()
					vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939" })
					vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef" })
					vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379" })
				end,
			})

			vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DapBreakpoint" })
			vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint" })
			vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped" })
		end,
	},
	{
		"ldelossa/nvim-dap-projects",
		event = "BufEnter",
	},
}
