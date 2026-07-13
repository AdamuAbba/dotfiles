return {
  {
    "oribarilan/lensline.nvim",
    branch = "release/2.x",
    event = "LspAttach",
    enabled = false,
    config = function(_, opts)
      require("lensline").setup(vim.tbl_deep_extend("force", opts or {}, {
        profiles = {
          {
            name = "default",
            providers = {
              {
                name = "usages",
                enabled = true,
                include = { "refs", "defs", "impls" },
                breakdown = true,
                show_zero = true,
                highlight = "Comment",
                icon_for_single = "󰌹 ",
                inner_separator = ", ",
                labels = {
                  refs = "refs",
                  impls = "impls",
                  defs = "defs",
                  usages = "usages",
                },
              },
              {
                name = "last_author",
                enabled = true,
                highlight = "Comment",
              },
            },
            style = {
              separator = " • ",
              highlight = "Comment",
              prefix = "󰌹 ",
              placement = "above",
              use_nerdfont = true,
              render = "all",
            },
          },
        },
      }))
    end,
  },
}
