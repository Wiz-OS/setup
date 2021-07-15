wk.register({
	['<leader>f'] = { name = '+Fuzzy Find' },
	['<leader>ff'] = { '<cmd>Telescope find_files<cr>', 'Find file' },
	['<leader>fg'] = { '<cmd>Telescope git_files<cr>', 'Find git file' },
	['<leader>fr'] = { '<cmd>Telescope live_grep<cr>', 'Grep every line in current directory' },
	['<leader>fb'] = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Grep every line in current buffer' },
	['<leader>fh'] = { '<cmd>Telescope help_tags<cr>', 'Help tags' },

	['<leader>fv'] = { '<cmd>lua require("plugin.telescope").search_dotfiles()<cr>', 'Browse vim configuration' }
})
