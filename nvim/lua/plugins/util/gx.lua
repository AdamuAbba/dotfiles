return {
  {
    "chrishrb/gx.nvim",
    submodules = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    keys = {
      {
        "gl",
        "<cmd>Browse<cr>",
        desc = "Open link under cursor",
        mode = { "n", "x" },
      },
    },
    config = function()
      require("gx").setup({
        open_browser_app = "open",
        open_browser_args = { "" },
        open_callback = false,
        select_prompt = true,
        handlers = {
          plugin = true,
          github = true,
          markdown = true,
          brewfile = true,
          package_json = true,
          search = true, -- search the web/selection on the web if nothing else is found
          go = true, -- open pkg.go.dev from an import statement (uses treesitter)
          rust = { -- custom handler to open rust's cargo packages
            name = "rust", -- set name of handler
            filetype = { "toml" }, -- you can also set the required filetype for this handler
            filename = "Cargo.toml", -- or the necessary filename
            handle = function(mode, line, _)
              local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")
              if crate then
                return "https://crates.io/crates/" .. crate
              end
            end,
          },
        },
        handler_options = {
          search_engine = "google",
          select_for_search = true,
          git_remotes = { "upstream", "origin" },
          git_remote_push = false,
        },
      })
    end,
  },
}
