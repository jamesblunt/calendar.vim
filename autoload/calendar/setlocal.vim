" =============================================================================
" Filename: autoload/calendar/setlocal.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/02/10 13:58:10.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

" All the setlocal commands are executed using the functions in this file.

" Set all the local settings for the current calendar buffer.
let s:undolevels = v:version > 704 || v:version == 704 && has('patch073')
let s:colorcolumn = exists('&colorcolumn')
let s:relativenumber = exists('&relativenumber')
function! calendar#setlocal#new()
  setlocal nomodifiable buftype=nofile noswapfile readonly
        \ bufhidden=hide wrap nowrap nobuflisted nofoldenable foldcolumn=0
        \ nolist completefunc= omnifunc=
        \ nocursorcolumn nocursorline nonumber nomodeline
  if s:undolevels
    setlocal undolevels=-1
  endif
  if s:colorcolumn
    setlocal colorcolumn=
  endif
  if s:relativenumber
    setlocal norelativenumber
  endif
  call calendar#setlocal#filetype()
endfunction

" Set modifiable so that the controller can modify the contents in the buffer.
function! calendar#setlocal#modifiable()
  setlocal modifiable noreadonly
endfunction

" Set nomodifiable after the controller modify the contents in the buffer.
function! calendar#setlocal#nomodifiable()
  setlocal nomodifiable readonly
endfunction

" Set filetype once.
function! calendar#setlocal#filetype()
  if &l:filetype !=# 'calendar'
    setlocal filetype=calendar
  endif
endfunction

" Set filetype forcibly. (see 'autocmd ColorScheme' in autocmd.vim)
function! calendar#setlocal#filetype_force()
  setlocal filetype=
  setlocal filetype=calendar
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
