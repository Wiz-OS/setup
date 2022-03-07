;;; =============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; ultest.fnl --- configure vim-ultest
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; ============================================================================

;;; ===========================================================================
;;; Key bindings
;;; ===========================================================================

(local {: register} (require :which-key))

(register {:<localleader>t {:name :+Test}
           :<localleader>tt [":Ultest<cr>" "Run all tests"]
           :<localleader>tn [":UltestNearest<cr>" "Run nearest test"]
           :<localleader>tl [":UltestLast<cr>" "Run last test"]
           :<localleader>td [":UltestDebug<cr>" "Debug the file"]
           :<localleader>to [":UltestOutput<cr>" "Show output of nearest test"]
           :<localleader>ta [":UltestAttach<cr>"
                             "Attach to the running process"]
           :<localleader>tS [":UltestStop<cr>" "Stop all running tests"]
           :<localleader>ts [":UltestSummary!<cr>" "Show test summary"]
           :<localleader>tc [":UltestClear<cr>" "Clear test results"]
           :<localleader>tN ["<Plug>(ultest-next-fail)" "Jump to next failure"]
           :<localleader>tP ["<Plug>(ultest-prev-fail)"
                             "Jump to previous failure"]})
