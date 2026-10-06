-- Move lines and selections with <M-hjkl> (replaces mini.move).
-- Up/down move whole lines and reindent them; left/right change indentation.
local map = vim.keymap.set

------ down / up
map("n", "<M-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<M-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("x", "<M-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("x", "<M-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

------ left / right: one shiftwidth per step; a count repeats the step
local function shift_line(op)
  return function()
    for _ = 1, vim.v.count1 do
      vim.cmd("normal! " .. op)
    end
  end
end
map("n", "<M-h>", shift_line("<<"), { desc = "Move line left" })
map("n", "<M-l>", shift_line(">>"), { desc = "Move line right" })
map("x", "<M-h>", "<gv", { desc = "Move left" })
map("x", "<M-l>", ">gv", { desc = "Move right" })
