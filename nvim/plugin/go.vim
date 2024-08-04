let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1

" Disable vim-go LSP
let g:go_gopls_enabled = 1
let g:go_diagnostics_level = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0

""" go mod tidy
:command GoModTidy !go mod tidy -v
