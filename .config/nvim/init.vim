"----------------------------------------------------------------------
" vim-plugin 插件列表
" https://github.com/junegunn/vim-plug
" Avoid using standard Vim directory names like 'plugin'
"----------------------------------------------------------------------
" Linux/Unix: ~/.local/share/nvim/plugged
call plug#begin()

" 加快 git difftool 打开速度
if !&diff
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-commentary'
  "" Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }
  Plug 'MTDL9/vim-log-highlighting', { 'for': ['log'] }
  Plug 'tpope/vim-obsession'
  Plug 'skywind3000/asynctasks.vim'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'skywind3000/vim-terminal-help'
  Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
  Plug 'airblade/vim-rooter'
  Plug 'voldikss/vim-floaterm'
  Plug 'fatih/vim-go', { 'for': ['go', 'gomod'] }
  Plug 'sebdah/vim-delve', { 'for': ['go'] }
endif
Plug 'chrisniael/gruvbox.nvim'
"" Plug 'gu-fan/riv.vim'
Plug 'cespare/vim-toml', { 'for': ['toml'] }
Plug 'chrisniael/rsi.vim'
Plug 'tpope/vim-sleuth'
"" Plug 'wincent/terminus'
Plug 'honza/vim-snippets'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'LunarWatcher/auto-pairs'

" Initialize plugin system
call plug#end()


"----------------------------------------------------------------------
" coc.nvim 插件列表
"----------------------------------------------------------------------
let g:coc_global_extensions = [
      \ 'coc-yank',
      \ 'coc-lists',
      \ 'coc-emoji',
      \ 'coc-tasks',
      \ 'coc-git',
      \ 'coc-highlight',
      \ 'coc-clangd',
      \ 'coc-cmake',
      \ 'coc-rust-analyzer',
      \ 'coc-json',
      \ 'coc-pyright',
      \ 'coc-sumneko-lua',
      \ 'coc-vimlsp',
      \ 'coc-html',
      \ 'coc-yaml',
      \ 'coc-go',
      \ 'coc-phpactor',
      \ 'coc-db',
      \ 'coc-sh',
      \ 'coc-tsserver',
      \ 'coc-explorer',
      \ 'coc-snippets',
      \ ]


"----------------------------------------------------------------------
" 适用于 diff 与 非 diff 模式的配置
"----------------------------------------------------------------------
filetype plugin indent on

" 显示标题
set title

" 设置 gruvbox 主题 contrast 程度 (得放在 colorscheme 设置之前)
" soft, medium (default), hard
" let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_contrast_light = 'hard'

" 设置 grubbox 主题支持粗体与斜体
" Windows 上部分字体斜体会有显示残留问题
" https://github.com/equalsraf/neovim-qt/issues/812
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1

" 支持 xterm-256color
set t_Co=256

" 语法高亮
syntax enable

" 背景颜色, dark(default), light
set background=dark

" 没有安装 gruvbox 插件的时候不报错
silent! colorscheme gruvbox

" Popup Menu 选择框颜色
highlight CocMenuSel ctermbg=237 guibg=#13354A

" 透明背景
" highlight Normal ctermbg=NONE guibg=NONE
" highlight NonText ctermbg=NONE guibg=NONE

" 显示行号
set number

" 状态栏行数
set laststatus=2

" 开启 true color
" - 不支持 true color 的 terminal : macOS Terminal
" - 支持 true color 的 terminal : iTerm2, Mintty, PuTTY
" 暂时没有很好的方法判断 terminal 是否支持 true color
" 暂时这样配置兼容 macOS 上的 Terminal 和 iTerm2
" remote ssh 至 macOS 时, 不存在 COLORTERM 这个环境变量
" if has("mac")
"   if $COLORTERM == 'truecolor'
"     set termguicolors
"   endif
" else
"   set termguicolors
" endif
if $TERM_PROGRAM != "Apple_Terminal"
  set termguicolors
endif

" 光标所在行突出显示
set cursorline

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
endif

" guifont 仅仅影响 vim-gui, 不影响 neovim-qt
if has("win32")
  silent! set guifont=Hack\ Nerd\ Font\ Mono:h11
  silent! set guifontwide=Microsoft\ YaHei\ UI:h11
endif

" 关闭错误响声
set novisualbell

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


" windows 上新建 go 相关文件使用 \n 作为换行符
autocmd! BufNewFile *.go,go.mod,go.sum,go.work,go.work.sum setlocal fileformat=unix


" 禁用鼠标
set mouse=

" :make 的时候自动保存
set autowrite

" 编辑文件的时, 光标定位到上一次编辑的位置
" gitcommit 文件除外
autocmd BufReadPost * if &filetype != 'gitcommit' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" go 语法高亮
" let g:go_highlight_extra_types = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_types = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_function_parameters = 1
" let g:go_highlight_variable_declarations = 1
" let g:go_highlight_variable_assignments = 1

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
if has("win32")
  nnoremap <C-z> <nop>
  inoremap <C-z> <nop>
  vnoremap <C-z> <nop>
  snoremap <C-z> <nop>
  xnoremap <C-z> <nop>
  cnoremap <C-z> <nop>
  onoremap <C-z> <nop>
endif

" C-l 刷新时顺带消除搜索高亮
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Terminal 模式使用 Esc 切换 Normal 模式, 存在一定问题, 例如在 Terminal 中再打开 vim
" tnoremap <Esc> <C-\><C-n>
tnoremap <C-o> <C-\><C-n>

" 粘贴快捷键
inoremap <C-v> <C-r>*
cnoremap <C-v> <C-r>*

" 同步 ssh 连接的 vim 剪切板到本地
" https://lotabout.me/2019/Integrate-clipboard-with-SSH/
" if !has("win32") && !empty($SSH_CONNECTION)
"   let g:clipboard = {
"     \   'name': 'xclip-clipboard',
"     \   'copy': {
"     \      '+': 'xclip -i -selection clipboard',
"     \      '*': 'xclip -i -selection clipboard',
"     \    },
"     \   'paste': {
"     \      '+': 'xclip -o -selection clipboard',
"     \      '*': 'xclip -o -selection clipboard',
"     \   },
"     \   'cache_enabled': 0,
"     \ }
" endif

" 所有复制操作都同步至 clipboard 剪切板 +
if has('nvim')
  set clipboard+=unnamedplus
else
  set clipboard=unnamed
endif

" windows 上使用 powershell 作为默认 shell
" if has("win32")
"   let &shell='pwsh.exe'
"   let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
"   let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
"   let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
"   set shellquote= shellxquote=
" endif

" windows 上使用 cmd 作为默认 shell
" 比如从 git-bash 打开 nvim，会使用当前环境变量 SHELL 的值作为 nvim 的 shell，而 git-bash 在 nvim 中使用有一些问题
if has("win32")
  let &shell='cmd.exe'
  let &shellcmdflag = '/s /c'
  let &shellredir = '>%s 2>&1'
  let &shellpipe = '>%s 2>&1'
  let &shellslash = 0
  let &shelltemp = 1
  let &shellxquote = '"'
  set shellquote= shellxescape=
endif



" Windows 非远程登录使用 cmd 作为默认 shell
" if has("win32") && !empty($SSH_CONNECTION)
"   let &shell='cmd'
" endif

" popup-menu and float window 透明
" set pumblend=10
" set winblend=10
" highlight PmenuSel blend=0



"----------------------------------------------------------------------
" riv.vim 配置
" https://github.com/gu-fan/riv.vim
"----------------------------------------------------------------------
" let g:riv_highlight_code = 'lua,python,cpp,javascript,vim,sh,proto,c'
" 处理回车键绑定其他操作导致补全操作不符合期望的问题
" autocmd FileType rst iunma <silent><buffer> <CR>


"----------------------------------------------------------------------
" coc-go 配置
" https://github.com/josa42/coc-go
"----------------------------------------------------------------------
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')


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
" auto-pairs 配置
" https://github.com/LunarWatcher/auto-pairs
" 默认的快捷键前缀是 <C-p> 与 Popup Menu 选择键冲突，这里关闭所有快捷键
let g:AutoPairsShortcutIgnore = ""
let g:AutoPairsShortcutJump = ""
let g:AutoPairsShortcutToggleMultilineClose = ""
let g:AutoPairsShortcutToggle = ""
let g:AutoPairsMoveExpression = ""
" 自动删除配对的符号
let g:AutoPairsMapBS = 1

"----------------------------------------------------------------------
" 仅仅用于 diff 模式的配置
"----------------------------------------------------------------------
if &diff
  " 不使用特定列高亮标记
  set colorcolumn=

  " 命令行高度
  set cmdheight=1

  " 在状态栏显示文件信息 (:file)
  set shortmess-=F

  " vimdiff 折行
  au VimEnter * execute 'windo set wrap'


"----------------------------------------------------------------------
" 仅仅用于非 diff 模式的配置
"----------------------------------------------------------------------
else
  " Make vim highlight the current line on only the active buffer
  " https://stackoverflow.com/a/12018552
  " augroup CursorLine
  "   au!
  "   au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  "   au WinLeave * setlocal nocursorline
  " augroup END

  autocmd FileType c,cpp set colorcolumn=81

  " 不折行
  " autocmd FileType markdown set nowrap
  " 折行
  set wrap

  " 打开 terminal 时关闭行号和符号列, 并自动进入 insert 模式
  " 退出 terminal: <C-\><C-n>
  if has('nvim')
    autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no | startinsert
  endif

  map <C-n> :cnext<CR>
  map <C-p> :cprevious<CR>

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

  " 高亮光标所在位置的单词, 并输入全文替换的命令, 替换单词代填充
  nmap <Leader>rp #<S-N>:%s/<C-r>=expand("<cword>")<CR>//g<Left><Left>

  " \-x 关闭 buf
  nmap <silent><Leader>x :silent! bdelete<CR>

  "----------------------------------------------------------------------
  " vim-airline, vim-airline-theme 配置
  " - https://github.com/vim-airline/vim-airline
  " - https://github.com/vim-airline/vim-airline-themes
  "----------------------------------------------------------------------
  " set laststatus=2  " 底部显示状态栏, 1:不显示, 2:显示
  let g:airline_powerline_fonts = 0   " 使用 powerline 符号
  let g:airline_symbols_ascii = 0

  " powerline symbols
  " let g:airline_left_sep = ''
  " let g:airline_left_alt_sep = ''
  " let g:airline_right_sep = ''
  " let g:airline_right_alt_sep = ''

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
  if has("win32")
    " Windows Terminal 暂时不支持 FocusGained 事件，在 nvim-qt 中依然开启
    let g:gitgutter_terminal_reports_focus=0
  endif


  "----------------------------------------------------------------------
  " coc.nvim 配置
  " https://github.com/neoclide/coc.nvim
  "----------------------------------------------------------------------
  " Disabled completion sources
  autocmd BufEnter * let b:coc_disabled_sources = ['around', 'buffer', 'file']
  " May need for vim (not neovim) since coc.nvim calculate byte offset by count
  " utf-8 byte sequence.
  set encoding=utf-8
  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: There's always complete item selected by default, you may want to enable
  " no select by `"suggest.noselect": true` in your configuration file.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  " inoremap <silent><expr> <TAB>
  "       " \ coc#pum#visible() ? coc#_select_confirm() :
  "       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  "       \ "\<Tab>"
  " inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Jump snippet placeholders
  let g:coc_snippet_next = '<TAB>'
  let g:coc_snippet_prev = '<S-TAB>'

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  let g:AutoPairsMapCR = 0
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() :
        \ pumvisible() ? "\<C-y>" :
        \ "\<C-g>u\<CR>\<Plug>AutoPairsReturn"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent! call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <Leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <Leader>f  <Plug>(coc-format-selected)
  " nmap <Leader>f  <Plug>(coc-format-selected)
  nmap <Leader>f <Plug>(coc-format)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<Leader>aap` for current paragraph
  xmap <Leader>a  <Plug>(coc-codeaction-selected)
  nmap <Leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <Leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <Leader>qf  <Plug>(coc-fix-current)

  " Run the Code Lens action on the current line.
  nmap <Leader>cl  <Plug>(coc-codelens-action)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  if has("nvim-0.4.0") || has("patch-8.2.0750")
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocActionAsync('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <Space>a  :<C-u>CocList diagnostics<CR>
  " Manage extensions.
  " nnoremap <silent><nowait> <Space>e  :<C-u>CocList extensions<CR>
  " Show commands.
  nnoremap <silent><nowait> <Space>c  :<C-u>CocList commands<CR>
  " Find symbol of current document.
  nnoremap <silent><nowait> <Space>o  :<C-u>CocList outline<CR>
  " Search workspace symbols.
  nnoremap <silent><nowait> <Space>s  :<C-u>CocList -I symbols<CR>
  " Do default action for next item.
  nnoremap <silent><nowait> <Space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <Space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <Space>p  :<C-u>CocListResume<CR>

  " 开启 semantic highlighting 支持
  " https://github.com/clangd/coc-clangd/issues/217#issuecomment-898130176
  " let g:coc_default_semantic_highlight_groups = 1

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

  nnoremap <Space>w :<C-u>CocList -I --ignore-case words<CR>
  " 在当前 buffer 中搜索光标所在单词
  nnoremap <Leader>w :<C-u>CocList -I --normal --input=<C-r>=expand('<cword>')<CR> words<CR>
  " 在当前 buffer 中搜索 visual 模式选择的文本
  vnoremap <Leader>w :<C-u>call <SID>WordsFromSelected(visualmode())<CR>

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
    execute 'CocList -I --normal --input='.word.' words'
  endfunction

  " 文件列表
  nnoremap <silent> <Space>f :<C-u>CocList files<CR>

  " Buffer 列表
  nnoremap <silent> <Space>b :<C-u>CocList buffers<CR>

  " 自定义的 grep 命令, 支持目录补全
  function! s:CocListGrep(case_ignore, args)
    let case_arg = ''
    if a:case_ignore == 1
      let case_arg = ' -i'
    endif
    if strlen(a:args) <= 0
      let cmd = 'CocList grep' . case_arg
      echomsg cmd
      execute cmd
    else
      exec 'CocList --normal grep' . case_arg . ' ' .a:args
    endif
  endfunction

  command! -nargs=* -complete=dir CocListGrep :call s:CocListGrep(0, <q-args>)
  command! -nargs=* -complete=dir CocListGrepCaseIgnore :call s:CocListGrep(1, <q-args>)
  nnoremap <Space>g :<C-u>CocList -I grep -i<CR>
  nnoremap <Space>G :<C-u>CocList -I grep<CR>
  " Grep 光标所在单词
  nnoremap <Leader>g :<C-u>CocList grep -i <C-r>=expand('<cword>')<CR><CR>
  nnoremap <Leader>G :<C-u>CocList grep <C-r>=expand('<cword>')<CR><CR>
  " Grep visual 模式选择的文本
  vnoremap <Leader>g :<C-u>call <SID>GrepFromSelectedIgnoreCase(visualmode())<CR>
  vnoremap <Leader>G :<C-u>call <SID>GrepFromSelected(visualmode())<CR>

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
    execute 'CocList grep '.word
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
    execute 'CocList grep -i '.word
  endfunction

  " 历史剪切板列表
  nnoremap <silent> <Space>y  :<C-u>CocList -A yank<CR>


  "----------------------------------------------------------------------
  " vim-commentary 配置
  " https://github.com/tpope/vim-commentary
  "----------------------------------------------------------------------
  autocmd FileType c,cpp setlocal commentstring=//%s
  autocmd FileType proto setlocal commentstring=//%s


  "----------------------------------------------------------------------
  " netrwPlugin 配置
  " https://github.com/vim/vim/blob/master/runtime/plugin/netrwPlugin.vim
  "----------------------------------------------------------------------
  " 关闭 netrw, neovim 使用 X11 forwarding 时会卡顿
  " neovim 5.0 已经解决这个问题
  " - https://github.com/neovim/neovim/issues/6048
  " - https://github.com/neovim/neovim/issues/11089
  " if !empty($DISPLAY)
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

  au FileType qf setlocal signcolumn=no  " quickfix 窗口不显示符号列
  au FileType qf setlocal nonumber  " quickfix 窗口不显示行号

  " https://vi.stackexchange.com/a/15699
  " let g:asyncrun_status = 'stopped'
  " function! AsyncrunGetStatus() abort
  "   return get(g:, 'asyncrun_status', '')
  " endfunction
  " silent! call airline#parts#define_function('asyncrun_status', 'AsyncrunGetStatus')
  " silent! let g:airline_section_x = airline#section#create_right(['bookmark', 'tagbar', 'vista', 'gutentags', 'gen_tags', 'omnisharp', 'grepper', 'asyncrun_status', 'filetype'])

  nnoremap <silent> <Space>t  :<C-u>CocList tasks<CR>

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

  " nmap <silent> <Space>l :call ToggleList("Location List", 'l')<CR>
  " nmap <silent> <Space>q :call ToggleList("Quickfix List", 'c')<CR>

  function! AsyncTaskRun()
    if &filetype == 'vim'
      source %
    else
      AsyncTask run
    endif
  endfunction

  nmap <silent> <Leader>q :AsyncStop<CR>
  nmap <silent> <M-b> :<C-u>AsyncTask build<CR>
  nmap <M-r> :call AsyncTaskRun()<CR>
  " autocmd FileType go nmap <M-t> :GoTestFunc -v<CR>


  "----------------------------------------------------------------------
  " vim-terminal-help 配置
  " https://github.com/skywind3000/vim-terminal-help
  "----------------------------------------------------------------------
  let g:terminal_cwd = 2 " project root
  let g:terminal_pos = 'top'
  let g:terminal_height = ''
  " if has("win32")
  "   let g:terminal_shell='pwsh'
  " endif


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
  " vim-markdown 配置
  " https://github.com/plasticboy/vim-markdown
  "----------------------------------------------------------------------
  " 兼容 github 默认识别 protobuf 高亮 Protobuf code, 而 vim 识别 proto
  " 高亮 bash code, vim 识别 sh
  let g:vim_markdown_fenced_languages = ['protobuf=proto', 'bash=sh']


  "----------------------------------------------------------------------
  " vim-rooter 配置
  " https://github.com/airblade/vim-rooter
  "----------------------------------------------------------------------
  let g:rooter_manual_only = 1

  " Vim 打开时将工作目录切换至工程目录
  " au VimEnter * if exists(":Rooter") | Rooter | endif


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
  " nnoremap <silent> <Leader>hl :Git pull<CR>
  " nnoremap <silent> <Leader>hh :Git push<CR>
  nnoremap <Leader>hd :<C-u>Gdiffsplit<CR>
  nnoremap <Leader>hh :<C-u>Git<CR>


  "----------------------------------------------------------------------
  " coc-git 配置
  " https://github.com/neoclide/coc-git
  "----------------------------------------------------------------------
  nnoremap <Space>h :<C-u>CocList --normal gstatus<CR>
  " navigate chunks of current buffer
  " nmap [c <Plug>(coc-git-prevchunk)
  " nmap ]c <Plug>(coc-git-nextchunk)
  " navigate conflicts of current buffer
  nmap [x <Plug>(coc-git-prevconflict)
  nmap ]x <Plug>(coc-git-nextconflict)
  " show chunk diff at current position
  " nmap <Leader>hp <Plug>(coc-git-chunkinfo)
  " show commit contains current position
  " nmap <Leader>hc <Plug>(coc-git-commit)
  " create text object for git chunks
  omap ig <Plug>(coc-git-chunk-inner)
  xmap ig <Plug>(coc-git-chunk-inner)
  omap ag <Plug>(coc-git-chunk-outer)
  xmap ag <Plug>(coc-git-chunk-outer)

  " nmap <Leader>hu :<C-u>CocCommand git.chunkUndo<CR>


  "----------------------------------------------------------------------
  " vim-go 配置
  " https://github.com/fatih/vim-go
  "----------------------------------------------------------------------
  let g:go_gopls_enabled = 0
  let g:go_code_completion_enabled = 0
  let g:go_fmt_command = 'gofmt'

  " 关闭保存文件时自动 fmt 文件
  let g:go_fmt_autosave = 0

  let g:go_imports_mode = 'goimports'
  let g:go_imports_autosave = 0

  " 关闭跳转快捷键 gd
  let g:go_def_mapping_enabled = 0

  " 关闭查看文档快捷键 K
  let g:go_doc_keywordprg_enabled = 0

  " 关闭自动更新依赖
  " let g:go_get_update = 0

  " 关闭代码补全后的识别信息提示"
  let g:go_echo_go_info = 0

  " 隐藏 fmt 错误提示
  let g:go_fmt_fail_silently = 1

  " go test 在 terminal 展示结果
  let g:go_term_enabled=0

  let g:go_list_type = 'quickfix'
  let g:go_list_height = 10
  let g:go_term_reuse = 1
  let g:go_term_close_on_exit = 0
  " let g:go_term_mode = 'botright vsplit'
  let g:go_term_enabled = 1
  let g:go_def_mode = 'godef'
  let g:go_referrers_mode = 'guru'
  let g:go_implements_mode = 'guru'
  let g:go_rename_command = 'gorename'
  let g:go_test_timeout= '300s'

  " 运行测试用例函数快捷键
  nmap <silent> <M-t> :<C-u>GoTestFunc<CR>
  " 运行调试
  nmap <silent> <M-d> :<C-u>GoDebugStart<CR>
  " Go delve stepout"
  nmap <silent> <S-F11> :<C-u>GoDebugStepOut<CR>

  "----------------------------------------------------------------------
  " coc-explorer 配置
  " https://github.com/weirongxu/coc-explorer
  "----------------------------------------------------------------------
  nmap <space>e <Cmd>CocCommand explorer<CR>

  "----------------------------------------------------------------------
  " vim-oscyank 配置
  " https://github.com/ojroques/vim-oscyank
  "----------------------------------------------------------------------
  " 当 clipboard providor 不存在时，使用 osc52 复制内容，:checkhealth 查看 clipboard providor
  " Wayland 桌面安装了 wl-clipboard 情况下，本地打开 nvim，不会使用 osc52
  " ssh 到 linux 上，打开 nvim，则会使用 osc52 复制内容
  if has('nvim') && !has('clipboard') || !has('nvim') && !has('clipboard_working')
    " In the event that the clipboard isn't working, it's quite likely that
    " the + and * registers will not be distinct from the unnamed register. In
    " this case, a:event.regname will always be '' (empty string). However, it
    " can be the case that `has('clipboard_working')` is false, yet `+` is
    " still distinct, so we want to check them all.
    let s:VimOSCYankPostRegisters = ['', '+', '*']
    function! s:VimOSCYankPostCallback(event)
        if a:event.operator == 'y' && index(s:VimOSCYankPostRegisters, a:event.regname) != -1
            call OSCYankRegister(a:event.regname)
        endif
    endfunction
    augroup VimOSCYankPost
        autocmd!
        autocmd TextYankPost * call s:VimOSCYankPostCallback(v:event)
    augroup END
  endif
endif
