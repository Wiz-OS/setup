-- =============================================================================
--  __      __________   ______
-- /  \    /  \_____  \ /  __  \
-- \   \/\/   //  ____/ >      <
--  \        //       \/   --   \
--   \__/\  / \_______ \______  /
--        \/          \/      \/
-- init.lua --- Bootstrap essential stuff
-- Copyright (c) 2021-present Sourajyoti Basak
-- Author: Sourajyoti Basak <wiz28@protonmail.com>
-- URL: https://github.com/wizard-28/dotfiles/
-- License: MIT
-- =============================================================================

function ensure(user, repo)
    local install_path = string.format("%s/packer/start/%s", vim.fn.stdpath("data") .. "/site/pack", repo, repo)
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.api.nvim_command(string.format("!git clone https://github.com/%s/%s %s", user, repo, install_path))
        vim.api.nvim_command(string.format("packadd %s", repo))
    end
end

-- Bootstrap essential plugins
ensure("wbthomason", "packer.nvim")
ensure("rktjmp", "hotpot.nvim")
ensure("lewis6991", "impatient.nvim")

-- impatient optimization
require("impatient")

require("hotpot").setup({
	provide_require_fennel = true,
})
require("conf")
