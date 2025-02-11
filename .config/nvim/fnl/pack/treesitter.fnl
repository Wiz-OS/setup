;;; ============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; treesitter.fnl --- Treesitter settings
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; ============================================================================

(import-macros {: set!} :macros)
(local {: setup} (require :nvim-treesitter.configs))

;;; ===========================================================================
;;; Setup
;;; ===========================================================================
(setup {:ensure_installed [:lua :fennel :python :bash :norg]
        :highlight {:enable true :use_languagetree true}
        :indent {:enable true}
        :incremental_selection {:enable true
                                :keymaps {:init_selection :<C-n>
                                          :node_incremental :<C-n>
                                          :scope_incremental :<C-s>
                                          :node_decremental :<C-m>}}
        :textobjects {:select {:enable true
                               :lookahead true
                               :keymaps {:af "@function.outer"
                                         :if "@function.inner"
                                         :ac "@class.outer"
                                         :ic "@class.inner"}}
                      :swap {:enable true
                             :swap_next {:<leader>a "@parameter.inner"}
                             :swap_previous {:<leader>A "@parameter.inner"}}
                      :move {:enable true
                             :set_jumps true
                             :goto_next_start {"]m" "@function.outer"
                                               "]]" "@class.outer"}
                             :goto_next_end {"]M" "@function.outer"
                                             "][" "@class.outer"}
                             :goto_previous_start {"[m" "@function.outer"
                                                   "[[" "@class.outer"}
                             :goto_previous_end {"[M" "@function.outer"
                                                 "[]" "@class.outer"}}
                      :lsp-interop {:enable true
                                    :border :none
                                    :peek_definition_code {:<leader>df "@function.outer"
                                                           :<leader>dF "@class.outer"}}}
        :rainbow {:enable true
                  :extended_mode true
                  :max_file_lines 1000
                  :colors ["#878d96"
                           "#a8a8a8"
                           "#8d8d8d"
                           "#a2a9b0"
                           "#8f8b8b"
                           "#ada8a8"]}})

;;; ===========================================================================
