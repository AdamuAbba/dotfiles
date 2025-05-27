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
    execute "silent ! open -a Zen -n --args --new-tab " . a:url
  endfunction
 ]])

      vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    end,
  },
}
