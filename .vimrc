set nu
set laststatus=2
:map ,b \be
:map S i<CR><ESC>
syn on
filetype indent plugin on
autocmd BufEnter * lcd %:p:h
set expandtab "use spaces instead of tabstops
set smarttab
set autoindent
set hidden
set tabstop=2
set shiftwidth=2
colorscheme koehler
nmap <silent> ,n :NERDTreeToggle<CR>
nmap ,wt :%s/\s\+$//<cr> "Remove trailing whitespace
