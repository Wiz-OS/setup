;;; =============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; pack.fnl --- specify plugins
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; ============================================================================
(import-macros {: pack : let! : cmd : use-package! : unpack!} :conf.macros)

;;; ============================================================================
;;; Bootstraped plugins
;;; ============================================================================
(use-package! :wbthomason/packer.nvim)
(use-package! :lewis6991/impatient.nvim)
(use-package! :rktjmp/hotpot.nvim)
;;; ============================================================================

;;; ============================================================================
;;; General plugins
;;; ============================================================================
;; Colorscheme
(use-package! :marko-cerovac/material.nvim
              {:setup (fn []
                        (let! material_style "deep ocean"))
               :config (fn []
                         (cmd "colorscheme material"))})

;; Status line
(use-package! :nvim-lualine/lualine.nvim
              {:config (fn []
                         ((. (require :lualine) :setup) {:options {:theme :material}}))})

;; Key bindings guide
(use-package! :folke/which-key.nvim {:init :which-key})

;; Cool motion
(use-package! :ggandor/lightspeed.nvim {:keys [:s :S]})

;; Create new directories automatically when writing to a new buffer
(use-package! :jghauser/mkdir.nvim
              {:config (fn []
                         (require :mkdir))})

;; Auto saving plugin
(use-package! :Pocco81/AutoSave.nvim {:init :autosave})

;; Fuzzy finder on steroids
(use-package! :nvim-telescope/telescope.nvim
              {:after :telescope-fzf-native.nvim
               :config! :telescope
               :requires [(pack :nvim-lua/popup.nvim {:cmd :Telescope})
                          (pack :nvim-lua/plenary.nvim
                                {:module :plenary :after :popup.nvim})
                          (pack :nvim-telescope/telescope-fzf-native.nvim
                                {:run :make :after :plenary.nvim})]})

;; Pretty trouble management
(use-package! :folke/trouble.nvim {:module :trouble :config! :trouble})

;; Pretty notifications
(use-package! :rcarriga/nvim-notify
              {:config (fn []
                         (set vim.notify (require :notify)))})

(use-package! :lukas-reineke/indent-blankline.nvim {:config! :indent-blankline})

;;; ============================================================================
;;; File type plugins
;;; ============================================================================
;; EditorConfig support
(use-package! :gpanders/editorconfig.nvim)

;; Neovim's answer to Org-mode
(use-package! :nvim-neorg/neorg
              {:config! :neorg
               :ft :norg
               :requires :hrsh7th/nvim-cmp
               :after [:nvim-treesitter :nvim-cmp]})

;;; ============================================================================

;;; ============================================================================
;;; Comments
;;; ============================================================================
;; Comment highlighter
(use-package! :folke/todo-comments.nvim
              {:requires :nvim-lua/plenary.nvim :init :todo-comments})

;; Comment key bindings
(use-package! :numToStr/Comment.nvim {:init :Comment})
;;; ============================================================================

;;; ============================================================================
;;; Git
;;; ============================================================================
;; Git integration for buffers
(use-package! :lewis6991/gitsigns.nvim
              {:init :gitsigns :requires :nvim-lua/plenary.nvim})

(use-package! :TimUntersberger/neogit {:init :neogit})
;;; ============================================================================

;;; ============================================================================
;;; Language Server Protocol
;;; ============================================================================
;; Lispy stuff
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])
(use-package! :Olical/conjure
              {:branch :develop
               :module :conjure.eval
               :ft lisp-ft
               :requires [(pack :gpanders/nvim-parinfer {:ft lisp-ft})]})

;; Completion engine
(use-package! :hrsh7th/nvim-cmp
              {:after :cmp-under-comparator
               :module :cmp
               :config! :cmp
               :requires [(pack :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-nvim-lsp-signature-help
                                {:after :nvim-cmp})
                          (pack :PaterJason/cmp-conjure {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-path {:after :nvim-cmp})
                          (pack :zbirenbaum/copilot-cmp
                                {:after [:nvim-cmp :copilot.lua]
                                 :config (fn []
                                           (vim.schedule (fn []
                                                           (require :copilot))))})
                          (pack :ray-x/cmp-treesitter {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})
                          (pack :zbirenbaum/copilot.lua {:event :InsertCharPre})
                          (pack :rafamadriz/friendly-snippets)
                          (pack :L3MON4D3/LuaSnip
                                {:config (fn []
                                           (. (require :luasnip.loaders.from_vscode)
                                              :lazy_load))
                                 :after :friendly-snippets})
                          (pack :saadparwaiz1/cmp_luasnip
                                {:after [:nvim-cmp :LuaSnip]})
                          (pack :lukas-reineke/cmp-under-comparator
                                {:module :cmp-under-comparator
                                 :event :InsertCharPre})]})

(use-package! :neovim/nvim-lspconfig
              {:config! :lsp
               :run ":LspInstall pyright bashls"
               :requires [:williamboman/nvim-lsp-installer
                          (pack :j-hui/fidget.nvim
                                {:after :nvim-lspconfig :init :fidget})]})

;; LSP UI
(use-package! :tami5/lspsaga.nvim)

;; Custom LSPs
(use-package! :jose-elias-alvarez/null-ls.nvim
              {:config! :null-ls :requires :nvim-lua/plenary.nvim})

;;; ============================================================================

;;; ============================================================================
;;; Debug Adapter Protocol
;;; ============================================================================
;; DAP setup
(use-package! :mfussenegger/nvim-dap
              {:config! :dap
               :after :nvim-lspconfig
               :requires :mfussenegger/nvim-dap-python})

;; DAP pretty UI
(use-package! :rcarriga/nvim-dap-ui
              {:module :dapui :after :nvim-dap :init :dapui})

;;; ============================================================================
;;; Tests
;;; ============================================================================
;; Test runner
(use-package! :rcarriga/vim-ultest
              {:requires :vim-test/vim-test
               :run ":UpdateRemotePlugins"
               :config! :ultest})

;; :setup (fn []
;;          (let! ultest_pass_sign "")
;;          (let! ultest_fail_sign "")
;;          (let! ultest_running_sign "")
;;          (let! ultest_not_run_sign ""))})

;; :setup (fn []
;;          (let! test#python#pytest#options :--color=yes))})

;;; ============================================================================

;;; ============================================================================

;;; ============================================================================
;;; Treesitter
;;; ============================================================================
(use-package! :nvim-treesitter/nvim-treesitter
              {:config! :treesitter
               :requires [(pack :p00f/nvim-ts-rainbow {:after :nvim-treesitter})
                          (pack :nvim-treesitter/nvim-treesitter-textobjects
                                {:after :nvim-treesitter})]})

(use-package! :lewis6991/spellsitter.nvim {:init :spellsitter})
;;; ============================================================================
(unpack!)
