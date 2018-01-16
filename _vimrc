set nobackup
set directory=~/.vim/work
set undodir=~/.vim/work

set list
set listchars=tab:>-,trail:-,eol:$
set number

set laststatus=2

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')
" インストールしたいプラグインを以下に記述する
" call dein#add('developer-a/plugin_you_want_to_install-1')
" ...
" call dein#add('developer-z/plugin_you_want_to_install-xx')
call dein#add('tpope/vim-fugitive')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('jeetsukumaran/vim-nefertiti')
call dein#end()

" install non-installed plugins
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! GetCharCode()
  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction

function! GetEncoding()
  let fenc = strlen(&fenc) >0 ? &fenc : ''
  let ff = strlen(&ff) > 0 ? &ff : ''
  return fenc . '[' . ff . ']'
endfunction

" Display charcode, fileencoding and fileformat.
let g:airline_section_y = '%{GetCharCode()} %{g:airline_right_alt_sep} %{GetEncoding()}'

let g:airline#extensions#tabline#enabled = 1
" powerline-symbol未適用のフォントでは文字化けするので注意
" let g:airline_powerline_fonts = 1

syntax on
