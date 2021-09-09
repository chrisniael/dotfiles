" Enable Mouse
set mouse=a

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! Sarasa Term SC:h12
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 0
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv

if has("win32")
  " Windows 终端 C-z 会有问题
  nnoremap <silent> <c-z> :<C-u>suspend<CR>
  inoremap <silent> <c-z> :<C-u>suspend<CR>
  vnoremap <silent> <c-z> :<C-u>suspend<CR>
  snoremap <silent> <c-z> :<C-u>suspend<CR>
  xnoremap <silent> <c-z> :<C-u>suspend<CR>
  cnoremap <silent> <c-z> :<C-u>suspend<CR>
  onoremap <silent> <c-z> :<C-u>suspend<CR>
endif

let g:is_full_screen = 0
function! FullScreenToggle()
  if g:is_full_screen == 0
    call GuiWindowFullScreen(1)
    let g:is_full_screen = 1
  else
    call GuiWindowFullScreen(0)
    let g:is_full_screen = 0
  endif
endfunction
nnoremap <silent><M-Enter> :<C-u>call FullScreenToggle()<CR>
