filetype indent plugin on
set encoding=utf-8
scriptencoding utf-8

if !exists('g:syntax_in')
  syntax enable
endif
"

" << PLUGINS >>

call plug#begin('~/.local/share/nvim/plugged')"

Plug 'dracula/vim', { 'commit': '147f389f4275cec4ef43ebc25e2011c57b45cc00' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Functionalities
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine' " https://github.com/Yggdroot/indentLine

Plug 'neoclide/coc.nvim', {'branch': 'release'} " https://github.com/neoclide/coc.nvim

" Languages
Plug 'elixir-editors/vim-elixir' " https://github.com/elixir-editors/vim-elixir
Plug 'mhinz/vim-mix-format'

Plug 'diepm/vim-rest-console'

Plug 'https://github.com/mhinz/vim-startify' " {{{
  let g:startify_change_to_vcs_root = 1
  " 'Most Recent Files' number
  let g:startify_files_number = 18

  " Update session automatically as you exit vim
  let g:startify_session_persistence    = 1

  " Simplify the startify list to just recent files and sessions
  let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   Recent files'] },
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
  \ ]

  " function! s:filter_header(str) abort
  "   return map(split(system('figlet -f future "'. a:str .'"'), '\n'), '"         ". v:val') + [ '', '' ]
  " endfunction

  if has('nvim')
    " let g:startify_custom_header = s:filter_header('NeoVim')
    let g:startify_custom_header =
    \ [ '        ┏┓╻┏━╸┏━┓╻ ╻╻┏┳┓'
    \ , '        ┃┗┫┣╸ ┃ ┃┃┏┛┃┃┃┃'
    \ , '        ╹ ╹┗━╸┗━┛┗┛ ╹╹ ╹'
    \ , ''
    \ ]
  else
    " let g:startify_custom_header = s:filter_header('Vim')
    let g:startify_custom_header =
    \ [ '        ╻ ╻╻┏┳┓'
    \ , '        ┃┏┛┃┃┃┃'
    \ , '        ┗┛ ╹╹ ╹'
    \ , ''
    \ ]
  endif
" }}}


call plug#end()
"

""" Coloring
syntax on
color dracula
highlight Pmenu guibg=white guifg=black gui=bold
highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none

" Opaque Background (Comment out to use terminal's profile)
"set termguicolors


""" Other Configurations
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\
set wrap breakindent
set encoding=utf-8
set number
set title


""" Plugin Configuration

" NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
let g:NERDTreeWinPos = "right"

" Airline
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''

" indentLine
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#363949'

""" Custom Function

" Dracula Mode (Dark)
function! ColorDracula()
    let g:airline_theme=''
    color dracula
    IndentLinesEnable
endfunction



""" Custom Mappings

let mapleader=","
nmap <leader>q :NERDTreeToggle<CR>
nmap \ <leader>q
nmap <leader>e1 :call ColorDracula()<CR>

" Remap for format selected region
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

" startfy
" `SPC l s` - save current session
nnoremap <leader>ls :SSave<CR>
" `SPC l l` - list sessions / switch to different project
nnoremap <leader>ll :SClose<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


augroup mygroup
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')
