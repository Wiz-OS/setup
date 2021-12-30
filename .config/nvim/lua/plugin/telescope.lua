-- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- telescope.lua --- telescope.nvim customization file
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

-- =============================================================================
-- Key maps
-- =============================================================================
-- =============================================================================

-- =============================================================================
-- Settings
-- =============================================================================
local trouble = require("trouble.providers.telescope")
require('telescope').setup {
	defaults = {
		file_sorter = require('telescope.sorters').get_fzy_sorter,
		vimgrep_arguments = {
			'rg',
			'--hidden',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		file_ignore_patterns = {
			'$.git/*'
		},
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
	extentions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
		}
	}
}

require("telescope").load_extension "file_browser"

local M = {}
M.search_dotfiles = function()
	require('telescope.builtin').find_files({
	prompt_title = 'Vim Configuration',
	cwd = '~/dotfiles/.config/nvim/',
	hidden = true
})
end

return M
