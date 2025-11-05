local prompts = require("lib.prompts")
return {
  {
    "yetone/avante.nvim",
    ---@module 'avante'
    ---@param _ any
    ---@param opts avante.Config
    opts = function(_, opts)
      local shortcuts = {}

      for _, p in ipairs(prompts) do
        table.insert(shortcuts, {
          name = p.name,
          description = p.description,
          details = p.details,
          prompt = p.prompt,
        })
      end

      opts.shortcuts = vim.tbl_deep_extend("force", opts.shortcuts or {}, shortcuts)
      opts.provider = "copilot"
      opts.mode = "agentic"
      -- opts.acp_providers = {
      --   ["gemini-cli"] = {
      --     command = "gemini",
      --     args = { "--experimental-acp" },
      --     env = {
      --       NODE_NO_WARNINGS = "1",
      --       GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
      --     },
      --   },
      -- }
      opts.selection = vim.tbl_deep_extend("force", opts.selection or {}, {
        enable = true,
        hint_display = "immediate",
      })
      opts.disabled_tools = vim.tbl_extend("force", opts.disabled_tools or {}, {
        -- "list_files",
        -- "search_files",
        -- "read_file",
        -- "create_file",
        -- "rename_file",
        -- "delete_file",
        -- "create_dir",
        -- "rename_dir",
        -- "delete_dir",
        -- "bash",
      })
      opts.system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end
      opts.custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end
    end,
  },
}
