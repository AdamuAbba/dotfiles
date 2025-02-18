return {
  {
    "CRAG666/code_runner.nvim",
    -- dev = true,
    -- keys = {
    --   {
    --     "<leader>e",
    --     function()
    --       require("code_runner").run_code()
    --     end,
    --     desc = "[e]xcute code",
    --   },
    -- },
    opts = {
      mode = "vimux",
      filetype = {
        javascript = "node",
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        kotlin = "cd $dir && kotlinc-native $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt.kexe",
        cpp = {
          "cd $dir &&",
          "g++ $fileName",
          "-o /tmp/$fileNameWithoutExt &&",
          "/tmp/$fileNameWithoutExt",
        },
        python = "python -u '$dir/$fileName'",
        sh = "bash",
        typescript = "deno run",
        typescriptreact = "yarn dev$end",
        rust = "cd $dir && rustc $fileName && $dir$fileNameWithoutExt",
        dart = "dart",
      },
      -- project_path = vim.fn.expand "~/.config/nvim/project_manager.json",
    },
  },
}
