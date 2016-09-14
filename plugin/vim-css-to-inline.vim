function! s:doReg(str)
  " left part before :
  let l:vr = substitute(a:str, '\%([;\n]\zs\|^\@=\)\(\_s*\a\+\)-\(\a\)', '\1\U\2', 'g')

  " right part after :
  let l:vr = substitute(l:vr, ':\zs\([^:;]*;.*\)\@=\(\_s*0\_s*;\)\@!\_s*\([^;]*\);', " '\\3',", 'g')

  " replace 'Npx' with N
  if !get(g:, 'csstoinline_wrap_pixels', 0)
    let l:vr = substitute(l:vr, ':\zs\%(.*,\)\@=\(\_s*''\(\d\+\)\px''\)', ' \2', 'g')
  endif

  return l:vr
endfunction

function! s:CssToInline(type)
  let s:previous_q_reg = @q

  if a:type ==# 'v'
    normal! gv"qy
    let l:res = s:doReg(@q)
    let @q = substitute(l:res, ';', ',', 'g')
    normal! gv"qgp"
  elseif a:type ==# 'n'
    execute "normal! ?{\<cr>:nohlsearch\<cr>v/}\<cr>\"qd"
    let l:res = s:doReg(@q)
    let @q = substitute(l:res, ';', ',', 'g')
    normal! "qP
  endif

  let @q = s:previous_q_reg
endfunction

nnoremap <silent> <Plug>ToInlineN :call <SID>CssToInline('n')<cr>
xnoremap <silent> <Plug>ToInlineV :<C-U>call <SID>CssToInline('v')<cr>

if !get(g:, 'csstoinline_no_mapping', 0)
  nmap tis <Plug>ToInlineN
  xmap tis <Plug>ToInlineV
endif

