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

(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text {:severity {:min severity.INFO}}
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

(local lsp_installer (require :nvim-lsp-installer))
(lsp_installer.on_server_ready (fn [server]
                                 (let [opts {}]
                                   (when (. enhance-server-opts server.name)
                                     ((. enhance-server-opts server.name) opts))
                                   (set opts.capabilities
                                        ((. (require :cmp_nvim_lsp)
                                            :update_capabilities) (vim.lsp.protocol.make_client_capabilities)))
                                   (server:setup opts))))
