---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.rust_analyzer
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
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
        enable = false,
        experimental = {
          enable = false,
        },
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
}
