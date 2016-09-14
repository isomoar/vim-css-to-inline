function! s:doReg(str)
  " left part before :
  let l:vr = substitute(a:str, '\%([;\n]\zs\|^\@=\)\(\_s*\a\+\)-\(\a\)', '\1\U\2', 'g')

  " right part after :
  let l:vr = substitute(l:vr, ':\zs\([^:;]*;.*\)\@=\(\_s*0\_s*;\)\@!\s_*\([^;]*\);', " '\\3',", 'g')

  " replace 'Npx' with N
  if !exists("g:csstoinline_wrap_pixels") || ! g:csstoinline_wrap_pixels
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
    normal! vi{"qy
    let l:res = s:doReg(@q)
    let @q = substitute(l:res, ';', ',', 'g')
    normal! di{"qP
  endif

  let @q = s:previous_q_reg
endfunction

nnoremap <silent> <Plug>ToInlineN :call <SID>CssToInline('n')<cr>
xnoremap <silent> <Plug>ToInlineV :<C-U>call <SID>CssToInline('v')<cr>

if !exists("g:csstoinline_no_mapping")
  nmap tis <Plug>ToInlineN
  xmap tis <Plug>ToInlineV
endif

