" Author: Michael Jenny
" Last Change: August 28, 2014
"
"
let g:p2#winres#version = '0.0.1'

" Resize current window by +/- 5
"
nnoremap ˙ :WindowResize left<cr>
nnoremap ∆ :WindowResize down<cr>
nnoremap ˚ :WindowResize up<cr>
nnoremap ¬ :WindowResize right<cr>

function! s:windowResize(direction)
  let g:nr = winnr()
  if a:direction == 'left' || a:direction == 'right'
    exe 'wincmd l'
  else
    exe 'wincmd k'
    if g:nr == winnr()
        " no window in top of this one
        if a:direction == 'up'
            exe '5 winc -'
        elseif a:direction == 'down'
            exe '5 winc +'
        endif
    else
        " Move cursor back to window where we were before (down)
        exe g:nr.'wincmd w'
        if a:direction == 'up'
            exe '5 winc +'
        elseif a:direction == 'down'
            exe '5 winc -'
        endif
    endif
  endif
  if g:nr == winnr()
    " There's no more righthand window.
    if a:direction == 'left'
      exe '5 winc >'
    elseif a:direction == 'right'
      exe '5 winc <'
    endif
  else
    " Move cursor back to window where we were before
    if a:direction == 'left' || a:direction == 'right'
         exe g:nr.'wincmd w'
    endif
    if a:direction == 'left'
      exe '5 winc <'
    elseif a:direction == 'right'
      exe '5 winc >'
    endif
  endif
endfunction
command! -nargs=1 WindowResize call s:windowResize(<f-args>)

" vim: ts=2 sw=2 et
