wk.register({
	['<leader>f'] = { name = '+Fuzzy Find' },
	['<leader>ff'] = { '<cmd>Telescope find_files<cr>', 'Find file' },
	['<leader>fg'] = { '<cmd>Telescope git_files<cr>', 'Find git file' },
	['<leader>fr'] = { '<cmd>Telescope live_grep<cr>', 'Grep every line in current directory' },
	['<leader>fb'] = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Grep every line in current buffer' },
	['<leader>fh'] = { '<cmd>Telescope git_branches<cr>', 'Find git branches' },
	['<leader>fc'] = { '<cmd>Telescope colorscheme<cr>', 'Find color scheme' },
	['<leader>fm'] = { '<cmd>Telescope marks<cr>', 'Find marks' },
	['<leader>fl'] = { '<cmd>Telescope lsp_workspace_diagnostics<cr>', 'Find LSP diagnostics' },
	['<leader>fs'] = { '<cmd>Telescope spell_suggest<cr>', 'Find spell suggestions' },

	['<leader>fv'] = { '<cmd>lua require("plugin.telescope").search_dotfiles()<cr>', 'Browse vim configuration' },
	['<leader>fk'] = { '<cmd>lua require("telescope").extensions.file_browser.file_browser()<cr>', "File browser"},

	['<leader>fww'] = { '<cmd>lua require("telescope").extensions.git_worktree.git_worktrees()<cr>', 'Switch and edit worktrees'},
	['<leader>fwc'] = { '<cmd>lua require("telescope").extensions.git_worktree.create_git_worktree()<cr>', 'Create worktrees'},
})
