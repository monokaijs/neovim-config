let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-tsserver',
            \ 'coc-html',
            \ 'coc-css',
            \ ]
lua require('plugins')
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
