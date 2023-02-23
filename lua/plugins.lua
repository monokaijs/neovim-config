vim.cmd [[packadd packer.nvim]]

local group = vim.api.nvim_create_augroup("startup", {clear = true})

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'vim-airline/vim-airline'
  use 'preservim/nerdtree'
  use {'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile'}
  use 'nvim-tree/nvim-web-devicons'
  use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}
  use "lukas-reineke/indent-blankline.nvim"
  use 'folke/tokyonight.nvim'
  use 'akinsho/toggleterm.nvim'
end)

vim.cmd[[colorscheme tokyonight]]

vim.api.nvim_create_autocmd("VimEnter", {command="NERDTree | wincmd p", group=group})
vim.api.nvim_create_autocmd("BufEnter", {command="if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif"})
vim.g.airline_powerline_fonts = 1

-- Toggle Term
require('toggleterm').setup()

-- Set Tab size
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- Other Opts
vim.o.ignorecase = true
vim.o.lazyredraw = true
vim.o.number = true

-- Indent Guides
vim.opt.list = true

require("indent_blankline").setup {
  show_end_of_line = false,
}

-- Mappings
local keyset = vim.keymap.set
keyset('i', '<c-space>', 'coc#refresh()', {silent=true, expr=true})
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], {expr=true})

