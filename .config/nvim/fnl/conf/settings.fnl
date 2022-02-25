; ==============================================================================
;;  __      __________   ______
;; /  \    /  \_____  \ /  __  \
;; \   \/\/   //  ____/ >      <
;;  \        //       \/   --   \
;;   \__/\  / \_______ \______  /
;;        \/          \/      \/
;; settings.fnl - settings for neovim
;; Copyright (c) 2021-present Sourajyoti Basak
;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;; URL: https://github.com/wizard-28/dotfiles/
;; License: MIT
;; =============================================================================
(import-macros {: set! : let! : map!} :conf.macros)

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

; Map <leader> to <space>
(let! maplocalleader ",")

; Map <localleader> to ,
(let! python3_host_prog :/bin/python3)

; Set python3 host
;;; ============================================================================

;;; ============================================================================
;;; Settings
;;; ============================================================================
;; Line numbers
(set! relativenumber)

; Show relative line numbers
(set! number true)

; Show absolute line numbers

;; Utility
(set! smartcase)

; Smart searching
(set! list)

; Show white spaces as characters
(set! mouse :a)

; Enable mouse support
(set! spell)

; Spell checking
(set! cursorline)

; Highlight the text line of cursor

;; Files
(set! undofile)

; Use a undo file
(set! noswapfile)

; Disable swap file
(set! nowritebackup)

; Disable write backup

;; Splits
(set! splitbelow)

; Horizontal splits will be below
(set! splitright)

; Vertical splits will be right

;; Tabs
(set! tabstop 4)

; Number of spaces a tab represents
(set! shiftwidth 4)

; Number of spaces to use for indent
(set! expandtab)

; Expand tabs to spaces

;; Misc
(set! signcolumn "auto:9")

; Infinite signs, width auto adjusted
(set! nowrap)

; Disable line wrapping 
(set! termguicolors)

; Enable True Color support
(set! timeoutlen 500)

; Timeout for a mapped sequence
(set! lazyredraw)

; Faster macros (redraw screen after change)
;;; ============================================================================
;; vim:set tw=2 sw=2:
