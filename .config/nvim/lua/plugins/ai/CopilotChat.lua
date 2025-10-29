return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "Davidyz/VectorCode",
      {
        "nvim-lua/plenary.nvim",
        branch = "master",
      },
    },
    build = "make tiktoken",
    opts = function(_, opts)
      local vectorcode_ctx = require("vectorcode.integrations.copilotchat").make_context_provider({
        prompt_header = "Here are relevant files from the repository:",
        prompt_footer = "\nConsider this context when answering:", -- Customize footer text
        skip_empty = true, -- Skip adding context when no files are retrieved
      })
      opts.sticky = vim.list_extend(opts.sticky or {}, {
        "#vectorcode", -- Automatically includes repository context in every conversation
      })
      opts.context = vim.tbl_deep_extend("force", opts.context or {}, {
        vectorcode = vectorcode_ctx,
      })
      opts.prompts = vim.tbl_deep_extend("force", opts.prompts or {}, {
        Explain = {
          prompt = "Explain the following code in detail [vectorcode ctx]:\n$input",
          context = { "selection", "vectorcode" },
        },
      })
      opts.window = vim.tbl_deep_extend(
        "force",
        opts.window or {},
        ---@class snacks.layout.Config
        {
          -- height = 20, -- Fixed height in rows
          layout = "vertical",
          border = "rounded",
        }
      )
    end,
  },
}
