-------------------- TREE-SITTER ---------------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = {
    'python',
    'javascript',
    'latex',
    'bash',
    'c',
    'dockerfile',
    'html',
    'json',
    'julia',
    'r',
    'rust',
    'yaml'
  },
  highlight = {
    enable = true,
    uselanguagetree = true
  }
}
