-- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- nvim.lua --- remaps for neovim
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

-- =============================================================================
-- Keeping it centered
-- =============================================================================
wk.register({
	["n"] = { "nzzzv", "Goto next, center screen, unfold" },
	["N"] = { "Nzzzv", "Goto previous, center screen, unfold" },
	["J"] = { "mzJ`z", "Join lines while keeping the cursor in the same position" },
})
-- =============================================================================

-- =============================================================================
-- Undo break points
-- =============================================================================
wk.register({
	["."] = { ".<c-g>u", "Insert . and set undo breakpoint" },
	[","] = { ",<c-g>u", "Insert , and set undo breakpoint" },
	["!"] = { "!<c-g>u", "Insert ! and set undo breakpoint" },
	["?"] = { "?<c-g>u", "Insert ? and set undo breakpoint" },
}, { mode = "i" })
-- =============================================================================

-- =============================================================================
-- Moving text
-- =============================================================================
wk.register({
	["K"] = { "<cmd>m '<-2<cr>gv=gv", "Move line up" },
	["J"] = { "<cmd>m '>+1<cr>gv=gv", "Move line down" },
}, { mode = "v" })

wk.register({
	["<c-k>"] = { "<esc><cmd>m .-2<cr>==i", "Move line up" },
	["<c-j>"] = { "<esc><cmd>m .+1<cr>==i", "Move line down" },
}, { mode = "i" })

wk.register({
	["<leader>k"] = { "<cmd>m .-2<cr>==", "Move line up" },
	["<leader>j"] = { "<cmd>m .+1<cr>==", "Move line down" },
})
-- =============================================================================
