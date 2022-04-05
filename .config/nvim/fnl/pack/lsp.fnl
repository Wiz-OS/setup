;;; ============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; lsp.fnl --- Settings for nvim native LSP
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; ============================================================================

(local config (require :lspconfig))

(local {: register} (require :which-key))

;;; ============================================================================
;;; LSP independent bindings
;;; ============================================================================
(register {:<A-d> [":Lspsaga toggle_floaterm<cr>" "Toggle floating terminal"]})
(register {:<A-d> ["<C-\\><C-n><cmd>Lspsaga toggle_floaterm<cr>"
                   "Toggle floating terminal"]} {:mode :t})

;;; ============================================================================

(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :update_in_insert false
           :severity_sort true
           :float {:show_header false :border :single}})
  (sign_define :DiagnosticSignError {:text "" :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn {:text "" :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo {:text "" :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint {:text "" :texthl :DiagnosticSignHint}))

(let [{: with : handlers} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp
       (with handlers.signature_help {:border :single}))
  (set vim.lsp.handlers.textDocument/hover
       (with handlers.hover {:border :single})))

(local enhance-server-opts
       {:pyright (fn [opts]
                   (set opts.settings
                        {:python {:analysis {:typeCheckingMode :strict}}}))})

(fn on-attach [client buffer]
  (register {:<leader>g {:name :LSP}
             :<leader>gr [":Lspsaga rename<cr>" :Rename]
             :<leader>gx [":Lspsaga code_action<cr>" "Code action"]
             ;; BUG: https://github.com/tami5/lspsaga.nvim/issues/90
             :K [":Lspsaga hover_doc<cr>" "Hover doc"]
             :<leader>go [":Lspsaga show_line_diagnostics<cr>"
                          "Show line diagnostics"]
             :<leader>gd [":lua vim.lsp.buf.declaration()<cr>"
                          "Jump to declaration"]
             :<leader>gD [":lua vim.lsp.buf.definition()<cr>"
                          "Jump to definition"]
             :<leader>gi [":lua vim.lsp.buf.implementation()<cr>"
                          "Jump to implementation"]
             :<leader>gf [":lua vim.lsp.buf.formatting()<cr>" "Format buffer"]}))

(register {:<leader>g {:name :LSP}
           :<leader>gx [":Lspsaga range_code_action<cr>" "Code action"]}
          {:mode :x})

;; FIXME: These bindings don't work properly
(register {:<C-u> [":lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>"
                   "Smart scroll up"]
           :<C-d> [":lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>"
                   "Smart scroll down"]} {:noremap false})

(local lsp_installer (require :nvim-lsp-installer))
(lsp_installer.on_server_ready (fn [server]
                                 (let [opts {}]
                                   (set opts.on-attach (on-attach))
                                   (when (. enhance-server-opts server.name)
                                     ((. enhance-server-opts server.name) opts))
                                   (set opts.capabilities
                                        ((. (require :cmp_nvim_lsp)
                                            :update_capabilities) (vim.lsp.protocol.make_client_capabilities (server:setup opts)))))))
