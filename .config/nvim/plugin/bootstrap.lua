local function ensure(user, repo)
    local install_path = string.format("%s/packer/start/%s", vim.fn.stdpath("data") .. "/site/pack", repo, repo)
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.api.nvim_command(string.format("!git clone https://github.com/%s/%s %s", user, repo, install_path))
        vim.api.nvim_command(string.format("packadd %s", repo))
    end
end

-- Bootstrap essential plugins
ensure("wbthomason", "packer.nvim")
ensure("udayvir-singh", "tangerine.nvim")
ensure("lewis6991", "impatient.nvim")

-- impatient optimization
require("impatient")

require("tangerine").setup({
    compiler = {
        verbose = false,
        hooks = {
            "oninit",
            "onsave"
        }
    }
})

