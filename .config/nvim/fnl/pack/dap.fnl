;;; ===========================================================================
;;; DAP hooks
;;; ===========================================================================
(local (dap dapui) (values (require :dap) (require :dapui)))
(tset dap.listeners.after.event_initialized :dapui_config
      (fn []
        (dapui.open)))

(tset dap.listeners.before.event_terminated :dapui_config
      (fn []
        (dapui.close)))

(tset dap.listeners.before.event_exited :dapui_config
      (fn []
        (dapui.close)))

;;; ===========================================================================
;;; DAP Key bindings
;;; ===========================================================================

(local {: register} (require :which-key))

(register {:<localleader>db [(fn []
                               ((. (require :dap) :toggle_breakpoint)))
                             "Toggle breakpoint"]
           :<localleader>dd [(fn []
                               ((. (require :dap) :continue)))
                             "Start debugging"]
           :<localleader>do [(fn []
                               ((. (require :dap) :step_over)))
                             "Step over"]
           :<localleader>di [(fn []
                               ((. (require :dap) :step_into)))
                             "Step into"]
           :<localleader>dr [(fn []
                               ((. (. (require :dap) :repl) :open)))
                             "Open REPL"]})

;;; ===========================================================================
;;; DAP Python settings
;;; ===========================================================================
;; Setup
(local dap-python (require :dap-python))

(dap-python.setup :/usr/bin/python3)
(set dap-python.test_runner :pytest)

;; Key bindings
(register {:<localleader>d {:name :+DAP}
           :<localleader>dm [(fn []
                               ((. (require :dap-python) :test_method)))
                             "Test method"]
           :<localleader>dc [(fn []
                               ((. (require :dap-python) :test_class)))
                             "Test class"]
           :<localleader>ds [(fn []
                               ((. (require :dap-python) :debug_selection)))
                             "Debug selection"]})

;;; ===========================================================================
