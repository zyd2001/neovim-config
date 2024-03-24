set number relativenumber
set hidden
set termguicolors
inoremap <C-s> <esc>:w<CR>
vnoremap <C-s> <esc>
nnoremap <C-s> :w<CR>
cnoremap <C-s> <esc>
nnoremap vb <C-v>
nnoremap vo :browse oldfile<CR>
nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>
set tabstop=4 shiftwidth=4 expandtab
set backspace=indent,eol,start
set ignorecase
set smartcase
set mouse=a
nnoremap <C-a> ggVG
nnoremap <C-q> :bd<CR>
set list listchars+=space:· listchars-=eol:$ listchars+=tab:>-
let g:vim_json_conceal=0
" restore file last edit location
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" set and restore cursor shape
autocmd VimLeave,VimSuspend * set guicursor=a:ver25
cabbrev vhelp vertical help

call plug#begin()
Plug 'tpope/vim-surround'

" completion
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'scrooloose/nerdcommenter'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
"Plug 'bfrg/vim-cpp-modern'
" show parentheses with color
Plug 'luochen1990/rainbow'
" show matching indent
Plug 'yggdroot/indentline'
Plug 'tpope/vim-sleuth'

Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'

" debug
Plug 'puremourning/vimspector'
"Plug 'mfussenegger/nvim-dap'
"Plug 'nvim-neotest/nvim-nio'
"Plug 'rcarriga/nvim-dap-ui'

" search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" enable clipboard
Plug 'ojroques/vim-oscyank', {'branch': 'main'}

" session manager
Plug 'tpope/vim-obsession', { 'frozen': 1 }
call plug#end()

" rainbow setting
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['#ffd700', '#da70d6', '#179fff'],
\   'operators':''
\}

" colorscheme setting
"colorscheme onedark
let g:material_terminal_italics = 1
let g:material_theme_style='palenight'
colorscheme material

" airline setting
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr= ''
let g:airline#extensions#branch#enabled = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" vsnip setting
" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" commenter setting
vmap <C-_> <leader>c<space>
nmap <C-_> <leader>c<space>

" FZF setting
nnoremap <C-p> :Files<CR>
autocmd SessionLoadPost * :let g:fzf_history_dir = './.fzf-history'

" NerdTree setting
nnoremap <expr> <C-n> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : "\:NERDTreeFind<CR>"

" vimspector setting
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
nnoremap <f29> :VimspectorReset<CR>
autocmd SessionLoadPost * silent! :VimspectorLoadSession
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
vmap <Leader>di <Plug>VimspectorBalloonEval

" oscyank setting
vmap <C-c> ygv<Plug>OSCYankVisual

" obsession setting
" auto restore
autocmd VimEnter * nested 
      \ if argc() == 1 && isdirectory(argv()[0]) |
      \     exec "cd " . argv()[0] |
      \     if empty(v:this_session) && filereadable('.session.vim') |
      \         source .session.vim |
      \     endif |
      \ endif
map <F3> :Inspect<CR>

lua require('init')
