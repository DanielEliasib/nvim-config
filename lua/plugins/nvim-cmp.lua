local generate_comparators = function(cmp)

local default_comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.kind,
					cmp.config.compare.recently_used,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				}

local clangd_extensions_scores= require("clangd_extensions.cmp_scores")
table.insert(default_comparators, 3, clangd_extensions_scores)

return default_comparators
end
	
return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-vsnip',
		'onsails/lspkind-nvim',
		'hrsh7th/vim-vsnip',
		'p00f/clangd_extensions.nvim'
	},
	event = 'VeryLazy',
	lazy = true,
	config = function()
		-- Set up nvim-cmp.
		local cmp = require ('cmp')
		local lspkind = require('lspkind')
		cmp.setup({
			sorting = {
				comparators = generate_comparators(cmp),
			},
			formatting = {
				fields = { 'kind', 'abbr', 'menu' },
				format = function(entry, vim_item)
					local kind = require("lspkind").cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						menu = ({
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							latex_symbols = "[Latex]",
						})
					})(entry, vim_item)
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					local type_padded = string.format("%-8s", strings[2]) or "        "
					kind.kind = " " .. (strings[1] or "") .. " "
					kind.menu = "    (" .. (type_padded or "") .. ") " .. (kind.menu or "")

					return kind
				end,
			},
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' }
				}),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = 'vsnip' }, -- For vsnip users.
				{ name = 'nvim_lsp' },
				{ name = 'path' }
				-- { name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
			}, {
				{ name = 'buffer' },
			})
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources({
				{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = 'buffer' },
			})
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			formatting = {
				fields = { 'abbr' },
				format = lspkind.cmp_format({
					mode = "symbol_text",
				}),
			},
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
					{ name = 'path' }
				},
				{
					{ name = 'cmdline' }
				}),
			window = {
				completion = cmp.config.window.bordered({
					border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' }
				}),
			}
		})
	end,
}
