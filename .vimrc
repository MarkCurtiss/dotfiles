set nu
set laststatus=2

let mapleader=","
nmap <leader>b :BufExplorer<cr>
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
set statusline=[%n]\ %.200F\ %(\ %M%R%H)%)\ \@(%l\,%c%V)\ %P
let loaded_matchparen = 0
set incsearch
set ignorecase
au FileType gitcommit set tw=72
:map ,T :!RAILS_ENV=test bundle exec rake spec SPEC=%:p<cr>

:map ,h :%s/\(\w\+\): /:\1 => /g<CR>
