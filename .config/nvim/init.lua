if vim.fn.has("nvim-0.11") == 1 then
  vim._print = function(_, ...)
    Snacks.debug.inspect(...)
  end
end

require("config.lazy")
require("core.lsp")
