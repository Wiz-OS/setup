(local {: setup} (require :indent_blankline))

(vim.opt.listchars:append "space:⋅")

(setup {:space_char_blankline " "
        :use_treesitter true
        :show_current_context true})
