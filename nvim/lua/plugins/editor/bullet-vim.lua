return {
  {
    "bullets-vim/bullets.vim",
    config = function()
      vim.cmd([[
      let g:bullets_enabled_file_types = [
        \ 'markdown',
        \ 'text',
        \ 'gitcommit',
        \ 'scratch'
        \]
      let g:bullets_enable_in_empty_buffers = 0
    ]])
    end,
  },
}
