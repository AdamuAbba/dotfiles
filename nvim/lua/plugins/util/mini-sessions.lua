return {
  {
    "nvim-mini/mini.sessions",
    version = false,
    config = function()
      local wk = require("which-key")
      local MiniSessions = require("mini.sessions")

      MiniSessions.setup()

      wk.add({
        {
          "<leader>qd",
          function()
            MiniSessions.select("delete")
          end,
          desc = "Delete Session",
        },
        {
          "<leader>ql",
          function()
            MiniSessions.select("read")
          end,
          desc = "Load Session",
        },
        {
          "<leader>qr",
          function()
            MiniSessions.restart()
          end,
          desc = "Restart Nvim",
        },
      })
    end,
  },
}
