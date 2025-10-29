return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        json_decode = require("json5").parse,
        extensions = {
          copilotchat = {
            enabled = true,
            convert_tools_to_functions = true,
            convert_resources_to_functions = true,
            add_mcp_prefix = false,
          },
        },
        ui = {
          window = {
            width = 0.8,
            height = 0.8,
            align = "center",
            relative = "editor",
            zindex = 50,
            border = "rounded",
          },
          wo = {
            winhl = "Normal:MCPHubNormal,FloatBorder:FloatBorder",
          },
        },
      })
    end,
  },
}
