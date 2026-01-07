return {
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local gitworktree = require("git-worktree")
      local wk = require("which-key")

      gitworktree.setup()

      require("telescope").load_extension("git_worktree")

      -- HACK: by default
      -- <Enter> - switches to that worktree
      -- <c-d> - deletes that worktree
      -- <c-f> - toggles forcing of the next deletion

      wk.add({
        { "<leader>gw", group = "git-worktrees", icon = "  ", mode = { "n" } },
        {
          "<leader>gwl",
          function()
            require("telescope").extensions.git_worktree.git_worktrees()
          end,
          icon = "  ",
          desc = "list Git Worktree",
          silent = true,
          mode = { "n" },
        },
        {
          "<leader>gwc",
          function()
            require("telescope").extensions.git_worktree.create_git_worktree()
          end,
          icon = " ",
          desc = "Create Git Worktree Branches",
          silent = true,
          mode = { "n" },
        },
      })
    end,
  },
}
