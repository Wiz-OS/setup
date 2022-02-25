;;; ============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; neorg.fnl --- Neorg settings
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; ============================================================================

(local {: setup} (require :neorg))

;;; ============================================================================
;;; Setup
;;; ============================================================================
(setup {:load {:core.defaults {}
               :core.norg.concealer {}
               :core.norg.qol.toc {}
               :core.norg.completion {:config {:engine :nvim-cmp}}
               :core.norg.dirman {:config {:workspaces {:main :/media/pop-os/SBASAK/studies}}
                                  :autodetect true
                                  :autochdir true}}})

;;; ============================================================================

;;; ============================================================================
;;; Treesitter parsers
;;; ============================================================================
(local parser-config
       ((. (require :nvim-treesitter.parsers) :get_parser_configs)))

(set parser-config.norg_meta
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
                     :files :src/parser.c
                     :branch :main}})

(set parser-config.norg_table
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
                     :files :src/parser.c
                     :branch :main}})

;;; ============================================================================
