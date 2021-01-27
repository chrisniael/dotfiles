" neovim config
" ln -s ~/.vim ~/.config/nvim
" ln -s ~/.vimrc ~/.config/nvim/init.vim

" Install vim-plugin
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" 加快 git difftool 打开速度
if !&diff
  " pip3 install pynvim
  " npm install -g neovim
  " pacman -S ripgrep
  " pacman -S clangd
  " npm install -g bash-language-server
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'jackguo380/vim-lsp-cxx-highlight'
  Plug 'airblade/vim-gitgutter'
  " vim-fugitive, vim-airline, vim-airline-themes 组合安装
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
  Plug 'andrejlevkovitch/vim-lua-format'
  Plug 'fatih/vim-go', { 'for': ['go'] }
  Plug 'google/vim-maktaba'
  Plug 'google/vim-codefmt'
  Plug 'google/vim-glaive'
endif
Plug 'morhetz/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
" 可选替代 vim-husk
Plug 'tpope/vim-rsi'
Plug 'gu-fan/riv.vim'

" Initialize plugin system
call plug#end()

" coc.nvim 的插件
let g:coc_global_extensions = [
      \ 'coc-yank', 'coc-pairs', 'coc-lists', 'coc-clangd',
      \ 'coc-cmake', 'coc-rust-analyzer', 'coc-tasks', 'coc-json',
      \ 'coc-pyright', 'coc-lua', 'coc-vimlsp', 'coc-html',
      \ 'coc-prettier', 'coc-smartf', 'coc-imselect', 'coc-emoji',
      \ 'coc-word', 'coc-dictionary', 'coc-yaml'
      \ ]

" 适用于所有场景的配置
" vim 支持显示粗体与斜体
" https://github.com/neovim/neovim/issues/3461#issuecomment-268640486
" https://github.com/tmux/tmux/issues/2262#issuecomment-640166755
" https://github.com/mhinz/dotfiles/blob/master/bin/fix-term
if !has("nvim")
  set t_ZH=[3m
  set t_ZR=[23m
endif

" 设置 gruvbox 主题 contrast 程度 (得放在 colorscheme 设置之前) : soft, medium (default), hard
" let g:gruvbox_contrast_dark = 'medium'
" let g:gruvbox_contrast_light = 'medium'
" 设置 grubbox 主题支持粗体与斜体
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
set t_Co=256  " 支持 xterm-256color
syntax enable  " 语法高亮
" 为了在没有安装 gruvbox 插件的时候不报错
silent! colorscheme gruvbox
" changing coc highlight color cause light grey is invisible
" BUT is overwritten by scheme so defining it in an autocmd after colorscheme change
" https://github.com/neoclide/coc-highlight/issues/6
autocmd ColorScheme * highlight CocHighlightText gui=None guibg=#665c54
set background=dark
set number

function! s:enable_true_color()
  if has("termguicolors")
    " fix bug for vim
    " vim --version 查看是否有 +termguicolors，否则并不能启动 true color
    if !has("nvim")
      set t_8f=[38;2;%lu;%lu;%lum
      set t_8b=[48;2;%lu;%lu;%lum
    endif

    " enable true color
    set termguicolors
  endif
endfunction

" 不支持 true color 的 terminal : macOS Terminal
" 支持 true color 的 terminal : iTerm2, Mintty, PuTTY
" 暂时没有很好的方法判断 terminal 是否支持 true color
" 暂时这样配置兼容 macOS 上的 Terminal 和 iTerm2
" remote ssh 至 macOS 时，不存在 COLORTERM 这个环境变量
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

" 设置垂直分隔符号
set fillchars+=vert:\ 

" make vim highlight the current line on only the active buffer
" https://stackoverflow.com/a/12018552
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" 设置Backspace模式
set backspace=indent,eol,start

" 启动vim时不自动折叠代码
" 会影响 vim diff 打开速度
" set foldmethod=syntax
set foldlevel=100

" 不显示折叠列标记
set foldcolumn=0

" 帮助显示中文
set helplang=cn

" 缓冲区内容的编码，与系统当前locale相同
set encoding=utf-8
" 读取/写入文件的编码
set fileencoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
" 输出到终端内容的编码，neovim 中被移除了
" set termencoding=utf-8

" 自动切换工作路径
"set autochdir

" 记录历史的行数
set history=1000

" 下面两行在进行编写代码时，在格式对起上很有用；
" 第一行，vim使用自动对起，也就是把当前行的对起格式应用到下一行；
" 第二行，依据上面的对起格式，智能的选择对起方式，对于类似C语言编
" 写上很有用
set autoindent
set smartindent

" 第一行设置tab键为4个空格，第二行设置当行之间交错时使用4个空格
set expandtab
set tabstop=2
set softtabstop=0
set shiftwidth=2
set smarttab

" go 缩进符用 Tab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
" json 缩进符 2 Space
autocmd BufNewFile,BufRead *.json setlocal expandtab tabstop=2 shiftwidth=2
" python 缩进符 4 Space
autocmd BufNewFile,BufRead *.json setlocal expandtab tabstop=4 shiftwidth=4

" 设置匹配模式，例如当光标位于一个左括号上时，会高亮相应的那个右括号
set showmatch

" 去除GUI版本中的toolbar
"set guioptions=T

" 关闭闪烁和错误响声
set vb t_vb=

" 在编辑过程中，在右下角显示光标位置的状态行
set ruler

" 查询时非常方便，如要查找book单词，当输入到/b时，会自动找到第一
" 个b开头的单词，当输入到/bo时，会自动找到第一个bo开头的单词，依
" 次类推，进行查找时，使用此设置会快速找到答案，当你找要匹配的单词
" 时，别忘记回车
set noincsearch

" 高亮查询结果
set hlsearch

" 不产生备份文件
set nobackup

" 使用的换行符类型
set fileformat=unix
set fileformats=unix

" 设置鼠标模式
set mouse=h

" :make 的时候自动保存
set autowrite

" 重新编辑文件的时，光标定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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

" 命令行模式下，进入 popup menu 补全选择时，使用 enter 进行选择，而不是直接执行
" nvim 5.0 Pre-release <C-e> 快捷键在 Mac 上有 bug，表现与 Linux 上不一致
cnoremap <expr> <cr> pumvisible() ? "\<C-e>" : "\<CR>"
" TODO: <C-c> 取消 popup menu 选择，不使用任何一个补全
" <C-k> 删除光标后面的所有字符
" https://stackoverflow.com/a/26310522
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

" 不显示 tabline
set showtabline=0

" 仅仅适用于 diff 模式的配置
if &diff
  set nocursorline
  set colorcolumn=
  set cmdheight=1
  set laststatus=1

  " vimdiff 折行
  au VimEnter * if &diff | execute 'windo set wrap' | endif

  " vim-cpp-enhanced-highlight 配置
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_posix_standard = 1
  let g:cpp_experimental_simple_template_highlight = 1
  " let g:cpp_experimental_template_highlight = 1
  let g:cpp_concepts_highlight = 1
else  " 仅仅适用于 !diff 模式的配置
  autocmd FileType c,cpp set colorcolumn=81
  set cmdheight=2
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

  " vim-airline 配置
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

  " Windows 部分字体不能显示 Ɇ 这个字符，可以改成 ∄ Ø
  " https://github.com/vim-airline/vim-airline/issues/1729
  " https://github.com/vim-airline/vim-airline/issues/1374
  " if !exists('g:airline_symbols')
  "   let g:airline_symbols = {}
  " endif
  " let g:airline_symbols.notexists = '∄'

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

  " 自定义命令：Ctags 生成 tags 文件
  func! Ctags()
    exec '! ctags -R --c++-kinds=+pxI --fields=+niazS --extras=+q --exclude="*.json" --exclude="*.md" --exclude="*.html" --exclude="*.log" --exclude="*.make" --exclude="*.txt" --exclude="*.cmake" -o .tags'
  endfunc

  set cscopetag     " 如果 tags 跳转存在多个选项，则显示列表，无则直接跳转
  set tags=./.tags;,.tags
  if !exists(':Ctags')
    command! Ctags call Ctags()
  endif

  " 高亮光标所在位置的单词，并输入全文替换的命令，替换单词代填充
  nmap <leader>rp #<S-N>:%s/<C-R>=expand("<cword>")<CR>//g<Left><Left>

  nmap <silent><leader>x :silent! bdelete<CR>



  " 用两个 nvim 打开同一个文件会 coredump，关闭 swapfile 或者启动的时候不启用 coc
  " https://github.com/neoclide/coc.nvim/issues/1383
  let g:coc_start_at_startup = 0
  " 判断 exists 是为了在没有安装 Coc 的时候不报错
  autocmd VimEnter * if exists(':CocStart') | execute 'CocStart' | endif

  " coc.nvim 配置, vimdiff 模式下不加载
  " if hidden is not set, TextEdit might fail.
  set hidden

  " Some servers have issues with backup files, see #649
  set nobackup
  set nowritebackup

  " Better display for messages
  " set cmdheight=2

  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif

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

  " 类似 IDE 函数体 {} 自动缩进
  function! FunctionBracketAutoIndent()
    if col('.') > 1
      " TODO(shenyu): trim 空格，判断是否最后一个字符为 }
      let l:next_char = getline('.')[col('.')-1]
      if l:next_char == '}'
        return "\<cr>\<Esc>ko"
      endif
    endif
    return "\<C-g>u\<CR>"
  endfunction

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    inoremap <expr> <cr> pumvisible() && coc#_selected() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

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
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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

  " coc-lists 配置
  " -A : 自动预览模式
  " --number-select : 显示行号, 也可以用行号选择
  " --normal : normal 模式
  " -I : interactive 模式
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

  " 自定义的 grep 命令，支持目录补全
  command! -nargs=+ -complete=dir CocListGrep exe 'CocList --normal grep '.<q-args>
  nnoremap <space>g :<C-u>CocListGrep 
  nnoremap <space>G :<C-u>CocListGrep -i 
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


  " vim-commentary 配置
  autocmd FileType c,cpp setlocal commentstring=//%s

  " 关闭 netrw, neovim 使用 X11 forwarding 时会卡顿
  " neovim 5.0 已经解决这个问题
  " https://github.com/neovim/neovim/issues/6048
  " https://github.com/neovim/neovim/issues/11089
  "
  " if has("nvim") && !empty($DISPLAY)
  "   let g:loaded_netrwPlugin = 1
  " endif


  " 同步 ssh 连接的 vim 剪切板到本地
  " https://lotabout.me/2019/Integrate-clipboard-with-SSH/
  "
  if has("nvim")
    " if executable('clipboard-provider')
    "   let g:clipboard = {
    "         \ 'name': 'myClipboard',
    "         \     'copy': {
    "         \         '+': 'clipboard-provider copy',
    "         \         '*': 'env COPY_PROVIDERS=tmux clipboard-provider copy',
    "         \     },
    "         \     'paste': {
    "         \         '+': 'clipboard-provider paste',
    "         \         '*': 'env COPY_PROVIDERS=tmux clipboard-provider paste',
    "         \     },
    "         \ }
    " endif

    " Mac 上 XQuartz 有 bug，不能同步 clipboard，只能同步
    " primary，所以配置成都走 primary
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
    " 所有赋值操作都同步至 primary 剪切板
    " set clipboard+=unnamedplus
  else
    " :help clipboard-autoselect
    set clipboard=unnamed
  endif

  " go 自动 import 用到的 package
  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

  " asynctasks 配置
  " let g:asynctasks_config_name = '.git/tasks.ini'
  let g:asyncrun_open = 10
  let g:asynctasks_term_pos = 'tab'
  let g:asynctasks_term_rows = 10
  let g:asynctasks_term_reuse = 1
  let g:asynctasks_term_focus = 1
  let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']

  " au FileType qf setlocal signcolumn=no  " quickfix 窗口不显示符号列

  " https://vi.stackexchange.com/a/15699
  let g:asyncrun_status = 'stopped'
  function! AsyncrunGetStatus() abort
    return get(g:, 'asyncrun_status', '')
  endfunction
  silent! call airline#parts#define_function('asyncrun_status', 'AsyncrunGetStatus')
  silent! let g:airline_section_x = airline#section#create_right(['bookmark', 'tagbar', 'vista', 'gutentags', 'gen_tags', 'omnisharp', 'grepper', 'asyncrun_status', 'filetype'])

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
      echohl ErrorMsg
      echo "Location List is Empty."
      return
    endif
    " exec('topleft '.string(g:asyncrun_open).a:pfx.'open')
    exec(string(g:asyncrun_open).a:pfx.'open')
    exec('$')
    wincmd p
  endfunction

  " nmap <silent> <space>l :call ToggleList("Location List", 'l')<CR>
  nmap <silent> <space>q :call ToggleList("Quickfix List", 'c')<CR>

  nmap <silent> <leader>q :AsyncStop<CR>
  nmap <silent> <M-b> :AsyncTask build<CR>
  nmap <silent> <M-r> :AsyncTask run<CR>

  " press <esc> to cancel.
  nmap f <Plug>(coc-smartf-forward)
  nmap F <Plug>(coc-smartf-backward)
  nmap ; <Plug>(coc-smartf-repeat)
  nmap , <Plug>(coc-smartf-repeat-opposite)

  augroup Smartf
    autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
    autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
  augroup end

  " coc-dictionary
  " https://vim.fandom.com/wiki/Dictionary_completions
  set dictionary+=~/.vim/dic.txt

  " vim-lua-foramt
  autocmd FileType lua nnoremap <buffer> <silent><leader>f :call LuaFormat()<CR>
  autocmd BufWrite *.lua call LuaFormat()

  " vim-go
  let g:go_highlight_extra_types = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_types = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_function_parameters = 1
  let g:go_highlight_variable_declarations = 1
  let g:go_highlight_variable_assignments = 1

  let g:go_gopls_enabled = 0
  let g:go_code_completion_enabled = 0
  let g:go_fmt_autosave = 0  " 关闭保存文件时自动 fmt 文件
  let g:go_def_mapping_enabled = 0  " 关闭跳转快捷键 gd
  let g:go_doc_keywordprg_enabled = 0  " 关闭查看文档快捷键 K
  let g:go_get_update = 0  " 关闭自动更新依赖
  let g:go_echo_go_info = 0  " 关闭代码补全后的识别信息提示"

  " vim-markdown 配置
  " 兼容 github 默认识别 protobuf 高亮 Protobuf code, 而 vim 识别 proto
  " 高亮 bash code, vim 识别 sh 
  let g:vim_markdown_fenced_languages = ['protobuf=proto', 'bash=sh']

  " vim-codefmt 配置
  augroup autoformat_settings
    autocmd FileType proto,arduino AutoFormatBuffer clang-format
  augroup END
endif

" riv 配置
let g:riv_highlight_code = 'lua,python,cpp,javascript,vim,sh,proto,c'
" 处理 回车键绑定其他操作导致补全操作不符合期望的问题
autocmd FileType rst iunma <silent><buffer> <cr>
