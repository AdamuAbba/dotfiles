return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      {
        "folke/snacks.nvim",
        opts = { input = { enabled = true } },
      },
    },
    config = function()
      local wk = require("which-key")

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        provider = {
          enabled = "tmux",
          tmux = {},
        },
      }
      vim.o.autoread = true

      wk.add({
        { "<leader>a", group = "opencode", mode = { "n" } },
        {
          "<leader>apd",
          function()
            require("opencode").prompt("Explain @diagnostics at this line @this ", { submit = true })
          end,
          desc = "Explain diagnostic [line]",
          mode = { "n" },
        },
        {
          "<leader>aa",
          function()
            require("opencode").ask("@this: ", { submit = true })
          end,
          desc = "Ask about selection",
          mode = { "v" },
        },
        {
          "<leader>ae",
          function()
            require("opencode").prompt("Explain @this and it's context", { submit = true })
          end,
          desc = "Explain selection",
          mode = { "v" },
        },
        {
          "<leader>ax",
          function()
            require("opencode").select()
          end,
          desc = "Execute opencode action…",
        },
        {
          "<leader>at",
          function()
            require("opencode").toggle()
          end,
          desc = "Toggle opencode",
        },
        {
          "<leader>ao",
          function()
            return require("opencode").operator("@this ")
          end,
          expr = true,
          desc = "Add range to opencode",
          mode = { "n", "x" },
        },
        {
          "<leader>al",
          function()
            ---@diagnostic disable-next-line: redundant-return-value
            return require("opencode").operator("@this ") .. "_"
          end,
          expr = true,
          desc = "Add line to opencode",
        },
        {
          "<leader>au",
          function()
            require("opencode").command("session.half.page.up")
          end,
          desc = "opencode half page up",
        },
        {
          "<leader>ad",
          function()
            require("opencode").command("session.half.page.down")
          end,
          desc = "opencode half page down",
        },
      })
    end,
  },
}
