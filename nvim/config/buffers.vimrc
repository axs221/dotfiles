nmap <leader>c :bdelete!<CR>
nmap <leader><leader>a :%argdelete<CR>
nmap <leader>a :args **/**<LEFT>
nmap <leader>! :argdo<space>
nmap <silent> <leader><leader>c :%bdelete!<CR>
" nnoremap <leader>l :ls<CR>

function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction
function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction
nnoremap _ :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <leader>l :copen<CR>

function! GoToFileIncludeNodeModules ()
  set wildignore-=*/node_modules/*
  set path+=../node_modules/,./node_modules/
  normal! gf
  set wildignore+=*/node_modules/*
  set path-=../node_modules/,./node_modules/
endfunction
nnoremap gf :call GoToFileIncludeNodeModules()<CR>

nmap <leader>] :tjump /
set wildignore=*.swp,*.bak
set wildignore+=/usr/**/*
set wildignore+=*/env/*,*/dist/*,*/bower_components/*,*/.tmp/*,*/tmp/*,*/jest/*
set wildignore+=*.so,*.swp,*.zip,*.rst,*.pyc     " Linux/MacOSX
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user,*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*tags*
set wildignore+=*.tar.*
set wildignore+=*.git/*
set wildignore+=*fonts/*
set wildignore+=*.ico,*.svg,*.png,*.jpg,*.jpeg
set wildignore+=*.DS_STORE*
set wildignore+=*Session.vim*
set wildignore+=*/build/*
set wildignore+=*/.tern-port
