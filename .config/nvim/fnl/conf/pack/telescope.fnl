;;; ============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; telescope.fnl --- Settings for telescope
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; ============================================================================

(local {: setup} (require :telescope))
(local {: open_with_trouble} (require :trouble.providers.telescope))

(setup {:defaults {:vimgrep_arguments [:rg
                                       :--hidden
                                       :--color=never
                                       :--no-heading
                                       :--with-filename
                                       :--line-number
                                       :--column
                                       :--smart-case]
                   :file_ignore_patterns [:$.git/*]
                   :mappings {:i {:<c-t> open_with_trouble}
                              :n {:<c-t> open_with_trouble}}}
        :extensions {:fzf {:fuzzy true
                           :override_generic_sorter false
                           :override_file_sorter true}}})

((. (require :telescope) :load_extension) :fzf)
