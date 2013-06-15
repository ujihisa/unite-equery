let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#equery#define()
  return executable('equery') ? s:source : {}
endfunction

let s:source = {
      \ 'name' : 'equery',
      \ 'description' : 'candidates from "equery file {package}"',
      \ }

function! s:source.gather_candidates(args, context)
  let cmdoption = get(a:args, 0, 'h')
  if cmdoption ==# 'f'
    return s:equery_f(a:args, a:context)
  elseif cmdoption ==# 'h'
    " TODO implement it
    "return s:equery_h(a:args, a:context)
    return []
  else
    " TODO error
    return []
  end
endfunction

function! s:equery_f(args, context)
  let package_name = get(a:args, 1, "")
  if package_name ==# ""
    return []
  else
    let command = printf("equery -C f '%s'", substitute(package_name, "'", "\\\\'", 'g'))
    let cmdresult = split(unite#util#system(command), "\n")
    call filter(cmdresult, 'filereadable(v:val)')
    call map(cmdresult, '{
          \ "word": v:val,
          \ "source": s:source.name,
          \ "kind": ["file"],
          \ "action__path": v:val,
          \ "action__directory": fnamemodify(v:val, ':h'),
          \ }')
    return cmdresult
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
