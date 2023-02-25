vim.cmd [[packadd packer.nvim]]

local group = vim.api.nvim_create_augroup("startup", {clear = true})
local packer = require('packer')
local util = require("packer.util")

require('packer').startup(function(use)
  use {'wbthomason/packer.nvim'}

  use {'vim-airline/vim-airline'}
  -- use {'preservim/nerdtree'} -- We don't use nerdtree anymore since it looks quite boring
  use {'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile'}
  use {'nvim-tree/nvim-web-devicons'}
  use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}
  use {'lukas-reineke/indent-blankline.nvim'}
  use {'folke/tokyonight.nvim'}
  use {'akinsho/toggleterm.nvim'}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly'
  }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = {{'nvim-lua/plenary.nvim'}},
  }
  use {'editorconfig/editorconfig-vim'}
  use {'dense-analysis/ale'}
  use {'wakatime/vim-wakatime'}
end)

vim.cmd[[colorscheme tokyonight]]

local compile_path = util.join_paths(
  vim.fn.stdpath("config"), "plugin", "packer_compiled.lua"
)

vim.cmd("source " .. compile_path)


-- NERDTree
-- vim.api.nvim_create_autocmd("VimEnter", {command="NERDTree | wincmd p", group=group})
-- vim.api.nvim_create_autocmd("BufEnter", {command="if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif"})

-- VimAirline config
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

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "help", "javascript", "typescript", "go", "php", "markdown", "markdown_inline", "lua", "json", "html", "java", "css" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true
  }
}

-- Nvim Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
})

vim.api.nvim_create_autocmd("VimEnter", {callback = function() require("nvim-tree.api").tree.open() end})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
