" Disable arrow keys
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
  exec 'cnoremap' key '<Nop>'
endfor

" Disable page-up & page-down
nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>
