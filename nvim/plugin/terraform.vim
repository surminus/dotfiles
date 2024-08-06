" Automatically open Terraform docs resource
" TODO: we should rewrite this in Lua?
function! TerraformDocs()
  let line = getline('.')
  let parts = split(line, '\zs\s\+\ze')

  if parts[0] != 'resource' && parts[0] != 'data'
    echoerr 'Cannot process line: '.line
    return
  endif

  let type = parts[0]
  let full_resource = parts[1]

  let provider = split(full_resource, "_")[0]
  let identifier = substitute(full_resource, provider.'_', '', '')

  if type == "data"
    let url_type = 'data-sources/'
  else
    let url_type = 'resources/'
  endif

  let url = 'https://registry.terraform.io/providers/hashicorp/'.provider.'/latest/docs/'.url_type.identifier

  execute system('open ' . url)
endfunction

function! TerraformFunc()
  let word = expand('<cword>')
  if word ==# ""
    echoerr 'No word under cursor'
    return
  endif

  let url = 'https://www.terraform.io/docs/configuration/functions/' . word . '.html'
  execute system('open ' . url)
endfunction

command TerraformDocs call TerraformDocs()
command TerraformFunc call TerraformFunc()

let g:terraform_binary_path = "tofu"
let g:terraform_fmt_on_save = 1
