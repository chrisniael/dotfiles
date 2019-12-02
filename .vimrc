" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'tpope/vim-fugitive'
" Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
" set rtp+=/usr/local/opt/fzf  " If fzf installed using Homebrew
Plug 'junegunn/fzf.vim'  " install fzf in system: pacman -S fzf
Plug 'rking/ag.vim'

" Initialize plugin system
call plug#end()

"let g:python3_host_prog = '/usr/local/bin/python3'

set t_Co=256
syntax enable  " 语法高亮
colorscheme default
set background=light  " 背景使用白色（很多主题颜色会改变背景颜色，建议在 colorscheme 之后修改）
set number

" 设置Backspace模式
set backspace=indent,eol,start


" 列标记颜色，与 colorcolumn 配置对应
highlight ColorColumn cterm=bold ctermbg=233

" 当前光标所在行颜色，与 cursorline 配置对应
highlight CursorLine cterm=bold ctermbg=233
" 当前光标所在列颜色，与 cursorcolum 配置对应
highlight CursorColumn cterm=bold ctermbg=233

" 搜索高亮的颜色
highlight Search ctermfg=0 ctermbg=11
highlight MatchParen ctermfg=0 ctermbg=11

" 其他行号颜
highlight LineNr ctermfg=240 ctermbg=233
" 当前行号颜色
highlight CursorLineNr cterm=bold ctermfg=250 ctermbg=233

" 选项窗口颜色
highlight Pmenu ctermfg=0 ctermbg=250
highlight PmenuSel ctermfg=0 ctermbg=4
highlight PmenuSbar ctermbg=250
highlight PmenuThumb ctermbg=255

" 错误提示颜色
highlight Error ctermfg=15 ctermbg=1
highlight SpellBad ctermfg=255 ctermbg=1
highlight SignColumn ctermfg=240 ctermbg=233

" 选择块颜色
highlight Visual cterm=bold ctermbg=236

" 特殊字符颜色
highlight NonText ctermfg=240
highlight SpecialKey ctermfg=240

" 差异比较颜色
highlight DiffAdd ctermfg=0 ctermbg=81
highlight DiffChange ctermfg=0 ctermbg=225
highlight DiffDelete ctermfg=0 ctermbg=236
highlight DiffText cterm=NONE ctermfg=0 ctermbg=9

" 折叠框颜色
highlight Folded ctermfg=0 ctermbg=250
highlight FoldColumn ctermfg=0 ctermbg=250

" 垂直分隔线颜色
highlight VertSplit ctermfg=234


" powerline 配置
let g:powerline_pycmd="py3"
set rtp+=/usr/lib/python3.8/site-packages/powerline/bindings/vim
" set laststatus=2
" set showtabline=2
set noshowmode


" 设置垂直分隔符号
set fillchars+=vert:\ 

if &diff
  set nocursorline
  set colorcolumn=
  set signcolumn=no
  set cmdheight=1
  set laststatus=2
  set showtabline=1
else
  set cursorline
  set colorcolumn=81
  set signcolumn=yes
  set cmdheight=2
  set laststatus=2
  set showtabline=2
endif

" 折行
set wrap

" 设置Backspace模式
set backspace=indent,eol,start

" 启动vim时不自动折叠代码
set foldmethod=syntax
set foldlevel=100

" 不显示折叠列标记
set foldcolumn=0

" 帮助显示中文
set helplang=cn

" 缓冲区内容的编码，与系统当前locale相同
set encoding=utf-8
" 读取/写入文件的编码
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
" 输出到终端内容的编码
set termencoding=utf-8

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

" GoLang 缩进符用 Tab
autocmd BufNewFile,BufRead *.go setlocal tabstop=4 shiftwidth=4

" 设置匹配模式，例如当光标位于一个左括号上时，会高亮相应的那个右括号
set showmatch

" 去除GUI版本中的toolbar
"set guioptions=T

" 关闭错误响声
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

" 输出到终端的编码方式
set termencoding=utf-8

" 缓冲区文本的编码方式
set encoding=utf-8

" 写入文件时采用的编码方式
set fileencoding=utf-8
set fileencodings=utf-8

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

map <C-N> :cnext<CR>
map <C-P> :cprevious<CR>

" 自定义命令：Ctags 生成 tags 文件
func! Ctags()
    exec '! ctags -R --c++-kinds=+pxI --fields=+niazS --extras=+q --exclude="*.json" --exclude="*.md" --exclude="*.html" --exclude="*.log" --exclude="*.make" --exclude="*.txt" --exclude="*.cmake" -o .tags'
endfunc

set cscopetag     " 如果 tags 跳转存在多个选项，则显示列表，无则直接跳转
set tags=./.tags;,.tags
if !exists(':Ctags')
    command! Ctags call Ctags()
endif


" 一键编译
func! CompileGcc()
	exec "w"
	let compilecmd="!gcc -std=c++2a -pthread -g"
	let compileflag="-o %<.out 2> .%<.err"
	exec compilecmd." % ".compileflag
	exec "cfile .%<.err"
endfunc

func! CompileGpp()
	exec "w"
	let compilecmd="!g++ -std=c++2a -pthread -g -fno-elide-constructors"
	let compileflag="-o %<.out 2> .%<.err"
	exec compilecmd." % ".compileflag
	exec "cfile .%<.err"
endfunc

func! RunPython()
	exec "w"
	exec "!python %"
endfunc

func! CompileJava()
	exec "w"
	exec "!javac %"
endfunc

func! RunShell()
	exec "w"
	exec "!bash %"
endfunc

func! RunLua()
	exec "w"
	exec "!lua %"
endfunc

func! CompileCode()
	exec "w"
	if &filetype == "cpp"
		exec "call CompileGpp()"
	elseif &filetype == "cc"
		exec "call CompileGpp()"
	elseif &filetype == "c"
		exec "call CompileGcc()"
	elseif &filetype == "python"
		exec "call RunPython()"
	elseif &filetype == "java"
		exec "call CompileJava()"
	elseif &filetype == "sh"
		exec "call RunShell()"
	elseif &filetype == "lua"
		exec "call RunLua()"
	endif
endfunc

func! RunResult()
	exec "w"
	if &filetype == "cpp"
		exec "! ./%<.out"
	elseif &filetype == "cc"
		exec "! ./%<.out"
	elseif &filetype == "c"
		exec "! ./%<.out"
	elseif &filetype == "python"
		exec "call RunPython()"
	elseif &filetype == "java"
		exec "!java %<"
	elseif &filetype == "sh"
		exec "call RunShell()"
	elseif &filetype == "lua"
		exec "call RunLua()"
	endif
endfunc

map <Leader>j :call CompileCode()<CR>
map <Leader>k :call RunResult()<CR>


" 高亮光标所在位置的单词，并输入全文替换的命令，替换单词代填充
nmap <Leader>r #<S-N>:%s/<C-R>=expand("<cword>")<CR>//g<Left><Left>

nmap <silent><Leader>f :Files<CR>
nmap <silent><Leader>b :Buffers<CR>

" 高亮光标所在位置的单词，并使用 Ag 来搜索
nmap <Leader>s :Ag <C-R>=expand("<cword>")<CR> 

autocmd FileType c,cpp nmap <silent><Leader>a :call CurtineIncSw()<CR>
autocmd FileType c,cpp imap <silent><Leader>a <ESC><Leader>a

nmap <silent><Leader>x :bdelete<CR>












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

" always show signcolumns
" set signcolumn=yes

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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

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
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>



function! s:EditAlternate()
    let l:alter = CocRequest('clangd', 'textDocument/switchSourceHeader', {'uri': 'file://'.expand("%:p")})
    " remove file:/// from response
    let l:alter = substitute(l:alter, "file://", "", "")
    execute 'edit ' . l:alter
endfunction
autocmd FileType c,cpp nmap <leader>a :call <SID>EditAlternate()<CR>


" vim-airline 配置
" 设置为双字宽显示，否则无法完整显示如:☆
" set ambiwidth=double
" 总是显示状态栏 
" let laststatus = 2
let g:airline_powerline_fonts = 1   " 使用powerline打过补丁的字体
let g:airline_theme="dark"      " 设置主题
" 开启tabline
let g:airline#extensions#tabline#enabled = 1      "tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '   "tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'      "tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1 
" 映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>


" ag 配置
" 不自动跳转到第一个搜索结果
cnoreabbrev Ag Ag!
