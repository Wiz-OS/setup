;;; ============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; trouble.fnl --- Settings for trouble
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; ============================================================================

;;; ============================================================================
;;; Key bindings
;;; ============================================================================
(local {: register} (require :which-key))

(register {:<leader>t {:name :+Trouble}
           :<leader>tt [":TroubleToggle<cr>" "Toggle Trouble"]
           :<leader>tw [":Trouble workspace_diagnostics<cr>" "Trouble workspace diagnostics"]
           :<leader>td [":Trouble document_diagnostics<cr>" "Trouble document diagnostics"]
           :<leader>tl [":Trouble loclist<cr>" "Trouble loclist"]
           :<leader>tq [":Trouble quickfix<cr>" "Trouble quickfix"]
           :<leader>ts [":Trouble lsp_references<cr>" "Trouble LSP references"]})

;;; ============================================================================
