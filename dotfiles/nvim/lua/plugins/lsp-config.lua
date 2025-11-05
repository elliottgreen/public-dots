return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    require("lspconfig").rust_analyzer.setup({}),
    config = function()
      local lspconfig = require("lspconfig")
      local on_attach = function(_, bufnr)
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local opts = { buffer = bufnr, noremap = true, silent = true }
        -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      end
    end,
  },
}
