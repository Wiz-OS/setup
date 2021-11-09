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

-- =============================================================================
-- Bootstrap packer
-- =============================================================================
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  cmd 'packadd packer.nvim'
end
-- =============================================================================

return require('packer').startup(function(use)
	use { 'wbthomason/packer.nvim' }

-- =============================================================================
-- General
-- =============================================================================
	use {
		'sainnhe/gruvbox-material',
		setup = function()
			g.gruvbox_material_enable_italic = true
			g.gruvbox_material_enable_bold = true
			g.gruvbox_material_better_performance = true
			g.gruvbox_material_palette = 'original'
			g.gruvbox_material_background = 'hard'
		end,
		config = function()
			cmd 'colorscheme gruvbox-material'
		end
	}
	use {
		'norcalli/nvim-colorizer.lua',
		config = function()
			require'colorizer'.setup()
		end
	}
	use {
		'nvim-telescope/telescope.nvim',
		config = function()
			require('plugin.telescope')
		end,
		cmd = 'Telescope',
		module = { 'telescope', 'plugin.telescope' },
		keys = '<leader>f',
		requires = {
			{
				'nvim-lua/popup.nvim',
				module = 'popup',
			},
			{
				'nvim-lua/plenary.nvim',
				module = 'plenary',
			},
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				opt = true,
				run = 'make'
			}
		}
	}
	use {
		"folke/which-key.nvim",
		event = 'VimEnter',
		config = function()
			require('bindings.init')
		end
	}
	use {
		'ggandor/lightspeed.nvim',
		keys = { 's', 'S' }
	}
	use {
		'jghauser/mkdir.nvim',
		config = function()
			require('mkdir')
		end
	}
	use {
		"Pocco81/AutoSave.nvim",
		config = function ()
			require('autosave').setup(
				{
					enabled = false,
					execution_message = "AutoSave: saved at " .. fn.strftime("%H:%M:%S"),
					events = {"InsertLeave", "TextChanged"},
					conditions = {
						exists = true,
						filetype_is_not = {},
						modifiable = true
					},
					write_all_buffers = false,
					on_off_commands = true,
					clean_command_line_interval = 0,
					debounce_delay = 135
				}
			)
		end
	}
	use {
		'lukas-reineke/indent-blankline.nvim',
		event = 'BufWinEnter',
		setup = function()
			require('plugin.blankline')
		end
	}
	use {
		'rmagatti/auto-session',
		config = function()
			opt.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
		end
	}
	use {
		'andymass/vim-matchup',
		event = 'CursorMoved',
		setup = function()
			g.loaded_matchit = 1
		end
	}
	use {
		'famiu/feline.nvim',
		config = function()
			require('plugin.feline')
		end
	}
	use 'kshenoy/vim-signature'
	use {
		"nvim-neorg/neorg",
		config = function()
			require('plugin.neorg')
		end,
		requires = "nvim-lua/plenary.nvim",
		 after = "nvim-treesitter"
	}
-- =============================================================================

-- =============================================================================
-- Git
-- =============================================================================
	use {
		'lewis6991/gitsigns.nvim',
		event = 'BufReadPost',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}
	use {
		'TimUntersberger/neogit',
		cmd = 'Neogit',
		requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
		config = function()
			require('neogit').setup {
				integrations = {
					diffview = true
				}
			}
		end
	}
	use 'samoshkin/vim-mergetool'
-- =============================================================================

-- =============================================================================
-- LSP
-- =============================================================================
	use {
		'neovim/nvim-lspconfig',
		event = 'BufReadPre',
		requires = {
			'kabouzeid/nvim-lspinstall',
			{
				'tami5/lspsaga.nvim',
				event = 'BufReadPost',
				config = function()
					require('lspsaga').init_lsp_saga()
				end
			},
			{
				'folke/lua-dev.nvim',
				module = 'lua-dev',
				ft = 'lua'
			}
		},
		config = function()
			require('plugin.lsp')
		end
	}
	use {
		'ms-jpq/coq_nvim',
		branch = 'coq',
		run= ':COQdeps',
		setup = function()
			g.coq_settings = {
				auto_start = 'shut-up'
			}
		end,
		requires = {
			{
				'ms-jpq/coq.artifacts',
				branch= 'artifacts'
			},
			{
				'windwp/nvim-autopairs',
				config = function()
					require('nvim-autopairs').setup {}
				end
			}
		}
	}
	use {
		'mfussenegger/nvim-lint',
		ft = 'sh',
		config = function()
			require('plugin.lint')
		end
	}
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		cmd = 'TroubleToggle',
		module = 'trouble',
		config = function()
			require("trouble").setup()
		end
	}
	use {
		'averms/black-nvim',
		ft = 'python',
		config = function()
			cmd("au FileType python au BufWritePre <buffer> call Black()")
		end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('plugin.treesitter')
		end,
		requires = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		}
	}
-- =============================================================================
end)
