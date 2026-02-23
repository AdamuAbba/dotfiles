----- TODO:: update os path for windows and macOS
local function os_save_path()
  if vim.fn.has("mac") == 1 then
    return "/home/abba/Pictures/"
  elseif vim.fn.has("win32") == 1 then
    return "/home/abba/Pictures/"
  else
    return "/home/abba/Pictures/"
  end
end

return {
  {
    "mistricky/codesnap.nvim",
    lazy = true,
    cmd = "CodeSnapSave",
    keys = {
      { "<leader><space>s", "<cmd>CodeSnapSave<cr>", desc = "Save selected code snapshot in save path", mode = "x" },
    },
    build = "make",
    opts = {
      save_path = os_save_path(),
      bg_theme = "grape",
      has_breadcrumbs = false,
      show_workspace = false,
      watermark = "shytypes1028",
      code_font_family = "JetBrainsMono Nerd Font Mono",
      watermark_font_family = "JetBrainsMono Nerd Font Mono",
    },
    config = function(_, opts)
      require("codesnap").setup(opts)
    end,
  },
}
