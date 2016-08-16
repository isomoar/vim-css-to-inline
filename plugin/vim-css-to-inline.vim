" transform css to jsx inline styles
function! CssToInline()
  let s:previous_q_reg = @q
  execute "normal! \"qyiB"
  let s:vr = @q

  " left part before :
  let s:vr = substitute(s:vr, '[;\n]\zs\(\_s*\a\+\)-\(\a\)', '\1\U\2', 'g')
  " right part after :
  let s:vr = substitute(s:vr, ':\zs\([^:;]*;.*\)\@=\(\_s*0\_s*;\)\@!\s_*\([^;]*\);', " '\\3',", 'g')
  " replace '12px' with 12
  let s:vr = substitute(s:vr, ':\zs\%(.*,\)\@=\(\_s*''\(\d\+\)\px''\)', ' \2', 'g')

  let @q = substitute(s:vr, ';', ',', 'g')

  exec "normal! di{\"qP"
  let @q = s:previous_q_reg
endfunction

