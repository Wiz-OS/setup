-- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- feline.lua --- configuration for feline.nvim
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

local vi_mode_utils = require('feline.providers.vi_mode')
local components = require('feline.presets')['default']

-- Gruvbox
local colors = {
	white = '#ebdbb2',
	red = '#cc241d',
	green = '#98971a',
	yellow = '#d79921',
	orange = '#d65d0e',
	cyan = '#458588',
	blue = '#458588',
	skyblue = '#458588',
	purple = '#b16286',
	violet ='#b16286',
	aqua = '#689d6a',
	gray = '#928374',
	lightgray = '#3c3836'
}


local vi_mode_provider = function()
    local mode_alias = {
      n = 'NORMAL',
      no = 'NORMAL',
      i = 'INSERT',
      v = 'VISUAL',
      V = 'V-LINE',
      [''] = 'V-BLOCK',
      c = 'COMMAND',
      cv = 'COMMAND',
      ce = 'COMMAND',
      R = 'REPLACE',
      Rv = 'REPLACE',
      s = 'SELECT',
      S = 'SELECT',
      [''] = 'SELECT',
      t = 'TERMINAL',
    }
    return ' ' .. mode_alias[vim.fn.mode()]
end

components.active[1][1] = {}
components.active[1][2] = {
	provider = vi_mode_provider,
	hl = function()
		return {
			name = vi_mode_utils.get_mode_highlight_name(),
			fg = 'bg',
			bg = colors[vi_mode_utils.get_mode_color()],
			style = 'bold'
		}
	end,
	right_sep = {
		{
			str = ' ',
			hl = function()
				return {
					bg = colors[vi_mode_utils.get_mode_color()],
					fg = colors['lightgray']
				}
			end
		}
	}
}
components.active[1][3] = {
	provider = 'file_info',
	hl = {
		fg = 'white',
		bg = colors['lightgray'],
		style = 'bold'
	},
	left_sep = {
		{
			str = ' ',
			hl = {
				bg = colors['lightgray']
			}
		}
	},
	right_sep = {'slant_right_2', ' '}
	}

require('feline').setup()
