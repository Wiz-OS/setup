-- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- trouble.lua --- keybindings for touble
-- Copyright (c) 2021 Sourajyoti Basak
-- Author: Sourajyoti Basak < wiz28@protonmail.com >
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

wk.register({
	['<leader>t'] = { name = "Trouble" },
	['<leader>tt'] = { '<cmd>TroubleToggle<cr>', 'Toggle trouble' },
	['<leader>tw'] = { '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>', 'Toggle trouble LSP workspace diagnostics' },
	['<leader>td'] = { '<cmd>TroubleToggle lsp_document_diagnostics<cr>', 'Toggle trouble LSP diagnostics diagnostics' },
	['<leader>tq'] = { '<cmd>TroubleToggle quickfix<cr>', 'Toggle trouble quickfix list' },
	['<leader>tl'] = { '<cmd>TroubleToggle loclist<cr>', 'Toggle trouble loclist list' },
	['<leader>tr'] = { '<cmd>TroubleToggle lsp_references<cr>', 'Toggle trouble LSP references' },
})
