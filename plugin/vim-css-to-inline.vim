function! s:transform(str)
  let l:vr = substitute(a:str, '\%([;\n]\zs\|^\@=\)\(\_s*\a\+\)-\(\a\)', '\1\U\2', 'g')
  let l:vr = substitute(l:vr, ':\zs\([^:;]*;.*\)\@=\(\_s*0\_s*;\)\@!\_s*\([^;]*\);', " '\\3',", 'g')
  " replace 'Npx' with N
  if !get(g:, 'csstoinline_wrap_pixels', 0)
    let l:vr = substitute(l:vr, ':\zs\%(.*,\)\@=\(\_s*''\(\d\+\)\px''\)', ' \2', 'g')
  endif

  return substitute(l:vr, ';', ',', 'g')
endfunction

function! s:reverse(str)
  let l:vr = substitute(a:str, '\%([,\n]\zs\|^\@=\)\(\_s*\l*\)\(\u\+\)', '\1-\l\2', 'g')
  let l:vr = substitute(l:vr, ':\_s*\zs\(''\([^'']*\)''\)', '\2', 'g')

  if !get(g:, 'csstoinline_wrap_pixels', 0)
    let l:vr = substitute(l:vr, ':\_s*\zs\(\d\+\),\@=', '\1px', 'g')
  endif

  return substitute(l:vr, ',', ';', 'g')
endfunction

function! s:main(mode, direction)
  let s:previous_q_reg = @q

  if a:mode ==# 'v'
    normal! gv"qy
    if a:direction ==# 0
      let l:res = s:transform(@q)
    else
      let l:res = s:reverse(@q)
    endif
    let @q = l:res
    normal! gv"qgp"
  elseif a:mode ==# 'n'
    execute "normal! ?{\<cr>:nohlsearch\<cr>v/}\<cr>\"qd"
    if a:direction ==# 1
      let l:res = s:reverse(@q)
    else
      let l:res = s:transform(@q)
    endif
    let @q = l:res
    normal! "qP
  endif

  let @q = s:previous_q_reg
endfunction

nnoremap <silent> <Plug>ToInlineN :call <SID>main('n', 0)<cr>
xnoremap <silent> <Plug>ToInlineV :<C-U>call <SID>main('v', 0)<cr>

nnoremap <silent> <Plug>FromInlineN :call <SID>main('n', 1)<cr>
xnoremap <silent> <Plug>FromInlineV :<C-U>call <SID>main('v', 1)<cr>

if !get(g:, 'csstoinline_no_mapping', 0)
  nmap tis <Plug>ToInlineN
  xmap tis <Plug>ToInlineV
  nmap fis <Plug>FromInlineN
  xmap fis <Plug>FromInlineV
endif

