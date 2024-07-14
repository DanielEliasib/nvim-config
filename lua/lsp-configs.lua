-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local clangd_capabilities = require('cmp_nvim_lsp').default_capabilities()
clangd_capabilities.offsetEncoding = { "utf-16" }
local navic = require("nvim-navic")

local local_user = require('local_configs/local_user')

local on_attach = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd [[
	 				  hi! LspReferenceRead guibg=#363646
	 				  hi! LspReferenceText gui=underline
	 				  hi! LspReferenceWrite guibg=#363646
	 				]]


		vim.keymap.set("n", "<space>hr", function()
			vim.lsp.buf.document_highlight()
		end, { buffer = bufnr, desc = "Highlight references" })
		vim.keymap.set("n", "<space>hc", function()
			vim.lsp.buf.clear_references()
		end, { buffer = bufnr, desc = "Clear highlighted references" })
	end
end

local on_attach_with_inlay = function(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.g.inlay_hints_visible = true
		vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
	end

	on_attach(client, bufnr)
end

lsps = local_user.get_lsps()

for _, lsp in ipairs(lsps) do
	cap = capabilities
	attach_func = on_attach_with_inlay
	-- attach_func = on_attach
	if lsp == 'clangd' then
		cap = clangd_capabilities
	end

	if lsp == 'omnisharp' then
		require('lspconfig')[lsp].setup {
			cmd = { "omnisharp.cmd", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
			capabilities = cap,
			on_attach = attach_func,
			enable_editorconfig_support = true,
			enable_ms_build_load_projects_on_demand = false,
			enable_roslyn_analyzers = true,
			organize_imports_on_format = true,
			enable_import_completion = true,
			sdk_include_prereleases = true,
			analyze_open_documents_only = true,
		}
	else
		require('lspconfig')[lsp].setup {
			capabilities = cap,
			on_attach = attach_func,
		}
	end
end
