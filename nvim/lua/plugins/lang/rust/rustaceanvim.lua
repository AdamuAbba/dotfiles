return {
  {
    "mrcjkb/rustaceanvim",
    config = function(_, opts)
      if LazyVim.has("mason.nvim") then
        local ra = vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer"

        opts.server = {
          cmd = { ra },
        }
        local codelldb = vim.fn.exepath("codelldb")
        local codelldb_lib_ext = io.popen("uname"):read("*l") == "Linux" and ".so" or ".dylib"
        local library_path = vim.fn.expand("$MASON/opt/lldb/lib/liblldb" .. codelldb_lib_ext)
        opts.dap = {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
        }
      end
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },
}
