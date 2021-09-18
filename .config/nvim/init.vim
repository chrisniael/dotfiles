"----------------------------------------------------------------------
" VSCode Neovim Plugin 配置
" https://github.com/asvetliakov/vscode-neovim
"----------------------------------------------------------------------
if exists('g:vscode')
  set clipboard+=unnamedplus
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  " 类似于 return 结束整个脚本的执行
  finish

endif

"----------------------------------------------------------------------
" vim-plugin 插件列表
" https://github.com/junegunn/vim-plug
" Avoid using standard Vim directory names like 'plugin'
"----------------------------------------------------------------------
if has('nvim')
  " Li/Unux: ~/.local/share/nvim/plugged
  call plug#begin(stdpath('data') . '/plugged')
else
  if has("win32")
    call plug#begin('~/vimfiles/plugged')
  else
    call plug#begin('~/.vim/plugged')
  endif
endif

" 加快 git difftool 打开速度
if !&diff
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Plug 'jackguo380/vim-lsp-cxx-highlight'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-commentary'
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }
  Plug 'MTDL9/vim-log-highlighting', { 'for': ['log'] }
  Plug 'tpope/vim-obsession'
  Plug 'skywind3000/asynctasks.vim'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'skywind3000/asyncrun.extra'
  Plug 'skywind3000/vim-terminal-help'
  Plug 'andrejlevkovitch/vim-lua-format'
  Plug 'google/vim-maktaba'
  Plug 'google/vim-codefmt'
  Plug 'google/vim-glaive'
  Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
  Plug 'airblade/vim-rooter'
  Plug 'voldikss/vim-floaterm'
  " Plug 'fatih/vim-go', { 'for': ['go'] }
endif
Plug 'morhetz/gruvbox'
" Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
" Plug 'gu-fan/riv.vim'
Plug 'cespare/vim-toml', { 'for': ['toml'] }
Plug 'chrisniael/rsi.vim'
Plug 'chrisniael/indent.vim'

" Initialize plugin system
call plug#end()


"----------------------------------------------------------------------
" coc.nvim 插件列表
"----------------------------------------------------------------------
let g:coc_global_extensions = [
      \ 'coc-yank',
      \ 'coc-pairs',
      \ 'coc-lists',
      \ 'coc-clangd',
      \ 'coc-cmake',
      \ 'coc-rust-analyzer',
      \ 'coc-tasks',
      \ 'coc-json',
      \ 'coc-pyright',
      \ 'coc-lua',
      \ 'coc-vimlsp',
      \ 'coc-html',
      \ 'coc-prettier',
      \ 'coc-smartf',
      \ 'coc-imselect',
      \ 'coc-emoji',
      \ 'coc-word',
      \ 'coc-dictionary',
      \ 'coc-yaml',
      \ 'coc-go',
      \ 'coc-phpactor',
      \ 'coc-git',
      \ ]


"----------------------------------------------------------------------
" 字符缩进配置
" TODO: 可以支持项目目录本地化配置
"----------------------------------------------------------------------
" 缩进字符 tab, 宽度 4
let g:indent_tab_4w_filetypes = ['go']

" 缩进字符 2 空格
let g:indent_space_2w_filetypes = ['c', 'cpp', 'toml', 'json']

" 缩进字符 4 空格
let g:indent_space_4w_filetypes = ['toml', 'php', 'python']


"----------------------------------------------------------------------
" 适用于 diff 与 非 diff 模式的配置
"----------------------------------------------------------------------
" 显示标题
set title

" vim 支持显示粗体与斜体
" - https://github.com/neovim/neovim/issues/3461#issuecomment-268640486
" - https://github.com/tmux/tmux/issues/2262#issuecomment-640166755
" - https://github.com/mhinz/dotfiles/blob/master/bin/fix-term
if !has("nvim")
  set t_ZH=[3m
  set t_ZR=[23m
endif

" 设置 gruvbox 主题 contrast 程度 (得放在 colorscheme 设置之前)
" soft, medium (default), hard
" let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_contrast_light = 'hard'

" 设置 grubbox 主题支持粗体与斜体
" Windows 上斜体会有显示残留问题
" https://github.com/equalsraf/neovim-qt/issues/812
let g:gruvbox_bold = 1
if !has("win32")
  let g:gruvbox_italic = 1
endif

" 支持 xterm-256color
set t_Co=256

" 语法高亮
syntax enable

" 没有安装 gruvbox 插件的时候不报错
silent! colorscheme gruvbox

" changing coc highlight color cause light grey is invisible
" BUT is overwritten by scheme so defining it in an autocmd after colorscheme change
" https://github.com/neoclide/coc-highlight/issues/6
autocmd ColorScheme * highlight CocHighlightText gui=None guibg=#665c54

" 背景颜色, dark(default), light
set background=dark

" 透明背景
" highlight Normal ctermbg=NONE guibg=NONE
" highlight NonText ctermbg=NONE guibg=NONE

" 显示行号
set number

" 开启 true color
function! s:enable_true_color()
  if has("termguicolors")
    " fix bug for vim
    " vim --version 查看是否有 +termguicolors, 否则并不能启动 true color
    if !has("nvim")
      set t_8f=[38;2;%lu;%lu;%lum
      set t_8b=[48;2;%lu;%lu;%lum
    endif

    " enable true color
    set termguicolors
  endif
endfunction

" - 不支持 true color 的 terminal : macOS Terminal
" - 支持 true color 的 terminal : iTerm2, Mintty, PuTTY
" 暂时没有很好的方法判断 terminal 是否支持 true color
" 暂时这样配置兼容 macOS 上的 Terminal 和 iTerm2
" remote ssh 至 macOS 时, 不存在 COLORTERM 这个环境变量
" if has("mac")
"   if $COLORTERM == 'truecolor'
"     call s:enable_true_color()
"   endif
" else
"   call s:enable_true_color()
" endif
if $TERM_PROGRAM != "Apple_Terminal"
  call s:enable_true_color()
endif

" 光标所在行突出显示
set cursorline

" Make vim highlight the current line on only the active buffer
" https://stackoverflow.com/a/12018552
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" 不显示 tabline
set showtabline=0

" 设置垂直分隔符号, 配置最后有个空格字符, 使用空格作为垂直分隔符
set fillchars+=vert:\ 

" vim 默认打开文件时会显示文件信息 (:file), nvim 默认关闭
" https://vi.stackexchange.com/a/17724/37455
set shortmess+=F

" 设置Backspace模式
set backspace=indent,eol,start

" 启动vim时不自动折叠代码, 按 syntax 折叠代码会影响 vim diff 打开速度
" set foldmethod=syntax
set foldlevel=100

" 不显示折叠列标记
set foldcolumn=0

" 帮助显示中文
set helplang=cn

" 缓冲区内容的编码, 与系统当前locale相同
set encoding=utf-8

" 读取/写入文件的编码
set fileencoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" 输出到终端内容的编码, neovim 中被移除了
" set termencoding=utf-8

" 自动切换工作路径
"set autochdir

" 记录历史的行数
set history=1000

" 设置匹配模式, 例如当光标位于一个左括号上时, 会高亮相应的那个右括号
set showmatch

" 移除GUI版本中的 toolbar 和菜单栏
if has("gui_running")
  set guioptions=
  silent! set guifont=Sarasa\ Term\ SC:h12
endif

" 关闭错误响声
set novisualbell

" 关闭闪烁
if !has('nvim')
  set t_vb=
endif

" 在编辑过程中, 在右下角显示光标位置的状态行
set ruler

" 查询时非常方便, 如要查找book单词, 当输入到/b时, 会自动找到第一个b开头的单词,
" 当输入到/bo时, 会自动找到第一个bo开头的单词, 依次类推, 进行查找时,
" 使用此设置会快速找到答案, 当你找要匹配的单词时, 别忘记回车
" 关闭
set noincsearch

" 高亮查询结果
set hlsearch

" 不产生备份文件
set nobackup

" 使用的换行符类型
if has("win32")
  set fileformat=dos
  set fileformats=dos
else
  set fileformat=unix
  set fileformats=unix
endif

" 启用鼠标
set mouse=a

" :make 的时候自动保存
set autowrite

" 重新编辑文件的时, 光标定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" go 语法高亮额外的类型
let g:go_highlight_extra_types = 1

" proto文件高亮
augroup filetype
  autocmd! BufRead,BufNewFile *.proto setfiletype proto
augroup end

" .clang-format 文件识别为 yaml 文件
augroup filetype
  autocmd! BufRead,BufNewFile .clang-format setfiletype yaml
augroup end

" .tasks 配置文件识别为 dosini 文件
augroup filetype
  autocmd! BufRead,BufNewFile .tasks setfiletype dosini
augroup end

" 换行时不自动添加注释
" https://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines
au FileType * set formatoptions-=c formatoptions-=r formatoptions-=o

" Windows 终端 C-z 会有问题
if has("win32") && has("nvim")
  nnoremap <c-z> <nop>
  inoremap <c-z> <nop>
  vnoremap <c-z> <nop>
  snoremap <c-z> <nop>
  xnoremap <c-z> <nop>
  cnoremap <c-z> <nop>
  onoremap <c-z> <nop>
endif

" C-l 刷新时顺带消除搜索高亮
nnoremap <silent> <C-L> :<C-u>nohlsearch<CR><C-l>

" Terminal 模式使用 Esc 切换 Normal 模式, 存在一定问题, 例如在 Terminal 中再打开 vim
" tnoremap <Esc> <C-\><C-n>

" 粘贴快捷键
if has("nvim")
  inoremap <S-Insert> <C-r>*
  cnoremap <S-Insert> <C-r>*
endif
inoremap <C-v> <C-r>*
cnoremap <C-v> <C-r>*

" 同步 ssh 连接的 vim 剪切板到本地
" https://lotabout.me/2019/Integrate-clipboard-with-SSH/
if has("nvim")
  " Mac 上 XQuartz 有 bug, 不能同步 clipboard, 只能同步 primary, 所以配置成都走 primary
  if !has("win32") && !empty($SSH_CONNECTION)
    let g:clipboard = {
      \   'name': 'xclip-primary',
      \   'copy': {
      \      '+': 'xclip -i -selection primary',
      \      '*': 'xclip -i -selection primary',
      \    },
      \   'paste': {
      \      '+': 'xclip -o -selection primary',
      \      '*': 'xclip -o -selection primary',
      \   },
      \   'cache_enabled': 0,
      \ }
  endif

  " 所有复制操作都同步至 primary 剪切板 +
  set clipboard+=unnamedplus
else
  " :help clipboard-autoselect
  set clipboard=unnamed
endif


"----------------------------------------------------------------------
" riv.vim 配置
" https://github.com/gu-fan/riv.vim
"----------------------------------------------------------------------
" let g:riv_highlight_code = 'lua,python,cpp,javascript,vim,sh,proto,c'
" 处理回车键绑定其他操作导致补全操作不符合期望的问题
" autocmd FileType rst iunma <silent><buffer> <cr>


"----------------------------------------------------------------------
" coc-phpactor 配置
" https://github.com/phpactor/coc-phpactor
"----------------------------------------------------------------------
" php 变量补全时 $ 出现 2 个
" https://phpactor.readthedocs.io/en/master/lsp/vim.html#two-dollars-on-variables
autocmd FileType php set iskeyword+=$


"----------------------------------------------------------------------
" vim-cpp-enhanced-highlight 配置
" https://github.com/octol/vim-cpp-enhanced-highlight
"----------------------------------------------------------------------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
" let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1


"----------------------------------------------------------------------
" 仅仅用于 diff 模式的配置
"----------------------------------------------------------------------
if &diff
  " 不使用特定列高亮标记
  set colorcolumn=

  " 命令行高度
  set cmdheight=1

  " 不显示 status 信息，显示的话会多占用一行空间
  set laststatus=0

  " 在状态栏显示文件信息 (:file)
  set shortmess-=F

  " vimdiff 折行
  au VimEnter * execute 'windo set wrap'


"----------------------------------------------------------------------
" 仅仅用于非 diff 模式的配置
"----------------------------------------------------------------------
else
  autocmd FileType c,cpp set colorcolumn=81
  set laststatus=2

  " 不折行
  " autocmd FileType markdown set nowrap
  " 折行
  set wrap

  " 打开 terminal 时关闭行号和符号列, 并自动进入 insert 模式
  " 退出 terminal: <C-\><C-n>
  if has("nvim")
    au TermOpen * setlocal nonumber norelativenumber signcolumn=no | startinsert
  endif

  map <C-N> :cnext<CR>
  map <C-P> :cprevious<CR>

  " 自定义命令 W: 保存文件时不 format 文件
  if !exists(':W')
    command! W :noautocmd w
  endif

  if !exists(':Wq')
    command! Wq :noautocmd wq
  endif

  if !exists(':Wqa')
    command! Wqa :noautocmd wqa
  endif

  " 如果 tags 跳转存在多个选项, 则显示列表, 无则直接跳转
  set cscopetag
  set tags=./.tags;,.tags

  " 高亮光标所在位置的单词, 并输入全文替换的命令, 替换单词代填充
  nmap <leader>rp #<S-N>:%s/<C-R>=expand("<cword>")<CR>//g<Left><Left>

  " \-x 关闭 buf
  nmap <silent><leader>x :silent! bdelete<CR>

  "----------------------------------------------------------------------
  " vim-airline, vim-airline-theme 配置
  " - https://github.com/vim-airline/vim-airline
  " - https://github.com/vim-airline/vim-airline-themes
  "----------------------------------------------------------------------
  " set laststatus=2  " 底部显示状态栏, 1:不显示, 2:显示
  let g:airline_powerline_fonts = 1   " 使用 powerline 符号
  let g:airline_theme = "gruvbox"  " 设置主题
  let g:airline#extensions#tabline#enabled = 0  " 是否开启 tabline
  let g:airline#extensions#tabline#show_buffers = 0  " 是否显示 buffer
  let g:airline#extensions#tabline#buffer_nr_show = 0  " 显示 buffer 序号
  let g:airline#extensions#tabline#show_tabs = 1  " 是否显示 tab
  let g:airline#extensions#tabline#show_tab_count = 0  " 是否显示 tab 总数量在右边
  " let g:airline#extensions#tabline#show_tab_type = 1
  let g:airline#extensions#tabline#show_tab_nr = 0  " 是否显示 tab 序号
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#show_tab_type = 1  " 显示类型: buffer/tab
  let g:airline#extensions#tabline#tabs_label = 'T'
  if g:airline#extensions#tabline#show_buffers == 1
    nnoremap <silent> [b :bp<CR>
    nnoremap <silent> ]b :bn<CR>
  endif
  if g:airline#extensions#tabline#show_tabs == 1
    nnoremap <silent> [t :tabp<CR>
    nnoremap <silent> ]t :tabn<CR>
  endif

  " Windows 部分字体不能显示 Ɇ 这个字符, 可以改成 ∄ Ø
  " - https://github.com/vim-airline/vim-airline/issues/1729
  " - https://github.com/vim-airline/vim-airline/issues/1374
  " if !exists('g:airline_symbols')
  "   let g:airline_symbols = {}
  " endif
  " let g:airline_symbols.notexists = '∄'


  "----------------------------------------------------------------------
  " vim-gitgutter 配置
  " https://github.com/airblade/vim-gitgutter
  "----------------------------------------------------------------------
  " let g:gitgutter_set_sign_backgrounds = 1


  "----------------------------------------------------------------------
  " coc.nvim 配置
  " https://github.com/neoclide/coc.nvim
  "----------------------------------------------------------------------
  " 开启 semantic highlighting 支持
  " https://github.com/clangd/coc-clangd/issues/217#issuecomment-898130176
  let g:coc_default_semantic_highlight_groups = 1

  " if hidden is not set, TextEdit might fail.
  set hidden

  " Some servers have issues with backup files, see #649
  set nobackup
  set nowritebackup

  " Better display for messages
  set cmdheight=2

  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " 显示符号列
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    " inoremap <silent><expr> <c-space> coc#refresh()
    inoremap <silent><expr> <c-q> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  " <c-r>=coc#on_enter\<CR> 实现类似 IDE 函数体 {} 换行自动缩进
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use <C-h>/<C-l> jump to next/previous placeholder.
  let g:coc_snippet_next = '<C-l>'
  let g:coc_snippet_prev = '<C-h>'

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent! call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " Remap for format selected region
  xmap <silent> <leader>f  <Plug>(coc-format-selected)
  nmap <silent> <leader>f  :call CocAction('format')<CR>

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)
  autocmd FileType markdown nmap <leader>qf :CocCommand markdownlint.fixAll<CR>

  " Create mappings for function text object, requires document symbols feature of languageserver.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  " nmap <silent> <C-d> <Plug>(coc-range-select)
  " xmap <silent> <C-d> <Plug>(coc-range-select)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR :silent call CocAction('runCommand', 'editor.action.organizeImport')
  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <space>a  :<C-u>CocList --normal diagnostics<cr>
  " Manage extensions.
  " nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  " nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

  " coc.nvim c/c++ 头文件跳转
  " llvm 9.0 里 .h/.cpp 文件结构复杂时可能不能正常使用
  " llvm 10.0 修复了这个 bug
  function! s:EditAlternate()
    let l:alter = CocRequest('clangd', 'textDocument/switchSourceHeader', {'uri': 'file://'.expand("%:p")})
    " remove file:/// from response
    if l:alter != v:null
      let l:alter = substitute(l:alter, "file://", "", "")
      execute 'edit ' . l:alter
    endif
  endfunction
  " autocmd FileType c,cpp nmap <silent> gh :call <SID>EditAlternate()<CR>
  autocmd FileType c,cpp nmap <silent> gh :CocCommand clangd.switchSourceHeader<CR>


  "----------------------------------------------------------------------
  " coc-lists 配置
  " -A : 自动预览模式
  " --number-select : 显示行号, 也可以用行号选择
  " --normal : normal 模式
  " -I : interactive 模式
  "----------------------------------------------------------------------
  " cnoreabbrev CocList CocList --number-select

  " 在当前 buffer 中搜索光标所在单词
  command! -nargs=+ -complete=custom,s:WordsArgs CocListWords call CocListWordsOpt(<q-args>)

  function! CocListWordsOpt(...)
    if a:0 <= 0  " 参数个数
      return
    endif
    let arg_list = split(a:1)
    let i = 0
    let options = ''
    if len(arg_list) <= 0
      return
    endif
    while i < len(arg_list) - 1
      let arg = arg_list[i]
      let options .= arg . ' '
      let i += 1
    endwhile
    exe 'CocList --normal '.options.' --input='.arg_list[i].' words'
  endfunction

  function! s:WordsArgs(...)
    let list = ['--ignore-case']
    return join(list, "\n")
  endfunction

  " nnoremap <space>W :CocList --normal --ignore-case --input=<C-R>=expand('<cword>')<CR> words<Left><Left><Left><Left><Left><Left>
  nnoremap <space>w :<C-u>CocList -I --ignore-case words<CR>
  " 在当前 buffer 中搜索光标所在单词
  nnoremap <leader>w :<C-u>CocListWords <C-R>=expand('<cword>')<CR>
  " 在当前 buffer 中搜索 visual 模式选择的文本
  vnoremap <leader>w :<C-u>call <SID>WordsFromSelected(visualmode())<CR>

  function! s:WordsFromSelected(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
      normal! `<v`>y
    elseif a:type ==# 'char'
      normal! `[v`]y
    else
      return
    endif
    let word = substitute(@@, '\n$', '', 'g')
    let word = escape(word, '| ')
    let @@ = saved_unnamed_register
    execute 'CocList --normal --input='.word.' words'
  endfunction

  " 文件列表
  nnoremap <silent> <space>f :<C-u>CocList files<cr>

  " Buffer 列表
  nnoremap <silent> <space>b :<C-u>CocList buffers<cr>

  " 自定义的 grep 命令, 支持目录补全
  command! -nargs=+ -complete=dir CocListGrep exe 'CocList --normal grep '.<q-args>
  nnoremap <space>g :<C-u>CocListGrep<space>
  nnoremap <space>G :<C-u>CocListGrep -i<space>
  " Grep 光标所在单词
  nnoremap <leader>g :<C-u>CocListGrep <C-R>=expand('<cword>')<CR>
  nnoremap <leader>G :<C-u>CocListGrep -i <C-R>=expand('<cword>')<CR>
  " Grep visual 模式选择的文本
  vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
  vnoremap <leader>G :<C-u>call <SID>GrepFromSelectedIgnoreCase(visualmode())<CR>

  function! s:GrepFromSelected(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
      normal! `<v`>y
    elseif a:type ==# 'char'
      normal! `[v`]y
    else
      return
    endif
    let word = substitute(@@, '\n$', '', 'g')
    let word = escape(word, '| ')
    let @@ = saved_unnamed_register
    execute 'CocList --normal grep '.word
  endfunction

  function! s:GrepFromSelectedIgnoreCase(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
      normal! `<v`>y
    elseif a:type ==# 'char'
      normal! `[v`]y
    else
      return
    endif
    let word = substitute(@@, '\n$', '', 'g')
    let word = escape(word, '| ')
    let @@ = saved_unnamed_register
    execute 'CocList --normal grep -i '.word
  endfunction

  " 历史剪切板列表
  nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>


  "----------------------------------------------------------------------
  " vim-commentary 配置
  " https://github.com/tpope/vim-commentary
  "----------------------------------------------------------------------
  autocmd FileType c,cpp setlocal commentstring=//%s


  "----------------------------------------------------------------------
  " netrwPlugin 配置
  " https://github.com/vim/vim/blob/master/runtime/plugin/netrwPlugin.vim
  "----------------------------------------------------------------------
  " 关闭 netrw, neovim 使用 X11 forwarding 时会卡顿
  " neovim 5.0 已经解决这个问题
  " - https://github.com/neovim/neovim/issues/6048
  " - https://github.com/neovim/neovim/issues/11089
  " if has("nvim") && !empty($DISPLAY)
  "   let g:loaded_netrwPlugin = 1
  " endif


  "----------------------------------------------------------------------
  " asynctasks.vim 配置
  " https://github.com/skywind3000/asynctasks.vim
  "----------------------------------------------------------------------
  let g:asynctasks_config_name = ['.tasks', '.vim/tasks.ini', '.git/tasks.ini', '.svn/tasks.ini']
  let g:asyncrun_open = 10
  let g:asynctasks_term_pos = 'thelp'
  let g:asynctasks_term_rows = 10
  let g:asynctasks_term_reuse = 1
  let g:asynctasks_term_focus = 1
  let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
  let g:asyncrun_exit = 'silent! GitGutter'  "asynctask 提交 git 的时候默认 vim-gitgutter sign 不会更新

  au FileType qf setlocal signcolumn=  " quickfix 窗口不显示符号列
  au FileType qf setlocal nonumber  " quickfix 窗口不显示行号

  " https://vi.stackexchange.com/a/15699
  " let g:asyncrun_status = 'stopped'
  " function! AsyncrunGetStatus() abort
  "   return get(g:, 'asyncrun_status', '')
  " endfunction
  " silent! call airline#parts#define_function('asyncrun_status', 'AsyncrunGetStatus')
  " silent! let g:airline_section_x = airline#section#create_right(['bookmark', 'tagbar', 'vista', 'gutentags', 'gen_tags', 'omnisharp', 'grepper', 'asyncrun_status', 'filetype'])

  nnoremap <silent> <space>t  :<C-u>CocList tasks<cr>

  " quickfix list 与 localtion list toggle 快捷键
  " https://vim.fandom.com/wiki/Toggle_to_open_or_close_the_quickfix_window
  function! GetBufferList()
    redir =>buflist
    silent! ls!
    redir END
    return buflist
  endfunction

  function! ToggleList(bufname, pfx)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
      if bufwinnr(bufnum) != -1
        exec(a:pfx.'close')
        return
      endif
    endfor
    if a:pfx == 'l' && len(getloclist(0)) == 0
      " echohl ErrorMsg
      " echo a:bufname.' is Empty.'
      return
    endif
    exec(string(g:asyncrun_open).a:pfx.'open')
    exec('$')
    wincmd p
  endfunction

  " nmap <silent> <space>l :call ToggleList("Location List", 'l')<CR>
  " nmap <silent> <space>q :call ToggleList("Quickfix List", 'c')<CR>

  function! AsyncTaskRun()
    if &filetype == 'vim'
      source %
    else
      AsyncTask run
    endif
  endfunction

  nmap <silent> <leader>q :AsyncStop<CR>
  nmap <silent> <M-b> :AsyncTask build<CR>
  nmap <M-r> :call AsyncTaskRun()<CR>
  " autocmd FileType go nmap <M-t> :GoTestFunc -v<CR>


  "----------------------------------------------------------------------
  " vim-terminal-help 配置
  " https://github.com/skywind3000/vim-terminal-help
  "----------------------------------------------------------------------
  let g:terminal_cwd = 2 " project root
  let g:terminal_pos = 'top'


  "----------------------------------------------------------------------
  " coc-smartf 配置
  " https://github.com/neoclide/coc-smartf
  "----------------------------------------------------------------------
  " press <esc> to cancel.
  nmap f <Plug>(coc-smartf-forward)
  nmap F <Plug>(coc-smartf-backward)
  nmap ; <Plug>(coc-smartf-repeat)
  nmap , <Plug>(coc-smartf-repeat-opposite)

  augroup Smartf
    autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
    autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
  augroup end

  "----------------------------------------------------------------------
  " coc-dictionary
  " https://github.com/neoclide/coc-sources
  "----------------------------------------------------------------------
  " vim set option 不能使用 variable
  " - https://vim.fandom.com/wiki/Dictionary_completions
  " - https://vi.stackexchange.com/a/17451/37455
  if exists("*coc#util#get_config_home")
    let $COC_CONFIG_HOME = coc#util#get_config_home()
    set dictionary+=$COC_CONFIG_HOME/dic.txt
  endif


  "----------------------------------------------------------------------
  " vim-lua-foramt 配置
  " https://github.com/andrejlevkovitch/vim-lua-format
  "----------------------------------------------------------------------
  autocmd FileType lua nnoremap <buffer> <silent><leader>f :call LuaFormat()<CR>
  autocmd BufWrite *.lua call LuaFormat()


  "----------------------------------------------------------------------
  " vim-markdown 配置
  " https://github.com/plasticboy/vim-markdown
  "----------------------------------------------------------------------
  " 兼容 github 默认识别 protobuf 高亮 Protobuf code, 而 vim 识别 proto
  " 高亮 bash code, vim 识别 sh
  let g:vim_markdown_fenced_languages = ['protobuf=proto', 'bash=sh']


  "----------------------------------------------------------------------
  " vim-codefmt 配置
  " https://github.com/google/vim-codefmt
  "----------------------------------------------------------------------
  augroup autoformat_settings
    autocmd FileType proto,arduino AutoFormatBuffer clang-format
  augroup END


  "----------------------------------------------------------------------
  " vim-rooter 配置
  " https://github.com/airblade/vim-rooter
  "----------------------------------------------------------------------
  let g:rooter_manual_only = 1

  " Vim 打开时将工作目录切换至工程目录
  " https://vi.stackexchange.com/a/2559
  " if has("win32") && has("nvim")
  "   function InsertIfEmpty()
  "       if @% != ""
  " cd %:p:h
  "       endif
  "   endfunction

  "   au VimEnter * call InsertIfEmpty()
  " endif

  au VimEnter * if exists(":Rooter") | Rooter | endif


  "----------------------------------------------------------------------
  " vim-instant-markdown 配置
  " https://github.com/instant-markdown/vim-instant-markdown
  " 安装外部依赖
  " npm -g install instant-markdown-d
  "----------------------------------------------------------------------
  let g:instant_markdown_autostart = 0


  "----------------------------------------------------------------------
  " vim-gitgutter 配置
  " https://github.com/airblade/vim-gitgutter
  "----------------------------------------------------------------------
  " nnoremap <silent> <leader>hl :Git pull<CR>
  " nnoremap <silent> <leader>hh :Git push<CR>
  nnoremap <leader>hd :<C-u>Gdiffsplit<CR>


  "----------------------------------------------------------------------
  " coc-git 配置
  " https://github.com/neoclide/coc-git
  "----------------------------------------------------------------------
  nnoremap <space>h :<C-u>CocList --normal gstatus<CR>
  " navigate chunks of current buffer
  " nmap [c <Plug>(coc-git-prevchunk)
  " nmap ]c <Plug>(coc-git-nextchunk)
  " navigate conflicts of current buffer
  nmap [x <Plug>(coc-git-prevconflict)
  nmap ]x <Plug>(coc-git-nextconflict)
  " show chunk diff at current position
  " nmap <leader>hp <Plug>(coc-git-chunkinfo)
  " show commit contains current position
  " nmap <leader>hc <Plug>(coc-git-commit)
  " create text object for git chunks
  omap ig <Plug>(coc-git-chunk-inner)
  xmap ig <Plug>(coc-git-chunk-inner)
  omap ag <Plug>(coc-git-chunk-outer)
  xmap ag <Plug>(coc-git-chunk-outer)

  " nmap <leader>hu :<C-u>CocCommand git.chunkUndo<CR>
endif
