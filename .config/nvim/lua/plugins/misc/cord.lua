return {
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    enabled = false,
    opts = function()
      local blacklist = {
        "mindful-insights-mobile",
        -- "nvim",
        "Documents",
      }
      local is_blacklisted = function(opts)
        return vim.tbl_contains(blacklist, opts.workspace)
      end
      return {
        -- use a custom text for the activity
        text = {
          viewing = function(opts)
            return is_blacklisted(opts) and "Viewing a file" or ("Viewing " .. opts.filename)
          end,
          editing = function(opts)
            return is_blacklisted(opts) and "Editing a file" or ("Editing " .. opts.filename)
          end,
          workspace = function(opts)
            return is_blacklisted(opts) and "Private Repo 🔐 (unfortunately)" or ("Working on " .. opts.filename)
          end,
        },
        -- hooks = {
        --   workspace_change = function(opts)
        --     if is_blacklisted(opts) then
        --       -- opts.manager:hide()
        --       vim.cmd("Cord disable")
        --     else
        --       -- opts.manager:resume()
        --       vim.cmd("Cord enable")
        --     end
        --   end,
        -- },
      }
    end,
  },
}
