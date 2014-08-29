" Author: Michael Jenny
" Last Change: August 28, 2014
"
"
let g:p2#winres#version = '0.0.1'

" Resize current window by +/- 5 
"
" <C-Left>
if has('gui_running')
  nnoremap <silent> <D-S-LEFT> :WindowResize left<cr>
  nnoremap <silent> <D-S-RIGHT> :WindowResize right<cr>
  nnoremap <silent> <D-S-DOWN> :WindowResize down<cr>
  nnoremap <silent> <D-S-UP> :WindowResize top<cr>
else
  " <C-Left>
  nnoremap <ESC>[5D :WindowResize left<cr>
  " <C-Right>
  nnoremap <ESC>[5C :WindowResize right<cr>
  " <C-Down>
  nnoremap <ESC>[B :WindowResize down<cr>
  " <C-Up>
  nnoremap <ESC>[A :WindowResize top<cr>
endif


function! s:windowResize(direction) 
  let g:nr = winnr()
  if a:direction == 'left' || a:direction == 'right'
    exe 'wincmd l'
  else
    exe 'wincmd k'
    if g:nr == winnr()
        " no window in top of this one
        if a:direction == 'top'
            exe '5 winc -'
        elseif a:direction == 'down'
            exe '5 winc +'
        endif
    else
        " Move cursor back to window where we were before (down)
        exe g:nr.'wincmd w'
        if a:direction == 'top'
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
