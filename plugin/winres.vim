" Author: Michael Jenny
" Last Change: August 28, 2014
"
"
let g:p2#winres#version = '0.0.1'

" Resize current window by +/- 5 
"
" <C-Left>
nnoremap <ESC>[5D :ResizeWindow west<cr>
" <C-Right>
nnoremap <ESC>[5C :ResizeWindow east<cr>
" <C-Down>
nnoremap <ESC>[B :ResizeWindow south<cr>
" <C-Up>
nnoremap <ESC>[A :ResizeWindow north<cr>


function! s:windowResize(cardinalDirection) 
  let g:nr = winnr()
  if a:cardinalDirection == 'west' || a:cardinalDirection == 'east'
    exe 'wincmd l'
  else
    exe 'wincmd k'
    if g:nr == winnr()
        " no window in top of this one
        if a:cardinalDirection == 'north'
            exe '5 winc -'
        elseif a:cardinalDirection == 'south'
            exe '5 winc +'
        endif
    else
        " Move cursor back to window where we were before (down)
        exe g:nr.'wincmd w'
        if a:cardinalDirection == 'north'
            exe '5 winc +'
        elseif a:cardinalDirection == 'south'
            exe '5 winc -'
        endif
    endif
  endif
  if g:nr == winnr()
    " There's no more righthand window.
    if a:cardinalDirection == 'west'
      exe '5 winc >'
    elseif a:cardinalDirection == 'east'
      exe '5 winc <'
    endif
  else
    " Move cursor back to window where we were before
    if a:cardinalDirection == 'west' || a:cardinalDirection == 'east'
         exe g:nr.'wincmd w'
    endif
    if a:cardinalDirection == 'west'
      exe '5 winc <'
    elseif a:cardinalDirection == 'east'
      exe '5 winc >'
    endif
  endif
endfunction
command! -nargs=1 WindowResize call s:windowResize(<f-args>)

" vim: ts=2 sw=2 et
