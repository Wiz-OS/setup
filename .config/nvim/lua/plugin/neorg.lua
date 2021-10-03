--- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- neorg.lua --- Neorg configuration
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

require('neorg').setup {
	-- Tell Neorg what modules to load
	load = {
		["core.defaults"] = {}, -- Load all the default modules
		["core.norg.concealer"] = {}, -- Allows for use of icons
		["core.norg.dirman"] = { -- Manage your directories with Neorg
			config = {
				workspaces = {
					studies = "/media/pop-os/S BASAK/studies"
				}
			}
		}
	},
}

-- =============================================================================
-- Treesitter
-- =============================================================================
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}
-- =============================================================================
