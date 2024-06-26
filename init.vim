set number relativenumber
set hidden
set termguicolors
" lock mark for `[` `]`
inoremap <C-s> <esc>:lockmark up<CR>
vnoremap <C-s> <esc>
nnoremap <C-s> :up<CR>
cnoremap <C-s> <esc>
nnoremap vb <C-v>
nnoremap vo :browse oldfile<CR>
nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>
nnoremap <C-a> ggVG
nnoremap <C-q> :bd<CR>
nnoremap <M-o> <C-i>
nnoremap <M-i> <C-o>
nnoremap <S-tab> <<
" tab before the first letter indent
nnoremap <expr> <tab> col('.') <= match(getline('.'), '\S') + 1 ? ">>" : "\<tab>"
vmap <tab> >gv
vmap <S-tab> <gv
inoremap <S-tab> <C-d>
omap <C-s> <esc>
nmap U u
command E e
command Q q
set tabstop=4 shiftwidth=4 expandtab
set backspace=indent,eol,start
set ignorecase
set smartcase
set mouse=a
set list listchars+=space:· listchars-=eol:$ listchars+=tab:>-
set nofixendofline
" restore file last edit location
augroup VimStartUp
    au!
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
augroup END
command CSpace :%s/\s\+$//e
" set and restore cursor shape
autocmd VimLeave,VimSuspend * set guicursor=a:ver25
cabbrev vhelp vertical help
cabbrev n noh
set scrolloff=2
set pumheight=20

call plug#begin()
" auto pair
Plug 'windwp/nvim-autopairs'
"Plug 'cohama/lexima.vim'
Plug 'kylechui/nvim-surround'
"Plug 'tpope/vim-surround'

" completion
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/nvim-cmp'
Plug 'zyd2001/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'scrooloose/nerdcommenter'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind.nvim'
" LSP manager
Plug 'williamboman/mason.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main', 'do': 'bash ~/.config/nvim/scripts/updateMaterialColor.sh' }
" show parentheses with color
Plug 'luochen1990/rainbow'
" show matching indent
Plug 'yggdroot/indentline'
" auto detect indent
Plug 'tpope/vim-sleuth'

" git
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'APZelos/blamer.nvim'

" debug
Plug 'puremourning/vimspector', { 'do': 'mkdir ./gadgets/linux/.gadgets.d/ -p && cp ~/.config/nvim/scripts/lldb-dap.json ./gadgets/linux/.gadgets.d/'}
"Plug 'mfussenegger/nvim-dap'
"Plug 'nvim-neotest/nvim-nio'
"Plug 'rcarriga/nvim-dap-ui'

" search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}

" enable clipboard
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

" session manager
Plug 'tpope/vim-obsession', { 'frozen': 1, 'do': 'bash ~/.config/nvim/scripts/updateObsession.sh' }

" buffer line
Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
" Plug 'ryanoasis/vim-devicons' Icons without colours
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

Plug 'nvim-tree/nvim-tree.lua'
"Plug 'preservim/nerdtree'

" lua definition for vim api
Plug 'folke/neodev.nvim'

Plug 'voldikss/vim-floaterm'
call plug#end()

" rainbow setting
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['#ffd700', '#da70d6', '#179fff'],
\   'operators':''
\}

" indentline setting
"let g:indentLine_setConceal = 0
let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0
let g:indentLine_showFirstIndentLevel=1

" colorscheme setting
"colorscheme onedark
let g:material_terminal_italics = 1
let g:material_theme_style='palenight'
colorscheme material
hi link markdownError NONE

" airline setting
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr= ''
let g:airline#extensions#branch#enabled = 1
" Enable the list of buffers
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#tab_nr_type = 1
"let g:airline#extensions#tabline#show_tab_nr = 1
"let g:airline#extensions#tabline#fnamecollapse = 2
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#tabline#fnametruncate = 16
"let g:airline#extensions#tabline#buffer_idx_mode = 1
" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'

" buffer line setting
command -narg=1 GOTO :execute 'lua require("bufferline").go_to(<args>, true)'
nnoremap gt :<c-u>execute "GOTO " . v:count<CR>

" vsnip setting
" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
"imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
"imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
let g:vsnip_snippet_dir = '~/.config/nvim/vsnip'

" commenter setting
vmap <C-_> <leader>c<space>
nmap <C-_> <leader>c<space>
let g:NERDSpaceDelims = 1

" FZF setting
nnoremap <C-p> :Files<CR>
nnoremap <leader><C-p> :Buffers<CR>
autocmd SessionLoadPost * :let g:fzf_history_dir = './.fzf-history'
" command! -bang -nargs=+ -complete=dir Agi call fzf#vim#ag_raw(<q-args>, fzf#vim#with_preview(), <bang>0)

" blamer setting
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_date_format = '%Y/%m/%d %H:%M'
highlight Blamer guifg=#54576b

" NvimTree setting
" NerdTree setting
"nnoremap <expr> <C-n> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : "\:NERDTreeFind<CR>"
nnoremap <expr> <C-n> &filetype == "NvimTree" ? "\:NvimTreeClose<CR>" : "\:NvimTreeFindFile<CR>"

" vimspector setting
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
nnoremap <f29> :VimspectorReset<CR>
autocmd SessionLoadPost * silent! :VimspectorLoadSession
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
vmap <Leader>di <Plug>VimspectorBalloonEval

" oscyank setting
vmap <C-c> y
" copy any text that is explicitly yanked
function! s:VimOSCYankPostCallback(event)
    if a:event.operator == 'y'
        call OSCYankRegister(a:event.regname)
    endif
endfunction
augroup VimOSCYankPost
    autocmd!
    autocmd TextYankPost * call s:VimOSCYankPostCallback(v:event)
augroup END

" obsession setting
function! ClearAllHistoryForNewSession()
    clearjumps
    delmarks!
    delmarks A-Z0-9
    call histdel('/')
    call histdel('@')
    call histdel('>')
    call histdel('=')
    call histdel(':')
endfunction
" auto restore
" delete arguments to prevent session having empty buffer
autocmd VimEnter * nested
      \ if argc() == 1 && isdirectory(argv()[0]) |
      \     exec "cd " . argv()[0] |
      \     %argdel |
      \     bw |
      \     if empty(v:this_session) && filereadable('.session.vim') |
      \         source .session.vim |
      \     endif |
      \ endif
" use shada per session
if argc() == 1 && isdirectory(argv()[0])
    if filereadable(argv()[0] . '/.session.shada')
        let &shadafile=argv()[0] . '/.session.shada'
    endif
endif
" command that make shada
function! CreateSession(bang)
    if !a:bang
        call writefile([], '.session.shada')
        set shadafile=.session.shada
        call ClearAllHistoryForNewSession()
        Obsession
        doau SessionLoadPost *
    else
        set shadafile=
        call delete('.session.shada')
        call delete(g:fzf_history_dir, 'rf')
        unlet g:fzf_history_dir
        Obsession!
    endif
endfunction
command -bang Session call CreateSession(<bang>0)

" Floaterm setting
let g:floaterm_keymap_toggle = '<c-space>'

lua require('init')
