local os = require("os")

return {
  {
    "mistricky/codesnap.nvim",
    tag = "v2.0.0-beta.17",
    cmd = "CodeSnapSave",
    keys = {
      {
        "<leader>cs",
        function()
          local path = os.getenv("HOME") .. "/Pictures/screenshots/code-image.png"
          require("codesnap").save(path)
        end,
        desc = "CodeSnap",
        mode = "x",
      },
    },
    opts = {
      show_line_number = true,
      highlight_color = "#ffffff20",
      show_workspace = true,
      snapshot_config = {
        theme = "vercel@https://raw.githubusercontent.com/Railly/one-hunter-vscode/refs/heads/main/themes/OneHunter-Vercel-color-theme.json",
        window = {
          mac_window_bar = true,
          shadow = {
            radius = 20,
            color = "#00000040",
          },
          margin = {
            x = 82,
            y = 82,
          },
          border = {
            width = 1,
            color = "#00000030",
          },
          title_config = {
            color = "#ffffff",
            font_family = "IosevkaInput",
          },
        },
        themes_folders = {},
        fonts_folders = {},
        line_number_color = "#495162",
        command_output_config = {
          prompt = "❯",
          font_family = "IosevkaInput",
          prompt_color = "#F78FB3",
          command_color = "#98C379",
          string_arg_color = "#ff0000",
        },
        code_config = {
          font_family = "IosevkaInput",
          breadcrumbs = {
            enable = true,
            separator = "/",
            color = "#80848b",
            font_family = "IosevkaInput",
          },
        },
        watermark = {
          -- content = "CodeSnap.nvim",
          -- font_family = "IosevkaInput",
          -- color = "#ffffff",
        },
        background = {
          color = "#000000",
        },
      },
    },
    config = function(_, opts)
      require("codesnap").setup(opts)
    end,
  },
}
