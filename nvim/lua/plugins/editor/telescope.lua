-- Helper function to load a Telescope extension after Telescope is loaded
--source https://github.com/polirritmico/telescope-lazy-plugins.nvim#-lazy-loading
local load_extension_after_telescope_is_loaded = function(extension_name)
  local lazy_cfg = require("lazy.core.config").plugins
  if lazy_cfg["telescope.nvim"] and lazy_cfg["telescope.nvim"]._.loaded then
    -- Since Telescope is loaded, just load the extension:
    require("telescope").load_extension(extension_name)
  else
    -- If Telescope is not loaded, create an autocmd that will load the
    -- extension after Telescope is loaded.
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == "telescope.nvim" then
          require("telescope").load_extension(extension_name)
          return true
        end
      end,
    })
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "polirritmico/telescope-lazy-plugins.nvim",
        init = function()
          load_extension_after_telescope_is_loaded("lazy_plugins")
        end,
      },
    },
    keys = {
      { "<leader>sp", "<Cmd>Telescope lazy_plugins<CR>", desc = "Telescope: Plugins configurations" },
      { "<leader>fp", false },
    },
    opts = function(_, opts)
      local custom_border = require("lib.icons").custom_border
      local lp_actions = require("telescope").extensions.lazy_plugins.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        borderchars = {
          custom_border[2], -- top
          custom_border[8], -- right
          custom_border[6], -- bottom
          custom_border[4], -- left
          custom_border[1], -- top-left
          custom_border[3], -- top-right
          custom_border[5], -- bottom-right
          custom_border[7], -- bottom-left
        },
      })
      opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
        ---@module "telescope._extensions.lazy_plugins"
        ---@type TelescopeLazyPluginsUserConfig
        lazy_plugins = {
          mappings = {
            ["i"] = {
              -- ["gd"] = lp_actions.open_repo_dir,
              -- ["gf"] = lp_actions.open_repo_find_files,
              -- ["gl"] = lp_actions.open_repo_live_grep,
              ["<C-o>"] = lp_actions.open_plugin_opts,
              ["<C-r>"] = lp_actions.open_plugin_readme,
              -- ["gx"] = lp_actions.open_repo_url,
              -- ["gR"] = lp_actions.rescan_plugins,
            },
            ["n"] = {},
          },
        },
      })
      return opts
    end,
  },
}
