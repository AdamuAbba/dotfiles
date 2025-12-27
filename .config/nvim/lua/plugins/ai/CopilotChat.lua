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
        prompt_footer = "\nConsider this context when answering:",
        skip_empty = true,
      })
      opts.sticky = vim.list_extend(opts.sticky or {}, {
        "#vectorcode",
      })
      opts.context = vim.tbl_deep_extend("force", opts.context or {}, {
        vectorcode = vectorcode_ctx,
      })
      opts.model = "gpt-5-mini"
      opts.prompts = vim.tbl_deep_extend("force", opts.prompts or {}, {
        Explain = {
          prompt = [[
Explain the following code.

Requirements:
- format the explanation in markdown using headings, bullet points, and code blocks.
- Use bullet points.
- Be clear and easy to understand.
- Avoid jargon.
- Keep it concise and straight to the point.
- Cover: purpose, key logic/flow, inputs/outputs, side effects.

[vectorcode ctx]:
$input
]],
          context = { "selection", "vectorcode" },
        },
      })
      opts.window = vim.tbl_deep_extend(
        "force",
        opts.window or {},
        ---@class snacks.layout.Config
        {
          layout = "vertical",
          border = "rounded",
        }
      )
      return opts
    end,
  },
}
