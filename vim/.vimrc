" Load modular vim configuration files
for vim_file in split(glob($HOME . '/.vim/*.vim'), '\n')
  execute 'source' vim_file
endfor