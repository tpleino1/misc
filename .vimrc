" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
" same as bs=2?
set backspace=indent,eol,start

" Avoid pesku ~-files
set nobackup

" keep 150 lines of command line history
set history=150

" show the cursor position all the time
" same as set ru
set ruler

" display incomplete commands
" same as set sc
set showcmd

" display current mode
set showmode

" show matching braces
set showmatch

" do incremental searching
set incsearch

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" tabbing settings
set expandtab
set tabstop=4
set shiftwidth=4

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType human,text,tex,mail,asciidoc setlocal spell
  autocmd FileType make setlocal noexpandtab

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  " always set autoindenting on
  set autoindent

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"Case insensitive search
set ignorecase
set smartcase
set wrapscan

"Line numbers
set number

"Disable arrow keys
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <right> <nop>
"nnoremap <left> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <right> <nop>
"inoremap <left> <nop>

"Line wrapping etc
set wrap linebreak nolist
set textwidth=79
" Line wrapping without new lines
" set textwidth=0
" set wrapmargin=0

"Theme
syntax on
set background=dark
if $TERM == "xterm-256color"
  set t_Co=256
  colorscheme torte
  " colorscheme vydark
else
  colorscheme torte
endif

"Focus lost action
" au FocusLost * :wa
autocmd BufLeave,FocusLost * silent! wall

"Escape insert mode
inoremap jj <Esc>
set timeoutlen=200

"Show tabs and trailing spaces
set list listchars=tab:»·,trail:·

" Highlight
hi clear SpellBad
hi SpellBad cterm=underline, ctermfg=red
hi clear SpellCap
hi SpellCap cterm=underline, ctermfg=blue
hi clear MatchParen
hi MatchParen cterm=underline, ctermfg=green
hi clear ColorColumn
highlight ColorColumn cterm=underline, ctermfg=cyan
call matchadd('ColorColumn', '\%81v', 100)

" wildmnenu: status line: show possible completions of commands
set wmnu

" nostartofline: prevent cursor from changing columns when jumping lines
set nosol

" formatoptions stuff
set fo=cqrt

" laststatus: show status line even with one window
set ls=2

" whichwrap: h and l keys can move to other lines
set whichwrap=<,>,h,l,[,]

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

