nnoremap gsa :topleft split ~/Dropbox/notes/<CR>
nnoremap gsc :topleft split ~/Dropbox/cheatsheets/<CR>
nnoremap gsd :topleft split ~/Dropbox/notes/daily.scratch.md<CR>
nnoremap gsg :topleft split ~/Dropbox/notes/goals.scratch.md<CR>
nnoremap gsh :topleft split ~/Dropbox/notes/habits.scratch.md<CR>
nnoremap gsl :topleft split ~/Dropbox/notes/learning.scratch.md<CR>
nnoremap gsm :topleft split ~/Dropbox/notes/meetings.scratch.md<CR>
nnoremap gsp :topleft split ~/Dropbox/notes/personal.scratch.md<CR>
nnoremap gsr :topleft split ~/Dropbox/notes/queries.rest<CR>
nnoremap gss :topleft split ~/Dropbox/notes/scratch.scratch.md<CR>
nnoremap gst :topleft 8split ~/Dropbox/notes/task.scratch.md<CR>
nnoremap gsv :topleft split ~/Dropbox/notes/vim.scratch.md<CR>
nnoremap gsw :topleft split ~/Dropbox/notes/work.scratch.md<CR>

let s:blank_line  = "^$"
let s:bullet      = "^[ ]*\\*"
let s:bullet_only = "^[ ]*\\*[ ]*$"
let s:checked_todo        = "^[ ]*\\[x\]"
let s:unchecked_todo        = "^[ ]*\\[ \]"
let s:todo        = "^[ ]*\\[[ x]\]"
let s:todo_only   = "^[ ]*\\[[ x]\][ ]*$"

function! InsertAsteriskOrCheck (from_linenr, insert_at_offset, cursor_shift)
  let line = getline(a:from_linenr)
  let to_linenr = a:from_linenr + a:insert_at_offset
  let move_to_line = a:from_linenr + a:cursor_shift
  if line =~ s:bullet_only || line =~ s:todo_only
    call setline('.', "")
    call cursor(line("."), 1, 0)
  elseif line =~ s:bullet
    echom "foo"
    call append(to_linenr, "*")
    call cursor(move_to_line, len(getline(move_to_line)) + 1, 1)
  elseif line =~ s:todo
    echom "bar"
    call append(to_linenr, "[ ]")
    call cursor(move_to_line, len(getline(move_to_line)) + 1, 1)
  else
    echom "baz"
    call append(a:from_linenr + a:insert_at_offset, "")
    call cursor(move_to_line, 1, 0)
  endif
endfunction

function! DoBackspace()
  if col('.') == 1
    if line('.')  != 1
      return  "\<ESC>kA\<Del>"
    else
      return ""
    endif
  else
    return "\<Left>\<Del>"
  endif
endfunction

function! DeleteLine ()
    delete

    let newline = getline(".")

    if newline =~ s:bullet_only || newline =~ s:todo_only
      call cursor(line(".") - 1, len(getline(line(".") - 1)) + 1, 1)
    else
      call cursor(line(".") - 1, len(getline(line(".") - 1)), 1)
    endif
endfunction

function! Backspace ()
  let line = getline(".")
  if line =~ s:bullet_only || line =~ s:todo_only
    call DeleteLine()
  else
    " call feedkeys("=DoBackspace()\<CR>", "n")
    call feedkeys("=DoBackspace()\<CR>", "n")
  endif
endfunction

function! CompleteNewBullet ()
  let line = getline(".")

  if line =~ s:blank_line
    call feedkeys("=\"* \"\<CR>")
  else
    call feedkeys("=\"*\"\<CR>")
  endif
endfunction

function! CompleteNewTodo ()
  let line = getline(".")

  if line =~ s:blank_line
    call feedkeys("=\"[ ] \"\<CR>")
  else
    call feedkeys("=\"[ ]\"\<CR>")
  endif
endfunction

function! Indent ()
  call setline('.', "  " . getline("."))
  call cursor(line("."), len(getline(".")) + 1, 1)
endfunction

function! Dedent ()
  call setline('.', substitute(getline("."), "^  ", "", ""))
  call cursor(line("."), len(getline(".")) + 1, 1)
endfunction

function! CheckTodo ()
  let line = getline(".")

  if line =~ s:checked_todo
    call setline('.', substitute(getline("."), "\\[x\\]", "[ ]", ""))
  elseif line =~ s:unchecked_todo
    call setline('.', substitute(getline("."), "\\[ \\]", "[x]", ""))
  endif
endfunction

function! ClearTodos ()
  let save_pos = getpos(".")

  call cursor(1, 0, 0)

  call search("\\[x\\]", "c")
  let line = getline(".")

  echom line

  while line =~ s:checked_todo
    delete

    let line = getline(line("."))
    while line !~ s:unchecked_todo && line !~ s:checked_todo && line !~ s:blank_line
      " Remove any notes that went along with a todo
      delete
      let line = getline(line("."))
    endwhile

    call search("\\[x\\]", "c")
    let line = getline(".")
  endwhile

  call setpos('.', save_pos)
endfunction

augroup markdown
  autocmd!
  autocmd BufLeave   *.md silent w
  autocmd BufEnter   *.md map <buffer> <leader>t :Toch<CR>
  autocmd BufEnter   *.md inoremap <buffer> <silent> <backspace> :call Backspace()<CR>
  autocmd BufEnter   *.md inoremap <buffer> <s-tab> :call Dedent()<CR>
  autocmd BufEnter   *.md inoremap <buffer> <tab> :call Indent()<CR>
  autocmd BufEnter   *.md inoremap <buffer> <enter> :call InsertAsteriskOrCheck(line('.'), 0, 1)<CR>
  autocmd BufEnter   *.md inoremap <buffer> * :call CompleteNewBullet()<CR>
  autocmd BufEnter   *.md inoremap <buffer> [ :call CompleteNewTodo()<CR>
  autocmd BufEnter   *.md inoremap <buffer> <c-u> :call DeleteLine()<CR>

  autocmd BufEnter   *.md nnoremap <buffer> O :call InsertAsteriskOrCheck(line('.'), -1, 0)<CR>i
  autocmd BufEnter   *.md nnoremap <buffer> o :call InsertAsteriskOrCheck(line('.'), 0, 1)<CR>i
  autocmd BufEnter   *.md nnoremap <buffer> <leader>x :call CheckTodo()<CR>
  autocmd BufEnter   *.md nnoremap <buffer> <leader><leader>x :call ClearTodos()<CR>
  autocmd BufEnter   *.md nnoremap <buffer> [[ ?^\[ \]<CR>:nohls<CR>
  autocmd BufEnter   *.md nnoremap <buffer> ]] /^\[ \]<CR>:nohls<CR>
  " autocmd BufEnter   *.md nnoremap <buffer> K ?^\[ \]<CR>:nohls<CR>
  " autocmd BufEnter   *.md nnoremap <buffer> J /^\[ \]<CR>:nohls<CR>
  autocmd BufEnter   *.md nnoremap <silent><buffer> K :silent! ?^#<CR>:silent nohls<CR>
  autocmd BufEnter   *.md nnoremap <silent><buffer> J :silent! /^#<CR>:silent nohls<CR>

  autocmd BufEnter   *.md xnoremap <buffer> <s-tab> :s/^  //<CR>:set nohls<CR>gv
  autocmd BufEnter   *.md xnoremap <buffer> <tab> :norm! I<tab><CR>gv

augroup END

