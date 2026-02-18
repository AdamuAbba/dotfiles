local custom_border = require("lib.icons").custom_border

vim.lsp.enable({ "tmux" })

--============================================= Diagnostics =============================================
vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = true,
  update_in_insert = false,
  float = {
    ---@diagnostic disable-next-line: assign-type-mismatch
    border = custom_border,
  },
})

--============================================= rust lsp =============================================
vim.g.lazyvim_rust_diagnostics = "bacon-ls"
vim.g.rustaceanvim = {
  server = {
    settings = {
      ["rust-analyzer"] = {
        cachePriming = {
          enable = true,
        },
        completion = {
          termSearch = {
            enable = true,
          },
        },
        inlayHints = {
          renderColons = true,
          typeHints = {
            enable = true,
          },
        },
        notifications = {
          cargoTomlNotFound = true,
        },
        semanticHighlighting = {
          doc = {
            comment = {
              inject = {
                enable = true,
              },
            },
          },
        },
        signatureInfo = {
          detail = "full",
          documentation = {
            enable = true,
          },
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
          attributes = {
            enable = true,
          },
        },
        diagnostics = {
          enable = true,
        },
        checkOnSave = false,
        hover = {
          dropGlue = {
            enable = false,
          },
          memoryLayout = {
            enable = false,
          },
          links = {
            enable = true,
          },
          show = {
            enumVariants = 10,
            fields = 10,
            traitAssocItems = 10,
          },
          documentation = {
            enable = true,
            keywords = {
              enable = true,
            },
          },
        },
      },
    },
  },
}
