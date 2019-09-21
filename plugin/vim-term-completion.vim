" Vim global plugin for completing :terminal commands
" Source:       https://github.com/wwade/vim-term-completion
" Maintainer:	wwade <wade.carpenter+github@gmail.com>
" License:      LGPL-3.0

if exists( "g:loaded_vim_term_completion" )
   finish
endif
let g:loaded_vim_term_completion = 1

let s:get_comp = expand("<sfile>:p:h") . "/../sh/getcomp.sh"
if !executable(s:get_comp)
   echoerr "Plugin not installed correctly.  Unable to access script" s:get_comp
   finish
endif

function! s:TermCompletion(ArgLead, CmdLine, CursorPos)
   let l:cmd = split(a:CmdLine)
   let l:pos = 0
   while l:pos < len(l:cmd)
      if l:cmd[l:pos] =~ "^[A-Z]"
         let l:pos += 1
         break
      endif
      let l:pos += 1
   endwhile
   let l:sys = s:get_comp . " \"" . join(l:cmd[l:pos:], " ") . "\""
   return system(l:sys)
endfunction

function! s:RunTerminal(cmd, mod)
   if empty(a:cmd)
      if empty(a:mod)
         exe "terminal"
      else
         exe a:mod "terminal"
      endif
   else
      let l:opt = {}
      let l:termcmd = "call term_start(a:cmd, l:opt)"
      for l:opt_name in split(a:mod)
         if l:opt_name == "tab"
            let l:termcmd = ":tab " . l:termcmd
         else
            let l:opt[l:opt_name] = v:true
         endif
      endfor
      exe l:termcmd
   endif
endfunction

" Examples:
" Complete "git log --one" -> "git log --oneline"
"   :Term git log --one<TAB> --> git log --oneline
" Open Terminal in a new tab and run "ls"
"   :tab Term ls
"  - or -
"   :TT ls
" Open Terminal in a vertical split and run "ls"
"   :vert Term ls
"  - or -
"   :VT ls
command! -nargs=* -complete=custom,s:TermCompletion Terminal call s:RunTerminal(<q-args>, <q-mods>)
command! -nargs=* -complete=custom,s:TermCompletion VTerminal call s:RunTerminal(<q-args>, "vertical")
command! -nargs=* -complete=custom,s:TermCompletion TTerminal call s:RunTerminal(<q-args>, "tab")
