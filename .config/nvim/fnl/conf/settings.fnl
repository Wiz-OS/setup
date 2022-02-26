;;; ==============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; settings.fnl --- settings for neovim
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; =============================================================================
(import-macros {: set! : let!} :conf.macros)

;;; ============================================================================
;;; Disable unnecessary plugins
;;; ============================================================================
(let [built-ins [:netrw
                 :netrwPlugin
                 :netrwSettings
                 :netrwFileHandlers
                 :gzip
                 :zip
                 :zipPlugin
                 :tar
                 :tarPlugin
                 :getscript
                 :getscriptPlugin
                 :vimball
                 :vimballPlugin
                 :2html_plugin
                 :logipat
                 :rrhelper
                 :spellfile_plugin
                 :matchit]]
  (each [_ v (ipairs built-ins)]
    (let [b (.. :loaded_ v)]
      (tset vim.g b 1))))

;;; ============================================================================
;;; Global variables
;;; ============================================================================
(let! mapleader " ")

;; Map <leader> to <space>
(let! maplocalleader ",")

;; Map <localleader> to ,
(let! python3_host_prog :/bin/python3)

;; Set python3 host
;;; ============================================================================

;;; ============================================================================
;;; Settings
;;; ============================================================================
;;; Line numbers
;; Show relative line numbers
(set! relativenumber)

;; Show absolute line numbers
(set! number true)

;;; Utility
;; Smart searching
(set! smartcase)

;; Show white spaces as characters
(set! list)

;; Enable mouse support
(set! mouse :a)

;; Spell checking
(set! spell)

;; Highlight the text line of cursor
(set! cursorline)

;;; Files
;; Use a undo file
(set! undofile)

;; Disable swap file
(set! noswapfile)

;; Disable write backup
(set! nowritebackup)

;;; Splits
;; Horizontal splits will be below
(set! splitbelow)

;; Vertical splits will be right
(set! splitright)

;;; Tabs
;; Number of spaces a tab represents
(set! tabstop 4)

;; Number of spaces to use for indent
(set! shiftwidth 4)

;; Expand tabs to spaces
(set! expandtab)

;;; Misc
;; Infinite signs, width auto adjusted
(set! signcolumn "auto:9")

;; Disable line wrapping 
(set! nowrap)

;; Enable True Color support
(set! termguicolors)

;; Timeout for a mapped sequence
(set! timeoutlen 500)

;; Faster macros (redraw screen after change)
(set! lazyredraw)
;;; ============================================================================
;; vim:set tw=2 sw=2:
