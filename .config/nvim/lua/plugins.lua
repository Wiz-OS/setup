-- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- plugins.lua --- List of plugins
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

cmd 'packadd packer.nvim'

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'		-- Packer itself
	-- =============================================================================
	-- General
	-- =============================================================================
	use { "npxbr/gruvbox.nvim", requires = { "rktjmp/lush.nvim" }}

	use {
		'nvim-telescope/telescope.nvim',
		config = [[require('plugin.telescope')]],
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'},
			{'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }}
	}

	use {
		'lewis6991/gitsigns.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('gitsigns').setup()
		end
	}

	use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

	use { "folke/which-key.nvim", config = function() require("which-key").setup {} end }
	-- =============================================================================
	-- =============================================================================
	-- LSP
	-- =============================================================================
	use { 'neovim/nvim-lspconfig', config = [[require('plugin.lsp')]] }
	use 'kabouzeid/nvim-lspinstall'
	use { 'glepnir/lspsaga.nvim', config = [[require('plugin.lspsaga')]] }
	use { 'hrsh7th/nvim-compe', config = [[require('plugin.compe')]], event = 'InsertEnter *' }
	use 'L3MON4D3/LuaSnip'
	use { 'mfussenegger/nvim-lint', ft = { 'sh' }, config = [[require('plugin.lint')]] }
	-- =============================================================================

	-- =============================================================================
	-- Style
	-- =============================================================================
	use { 'nvim-treesitter/nvim-treesitter', ft = { 'sh', 'lua' }, config = [[require('plugin.treesitter')]], run = ':TSUpdate' }
	use { 'beauwilliams/statusline.lua', requires = { 'kosayoda/nvim-lightbulb' }}
	use 'kyazdani42/nvim-web-devicons'	-- Icons
	-- =============================================================================
end)
