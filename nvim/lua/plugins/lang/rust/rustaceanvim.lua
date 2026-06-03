return {
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
    version = "^9",
    config = function(_, opts)
      local custom_border = require("lib.icons").custom_border
      --  rustaceanvim installs rust-analyzer
      -- so we I'm setting the default settings for rust-analyzer here
      opts.tools = {
        float_win_config = {
          border = custom_border,
          title = " rustaceanvim ",
          title_pos = "left",
          width = math.min(80, vim.o.columns - 4),
          height = math.min(24, vim.o.lines - 4),
        },
        code_actions = {
          ui_select_fallback = true,
        },
      }
      opts.server = vim.tbl_deep_extend("force", opts.server or {}, {
        ---@type lspconfig.settings.rust_analyzer
        default_settings = {
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
              enable = true,
              experimental = {
                enable = true,
              },
            },
            checkOnSave = true,
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
      })
      local codelldb = vim.fn.exepath("codelldb")
      local codelldb_lib_ext = io.popen("uname"):read("*l") == "Linux" and ".so" or ".dylib"
      local library_path = vim.fn.expand("$MASON/opt/lldb/lib/liblldb" .. codelldb_lib_ext)
      opts.dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
      }
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      return opts
    end,
  },
}
