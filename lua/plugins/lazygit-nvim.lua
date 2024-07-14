-- nvim v0.8.0
return {
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		lazy = true,
		cmd = { "LazyGit", "LazyGitCurrentFile"},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
