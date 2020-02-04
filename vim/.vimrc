set relativenumber number
set cursorline
syntax on
set laststatus=2
set t_Co=256
set background=dark

set spell spelllang=ru,en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

set keymap=russian-jcukenwin 
set iminsert=0
set imsearch=0
nmap <C-^> i<C-^><Esc>l
inoremap <C-@> <C-^>
nmap <C-@> i<C-^><Esc>l

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

nmap <C-o> O<Esc>
nmap <M-o> o<Esc>
execute "set <M-o>=\eo" 

set pastetoggle=<F2>

call plug#begin('~/.vim/plugged')
	Plug 'micha/vim-colors-solarized'
	Plug 'lifepillar/vim-solarized8'
	 
	Plug 'godlygeek/tabular'
	Plug 'plasticboy/vim-markdown'
	let g:vim_markdown_folding_disabled=1
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
	nnoremap <leader>ld :MarkdownPreview<CR>
	nnoremap <leader>lt :TableFormat<CR>
	nnoremap <leader>ltoc :Toc<CR>
	Plug 'mzlogin/vim-markdown-toc'
	nnoremap <leader>lo :GenTocGFM<CR>

	Plug 'lervag/vimtex'
	let g:tex_flavor = 'latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_compiler_method='latexmk'
	let g:vimtex_quickfix_mode=0
	set conceallevel=2
	let g:tex_conceal='abdmg'
	Plug 'KeitaNakamura/tex-conceal.vim'

	Plug 'sirver/ultisnips'
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
	let g:UltiSnipsSnippetsDir = "~/.vim/plugged/ultisnips"
	let g:UltiSnipsSnippetDirectories=["~/.vim/plugged/ultisnips"]
	 
	Plug 'scrooloose/nerdtree'
	map <C-n> :NERDTreeToggle<CR>
	map <C-m> :NERDTreeFind<CR>
	Plug 'junegunn/fzf.vim'
call plug#end()
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/
colorscheme solarized8_flat
source /usr/share/doc/fzf/examples/fzf.vim

