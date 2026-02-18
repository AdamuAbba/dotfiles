return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
        branch = "master",
      },
    },
    build = "make tiktoken",
    opts = function(_, opts)
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

$input
]],
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
