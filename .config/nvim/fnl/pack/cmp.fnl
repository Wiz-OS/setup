;;; ============================================================================
;;;  __      __________   ______
;;; /  \    /  \_____  \ /  __  \
;;; \   \/\/   //  ____/ >      <
;;;  \        //       \/   --   \
;;;   \__/\  / \_______ \______  /
;;;        \/          \/      \/
;;; cmp.fnl --- Settings for nvim-cmp
;;; Copyright (c) 2021-present Sourajyoti Basak
;;; Author: Sourajyoti Basak <wiz28@protonmail.com>
;;; URL: https://github.com/wizard-28/dotfiles/
;;; License: MIT
;;; ============================================================================

(import-macros {: set! : let! : map! : cmd} :macros)

(local {: setup
        : mapping
        : select_next_item
        : visible
        : complete
        :config {: compare : disable}
        :SelectBehavior {:Insert insert-behavior :Select select-behavior}
        : event} (require :cmp))

(local types (require :cmp.types))
(local under-compare (require :cmp-under-comparator))
(local {: insert} table)

(local luasnip (require :luasnip))

(fn has-words-before []
  (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
    (and (not= col 0) (= (: (: (. (vim.api.nvim_buf_get_lines 0 (- line 1) line
                                                              true)
                                  1) :sub col
                               col) :match "%s") nil))))

;;; ============================================================================
;;; Highlights
;;; ============================================================================
(cmd "hi CmpItemAbbrMatch gui=bold guifg=#FAFAFA")
(cmd "hi CmpItemAbbrMatchFuzzy guifg=#FAFAFA")
(cmd "hi CmpItemAbbr guifg=#a8a8a8")

(cmd "hi CmpItemKindVariable guibg=NONE guifg=#be95ff")
(cmd "hi CmpItemKindInterface guibg=NONE guifg=#be95ff")
(cmd "hi CmpItemKindText guibg=NONE guifg=#be95ff")

(cmd "hi CmpItemKindFunction guibg=NONE guifg=#ff7eb6")
(cmd "hi CmpItemKindMethod guibg=NONE guifg=#ff7eb6")

(cmd "hi CmpItemKindKeyword guibg=NONE guifg=#33b1ff")
(cmd "hi CmpItemKindProperty guibg=NONE guifg=#33b1ff")
(cmd "hi CmpItemKindUnit guibg=NONE guifg=#33b1ff")
;;; ============================================================================

;;; ============================================================================
;;; Settings
;;; ============================================================================
(set! completeopt [:menu :menuone :noselect])

(setup {:preselect types.cmp.PreselectMode.None
        :formatting {:format (fn [entry vim-item]
                               (set vim-item.menu
                                    (. {:nvim_lsp :lsp
                                        :nvim_lsp_signature_help :sig
                                        :Path :pth
                                        :treesitter :trs
                                        :copilot :cop
                                        :buffer :buf
                                        :conjure :cj
                                        :luasnip :snp}
                                       entry.source.name))
                               (set vim-item.kind
                                    (. {:Text ""
                                        :Method ""
                                        :Function ""
                                        :Constructor ""
                                        :Field "ﰠ"
                                        :Variable ""
                                        :Class "ﴯ"
                                        :Interface ""
                                        :Module ""
                                        :Property "ﰠ"
                                        :Unit "塞"
                                        :Value ""
                                        :Enum ""
                                        :Keyword ""
                                        :Snippet ""
                                        :Color ""
                                        :File ""
                                        :Reference ""
                                        :Folder ""
                                        :EnumMember ""
                                        :Constant ""
                                        :Struct "פּ"
                                        :Event ""
                                        :Operator ""
                                        :TypeParameter ""}
                                       vim-item.kind))
                               vim-item)}
        :mapping {:<C-b> (mapping.scroll_docs -4)
                  :<C-f> (mapping.scroll_docs 4)
                  :<C-space> (mapping.complete)
                  :<C-e> (mapping.abort)
                  :<up> disable
                  :<down> disable
                  :<Tab> (mapping (fn [fallback]
                                    (if (visible) (select_next_item)
                                        (luasnip.expand_or_jumpable)
                                        (luasnip.expand_or_jump)
                                        (has-words-before)
                                        (complete {:select false}) (fallback)))
                                  [:i :s])
                  :<S-Tab> (mapping (fn [fallback]
                                      (if (visible) (mapping.select_prev_item)
                                          (luasnip.jumpable (- 1)) (luasnip.jump (- 1))
                                          (fallback)))
                                    [:i :s])
                  :<space> (mapping.confirm {:select false})}
        :snippet {:expand (fn [args]
                            ((. (require :luasnip) :lsp_expand) args.body))}
        :sources [{:name :copilot}
                  {:name :nvim_lsp}
                  {:name :nvim_lsp_signature_help}
                  {:name :luasnip}
                  {:name :conjure}
                  {:name :path}
                  {:name :neorg}
                  {:name :treesitter}
                  {:name :buffer}]
        :sorting {:comparators [compare.offset
                                compare.exact
                                compare.score
                                under-compare.under
                                compare.kind
                                compare.sort_text
                                compare.length
                                compare.order]}})

;;; ============================================================================
