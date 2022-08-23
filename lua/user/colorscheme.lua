vim.cmd [[
try
  colorscheme monokaipro
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
