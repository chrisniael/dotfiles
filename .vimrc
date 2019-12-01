set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'Shougo/echodoc.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'Yggdroot/indentLine'
" Plugin 'chrisniael/VimIM'
" Plugin 'DoxygenToolkit.vim'
Plugin 'rhysd/vim-clang-format'
" Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'fatih/vim-go'
" Plugin 'w0rp/ale'
Plugin 'tpope/vim-obsession'
Plugin 'junegunn/fzf.vim'  " install fzf in system: pacman -S fzf
Plugin 'ericcurtin/CurtineIncSw.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'rking/ag.vim'
Plugin 'MTDL9/vim-log-highlighting'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" YouCompleteMe config
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_auto_trigger=1
let g:ycm_show_diagnostics_ui=1
let g:ycm_enable_diagnostic_signs=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_min_num_identifier_candidate_chars=2
set completeopt=longest,menu
let g:ycm_add_preview_to_completeopt=0
let g:ycm_max_num_candidates=10
if &diff
  let g:ycm_show_diagnostics_ui=0
endif
let g:ycm_use_ultisnips_completer=0
let g:ycm_collect_identifiers_from_tags_files=0

let g:ycm_filetype_whitelist={'c':1, 'cpp':1, 'go':1}

" echodoc config
let g:echodoc#enable_at_startup=1
set noshowmode  " 不显示状态

" vim-cpp-enhanced-highlight config
"let g:cpp_class_scope_highlight=0
"let g:cpp_member_variable_highlight=0
"let g:cpp_class_decl_highlight=0
"let g:cpp_no_function_highlight=1

" indentLine config
let g:indentLine_color_term=240
let g:indentLine_char='│'
if &diff
  let g:indentLine_enabled = 0
endif

" VimIM config
let g:Vimim_cloud=-1
let g:Vimim_map='tab_as_gi'
let g:Vimim_punctuation=3
let g:Vimim_shuangpin=0

"  DoxygenToolkit.vim config
let g:DoxygenToolkit_versionTag="@version"
let g:DoxygenToolkit_versionString=""
let g:DoxygenToolkit_authorName="shenyu, shenyu@shenyu.me"
" 新建.h .cpp文件时自动插入作者信息
" autocmd! BufNewFile *.h,*.cpp exec "DoxAuthor"

" vim-clang-format config
let g:clang_format#auto_format=0
let g:clang_format#auto_format_on_insert_leave=0

" vim-commentary config
autocmd FileType c,cpp setlocal commentstring=//%s

" vim-go config
"let mapleader = ","
cnoreabbrev GoBuild GoBuild!
cnoreabbrev GoTest GoTest!
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(1, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(1)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" autocmd FileType go nmap <leader>b  :GoBuild<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  :GoTest<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
let g:go_test_timeout='10s'
let g:go_list_type="quickfix"
let g:go_highlight_types=1
let g:go_highlight_extra_types=1
let g:go_highlight_variable_declarations=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_auto_sameids=1
autocmd FileType go nmap <Leader>i <Plug>(go-info)
"let g:go_auto_type_info=1
"set updatetime=100
let g:go_null_module_warning=0


" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
  silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--exclude="*.json"']
let g:gutentags_ctags_extra_args += ['--exclude="*.md']
let g:gutentags_ctags_extra_args += ['--exclude="*.html"']
let g:gutentags_ctags_extra_args += ['--exclude="*.log"']
let g:gutentags_ctags_extra_args += ['--exclude="*.make"']
let g:gutentags_ctags_extra_args += ['--exclude="*.txt"']
let g:gutentags_ctags_extra_args += ['--exclude="*.cmake"']
" let g:gutentags_trace = 1
let g:gutentags_file_list_command = {
    \  'markers': {
         \  '.git': 'git ls-files',
         \  '.hg': 'hg files',
         \  }
    \  }

" ag config
" 不自动跳转到第一个搜索结果
cnoreabbrev Ag Ag!

" powerline config
let g:powerline_pycmd="py3"
set laststatus=2
set rtp+=/usr/lib/python3.8/site-packages/powerline/bindings/vim

set t_Co=256
syntax enable    " 语法高亮
colorscheme default
set background=light    " 背景使用白色（很多主题颜色会改变背景颜色，建议在 colorscheme 之后修改）

" 列标记颜色，与 colorcolumn 配置对应
highlight ColorColumn cterm=bold ctermbg=236

" 当前光标所在行颜色，与 cursorline 配置对应
highlight CursorLine cterm=bold ctermbg=236
highlight CursorColumn cterm=bold ctermbg=236

highlight Search ctermfg=0 ctermbg=11
highlight MatchParen ctermfg=0 ctermbg=11

" 行号颜色
highlight LineNr ctermfg=240
highlight CursorLineNr cterm=bold ctermfg=249

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

" 设置垂直分隔符号
set fillchars+=vert:\ 

" 突出显示当前行, 可能会导致光标移动时卡顿，不建议开启
if &diff
  set nocursorline
  set colorcolumn=
else
  set cursorline
  set colorcolumn=81
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
    exec '! ctags -R --c++-kinds=+px --fields=+niazS --extras=+q --tag-relative --exclude="*.json" --exclude="*.md" --exclude="*.html" --exclude="*.log" --exclude="*.make" --exclude="*.txt" --exclude="*.cmake" -o .tags'
endfunc

set cscopetag     " 如果 tags 跳转存在多个选项，则显示列表，无则直接跳转
set tags=./.tags;,.tags
if !exists(':Ctags')
    command! Ctags call Ctags()
endif

func! ShowInvisibles()
  let g:show_invisibles_state=1
  " 显示特殊字符
  set number
  "set list
  set listchars=tab:⇥\ ,eol:↲
  " set showbreak=>>>\ 
  " 初始化的时候 IndenetLine 插件还没加载，所以要判断一下
  if exists(':IndentLinesEnable')
    exec "IndentLinesEnable"
  endif
endfunc

func! ShowNoInvisibles()
  let g:show_invisibles_state=0
  set nonumber
  set nolist
  set showbreak=
  if exists(':IndentLinesDisable')
    exec "IndentLinesDisable"
  endif
endfunc

func! ShowInvisiblesToggle()
  if g:show_invisibles_state
    call ShowNoInvisibles()
  else
    call ShowInvisibles()
  endif
endfunc

call ShowInvisibles()
if !exists(':ShowInvisiblesToggle')
  command! ShowInvisiblesToggle call ShowInvisiblesToggle()
endif

" 一键编译
func! CompileGcc()
	exec "w"
	let compilecmd="!gcc -std=c++17 -pthread -g"
	let compileflag="-o %<.out 2> .%<.err"
	exec compilecmd." % ".compileflag
	exec "cfile .%<.err"
endfunc

func! CompileGpp()
	exec "w"
	let compilecmd="!g++ -std=c++17 -pthread -g -fno-elide-constructors"
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

if !exists(':Build')
    command! Build call CompileCode()
endif

if !exists(':Run')
  command! Run call RunResult()
endif

" 高亮光标所在位置的单词，并输入全文替换的命令，替换单词代填充
nmap <Leader>r #<S-N>:%s/<C-R>=expand("<cword>")<CR>//g<Left><Left>

autocmd FileType c,cpp nmap <Leader>g *<S-N>:YcmCompleter GoToDefinitionElseDeclaration<CR>
autocmd FileType c,cpp nmap <silent><leader>d :YcmDiags<CR>

nmap <silent><Leader>f :Files<CR>
nmap <silent><Leader>b :Buffers<CR>

" 高亮光标所在位置的单词，并使用 Ag 来搜索
nmap <Leader>s :Ag <C-R>=expand("<cword>")<CR> 

autocmd FileType c,cpp nmap <buffer><Leader>c :ClangFormat<CR>:w<CR>
autocmd FileType c,cpp vmap <buffer><Leader>c :ClangFormat<CR>:w<CR>
"autocmd FileType c,cpp ClangFormatAutoEnable

autocmd FileType c,cpp nmap <silent><Leader>a :call CurtineIncSw()<CR>
autocmd FileType c,cpp imap <silent><Leader>a <ESC><Leader>a

nmap <silent><Leader>x :bdelete<CR>

" ALE 配置
if &diff
  let g:ale_enabled = 0
else
  " let g:ale_c_parse_compile_commands = 1
  " let g:ale_linters = { 'cpp': ['cpplint', 'g++'], 'c': ['cpplint', 'gcc'] }
  let g:ale_linters = { 'cpp': ['cpplint'], 'c': ['cpplint'] }
  " let g:ale_set_loclist = 0
  " let g:ale_set_quickfix = 1
endif
