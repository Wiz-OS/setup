;;; ============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; null-ls.fnl --- Settings for Null-LS
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; ============================================================================

(import-macros {: cmd} :conf.macros)
(local {: setup : builtins} (require :null-ls))

(local shell_sources [builtins.diagnostics.shellcheck
                      builtins.code_actions.shellcheck
                      builtins.formatting.shellharden
                      (builtins.formatting.shfmt.with {:extra_args [:-i
                                                                    :2
                                                                    :-bn
                                                                    :-ci
                                                                    :-sr
                                                                    :-s]})
                      builtins.formatting.fish_indent])

(local python_sources
       [builtins.formatting.black
        builtins.formatting.isort
        (builtins.diagnostics.mypy.with {:extra_args [:--strict]})])

(local fennel_sources [builtins.formatting.fnlfmt])

(local sources {})
(each [_ v (ipairs shell_sources)]
  (table.insert sources v))

(each [_ v (ipairs python_sources)]
  (table.insert sources v))

(each [_ v (ipairs fennel_sources)]
  (table.insert sources v))

(setup {: sources
        :on_attach (fn [client]
                     (cmd "augroup LspFormatting
                                autocmd! * <buffer>
                                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                            augroup END"))})
