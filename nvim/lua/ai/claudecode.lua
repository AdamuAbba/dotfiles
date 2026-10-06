vim.pack.add({
  "https://github.com/coder/claudecode.nvim",
  "https://github.com/mr55p-dev/claude-tmux.nvim",
})

local claude_tmux = require("claude-tmux")

local terminal_config = {
  split_side = "right",
  split_width_percentage = 0.40,
  auto_close = true,
}
-- inside tmux, Claude runs in a tmux pane instead of a Neovim terminal
if claude_tmux.is_available() then
  terminal_config.provider = claude_tmux.setup({
    toggle_key = "<C-j>",
    split_size = 40,
  })
end

require("claudecode").setup({
  focus_after_send = true,
  terminal = terminal_config,
  diff_opts = {
    layout = "unified",
    vertical_split = false,
    open_in_new_tab = false,
    open_in_current_tab = true,
    keep_terminal_focus = true,
  },
})

local map = vim.keymap.set
require("which-key").add({ { "<leader>a", group = "AI/Claude Code" } })
map("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
map("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
map("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
map("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
map("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
map("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
map("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
map("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
map("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })

-- in file explorers, <leader>as adds the file under the cursor
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("claudecode_tree_add", { clear = true }),
  pattern = { "oil", "netrw" },
  callback = function(ev)
    map("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { buffer = ev.buf, desc = "Add file" })
  end,
})
