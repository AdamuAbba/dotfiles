return {
  {
    "iamcco/markdown-preview.nvim",
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    init = function()
      vim.cmd([[
function OpenMarkdownPreview (url)
    execute "silent ! open -a Google\\ Chrome -n --args --new-window --incognito " . a:url
  endfunction
 ]])

      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end,
  },
}
