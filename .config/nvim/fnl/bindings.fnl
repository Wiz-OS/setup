;;; ============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; bindings.fnl --- Key bindings
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; ============================================================================

(import-macros {: map!} :macros)
(local {: register} (require :which-key))

;;; ============================================================================
;;; Neovim overrides
;;; ============================================================================
(map! [i] :jj :<esc>)
(map! [n] :<esc> :<esc><cmd>noh<cr>)
;;; ============================================================================

;;; ============================================================================
;;; Hotpot bindings
;;; ============================================================================
(register {:<localleader>h {:name :+hotpot}
           :<localleader>he [(fn []
                               (print ((. (require :hotpot.api.eval)
                                          :eval-selection))))
                             "Evaluate selection"]
           :<localleader>hc [(fn []
                               (print ((. (require :hotpot.api.compile)
                                          :compile-selection))))
                             "Compile selection"]} {:mode :v})

(register {:<localleader>h {:name :+hotpot}
           :<localleader>hc [(fn []
                               (print ((. (require :hotpot.api.compile)
                                          :compile-buffer) 0)))
                             "Compile buffer"]})

;;; ============================================================================

;;; ============================================================================
;;; LSP bindings
;;; ============================================================================
;; Formatting
(register {:<localleader>f [(fn []
                              (vim.lsp.buf.formatting))
                            "Format buffer"]})

(register {:<localleader>f [(fn []
                              (vim.lsp.buf.range_formatting))
                            "Format buffer"]} {:mode :v})

;; Code actions

;;; ============================================================================
;;; Telescope bindings
;;; ============================================================================
(register {:<leader>f {:name "+Fuzzy Find"}
           :<leader>ff [":Telescope find_files<cr>" "Find file"]
           :<leader>fg [":Telescope git_files<cr>" "Find git file"]
           :<leader>fr [":Telescope live_grep<cr>"
                        "Grep every line in current directory"]
           :<leader>fb [":Telescope current_buffer_fuzzy_find<cr>"
                        "Grep every line in current buffer"]
           :<leader>fh [":Telescope git_branches<cr>" "Find git branches"]
           :<leader>fc [":Telescope colorscheme<cr>" "Find color scheme"]
           :<leader>fm [":Telescope marks<cr>" "Find marks"]
           :<leader>fl [":Telescope lsp_workspace_diagnostics<cr>"
                        "Find LSP diagnostics"]
           :<leader>fs [":Telescope spell_suggest<cr>"
                        "Find spell suggestions"]
;           :<leader>fv [(fn []
;                          ((. (require :plugin.telescope) search_dotfiles)))
;                        "Browse vim configuration"]})
})

;;; ============================================================================

;;; ============================================================================
;;; Neogit bindings
;;; ============================================================================
(register {:<leader>m {:name :+Neogit}
           :<leader>mm [":Neogit<cr>" "Open Neogit mode"]
           :<leader>mc [":Neogit commit<cr>" "Open commit popup"]})

;;; ============================================================================

;;; ============================================================================
;;; Gitsigns bindings
;;; ============================================================================
(register {:<leader>h {:name "+Git Signs"}
           :<leader>hs [":Gitsigns stage_hunk<cr>" "Stage hunk"]
           :<leader>hS [":Gitsigns stage_buffer<cr>" "Stage buffer"]
           :<leader>hu [":Gitsigns undo_stage_hunk<cr>" "Undo stage hunk"]
           :<leader>hr [":Gitsigns reset_hunk<cr>" "Reset hunk"]
           :<leader>hR [":Gitsigns reset_buffer<cr>" "Reset buffer"]
           :<leader>hp [":Gitsigns preview_hunk<cr>" "Preview hunk"]
           :<leader>hb [(fn []
                          ((. (require :gitsigns) :blame_line) {:full true}))
                        "Blame line"]})

(register {:<leader>h {:name "+Git Signs"}
           :<leader>hs [":Gitsigns stage_hunk<cr>" "Stage hunk"]
           :<leader>hr [":Gitsigns reset_hunk<cr>" "Reset hunk"]}
          {:mode :v})

;;; ============================================================================
