---@type vim.lsp.Config
return {
  cmd = { "/opt/homebrew/bin/rust-analyzer" },
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
        fullFunctionSignatures = {
          enable = true,
        },
        addColonsToModule = true,
      },
      inlayHints = {
        renderColons = true,
        closureCaptureHints = {
          enable = true,
        },
        closureReturnTypeHints = {
          enable = "always",
        },
        typeHints = {
          enable = true,
        },
        chainingHints = {
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
        features = "all",
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
