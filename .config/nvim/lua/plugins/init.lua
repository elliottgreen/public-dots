-------------------- PLUGINS -------------------------------
require 'paq' {
  'savq/paq-nvim';                  -- Let Paq manage itself
  'kosayoda/nvim-lightbulb';
  'neovim/nvim-lspconfig';          -- Mind the semi-colons
  'nvim-treesitter/nvim-treesitter';
  'hrsh7th/nvim-compe';
  'nvim-lua/popup.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  {'nvim-telescope/telescope-fzy-native.nvim', run='git submodule update --init --recursive'};
  'akinsho/nvim-toggleterm.lua';
}

