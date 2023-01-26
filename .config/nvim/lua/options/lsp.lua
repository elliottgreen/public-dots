require'lspconfig'.texlab.setup{}

  --Commands:
  -- TexlabBuild: Build the current buffer
  -- TexlabForward: Forward search from current position
  
  --Default Values:
    cmd = { "texlab" }
    filetypes = { "tex", "bib" }
    root_dir = {}
    settings = {
      texlab = {
        auxDirectory = ".",
        bibtexFormatter = "texlab",
        build = {
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
          executable = "latexmk",
          isContinuous = false
        },
        chktex = {
          onEdit = false,
          onOpenAndSave = false
        },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = {
          args = {}
        }
      }
    }

--local flake_ignores = {"E203", -- whitespace before :
--                       "W503", -- line break before binary operator
--                       "E501", -- line too long
--                       "C901"} -- mccabe complexity
--local settings = {
--  pylsp = {
--    plugins = {
--      mccabe = { enabled = false },
--      flake8 = {
--        enabled = true,
--        ignore = table.concat(flake_ignores, ",")
--      }
--    }
--  },
--}
