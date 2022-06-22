call plug#begin()
" Tema
Plug 'ntk148v/vim-horizon'
Plug 'dracula/vim', {'as':'dracula'}

" AirLines
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" NerdTree
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Icones
Plug 'ryanoasis/vim-devicons'

" Sintaxes
Plug 'sheerun/vim-polyglot'
Plug 'vobornik/vim-mql4'

" Processadores
Plug 'dense-analysis/ale'

" Multiplos cursores
Plug 'terryma/vim-multiple-cursors'
call plug#end()

" Fonte e tamanho
set guifont=Hack\ NF:h10

" Solução para abrir Gvim em modo tela cheia
au GUIEnter * simalt ~x
set lines=999 
set columns=999

" Habilitar cores na sintaxe
syntax on 

set so=999 " Centralizar linha
set number relativenumber " Habilitar numeros de linhas
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab " Ajustar largura do tab para 4 espaços        

set cursorline " Habilitar cor na linha

set hidden           " Habilitar Abas para alternar entre arquivos abertos
set signcolumn=yes   " Adiciona uma linha vertical onde vai apontar linhas de codigo com erro 
set cmdheight=1      " Mais espaço para mensagens do cmd
set encoding=utf-8   " Para ativar icones de fonts
set nobackup         " No backup files
set nowritebackup    " No backup files
set splitright       " Abrir novo arquivo na direita
set splitbelow       " Abrir novo arquivo embaixo
set mouse=a          " Habilitar suporte a mouse
set t_Co=256         " Solução para funcionar tema no Windows Terminal

set smarttab         
set smartindent      
set incsearch        
set ignorecase       
set smartcase        
set updatetime=100   
set autoread         

filetype on          
filetype plugin on   
filetype indent on   

" Temas
colorscheme horizon "sonokai

" Airline
"let g:airline_theme = 'sonokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" NerdTree
nmap <C-d> :NERDTreeToggle<CR>

" Configurações para rodar bem no Windows
"source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
