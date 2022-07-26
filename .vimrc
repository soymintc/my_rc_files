" Plugins
call plug#begin()
  Plug 'itchyny/lightline.vim'
  Plug 'preservim/nerdtree'
  Plug 'morhetz/gruvbox'
  Plug 'zyedidia/vim-snake'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/syntastic'
  Plug 'bagrat/vim-buffet'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'vim-airline/vim-airline'
  Plug 'JuliaEditorSupport/julia-vim'
  Plug 'arthurxavierx/vim-unicoder'
call plug#end()


" <leader>
let mapleader = "\\"


set nocp
" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
"if has("syntax")
syntax on
"endif


" ts=4 sts=4 sw=4 si et ai smarttab
" Customizing tabs
set shiftwidth=4 softtabstop=4 tabstop=4
set si et ai
set number relativenumber
set incsearch
set nowrap
set scrolloff=8 " 8 lines above scrolling

" map <leader>vimrc :tabe ~/.vim/.vimrc<cr>
autocmd! bufwritepost .vimrc source % " allow vim reload after save



" Better copy & paste
set pastetoggle=<F3>
set clipboard=unnamed


set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}


" Press space to clear search highlighting and any message already displayed.
set hlsearch
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>


" Change default DarkBlue comment_color to LightBlue
hi Comment ctermfg=LightBlue


" Colorscheme
set background=dark 
colorscheme gruvbox 
set colorcolumn=80
hi Normal guibg=NONE ctermbg=NONE
" colorscheme slate


" Add snakemake (.snake, .smk) syntax:
" mkdir -p ~/.vim/syntax/
" wget -p ~/.vim/syntax/ https://mstamenk.github.io/assets/files/snakemake.vim
" # uncomment the follwing afterwards
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake


" Allow statusbar
set laststatus=2


" Plugin remaps
nnoremap <C-t> :NERDTreeToggle<CR>
"Plug 'morhetz/gruvbox'
"  Plug 'davidhalter/jedi-vim'

" fzf finder
set rtp+=~/.fzf
nnoremap <C-p> :FZF<CR>


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_w = 0
let g:syntastic_check_on_wq = 0
" let g:syntastic_error_symbol = "✗"
let g:syntastic_error_symbol = "x"
" let g:syntastic_warning_symbol = "⚠"
let g:syntastic_warning_symbol = "!"
let g:syntastic_mode_map = { "passive_filetypes": ["python"] }


" useful remaps
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Tab line: bagrat/vim-buffet
" Go to last active tab

" Quick navigation of tabs
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <F2><F2> :exe "tabn ".g:lasttab<CR>
nnoremap <F2>[ <esc>:tabprevious<CR>
nnoremap <F2>] <esc>:tabnext<CR>
nnoremap <F2>1 <esc>1gt
nnoremap <F2>2 <esc>2gt
nnoremap <F2>3 <esc>3gt
nnoremap <F2>4 <esc>4gt
nnoremap <F2>5 <esc>5gt
nnoremap <F2>6 <esc>6gt
nnoremap <F2>7 <esc>7gt
nnoremap <F2>8 <esc>8gt
nnoremap <F2>9 <esc>9gt


" Syntastic remaps
nnoremap <C-c>c :SyntasticCheck<CR>
nnoremap <C-c>r :SyntasticReset<CR>
nnoremap <C-c>t :SyntasticToggle<CR>


" vim-tmux navigation with CTRL+h/j/k/l
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>


" type greek letters using latex
let g:latex_to_unicode_file_typesd = ".*"
let g:latex_to_unicode_file_types_blacklist = ["tex", "plaintex"]
let g:latex_to_unicode_auto = 1
