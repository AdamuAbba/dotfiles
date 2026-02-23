return {
  {
    "nvim-mini/mini.clue",
    version = false,
    enabled = false,
    config = function()
      local miniclue = require("mini.clue")

      local function ai_clue()
        local objects = {
          { " ", desc = "whitespace" },
          { '"', desc = '" string' },
          { "'", desc = "' string" },
          { "(", desc = "() block" },
          { ")", desc = "() block with ws" },
          { "<", desc = "<> block" },
          { ">", desc = "<> block with ws" },
          { "?", desc = "user prompt" },
          { "U", desc = "use/call without dot" },
          { "[", desc = "[] block" },
          { "]", desc = "[] block with ws" },
          { "_", desc = "underscore" },
          { "`", desc = "` string" },
          { "a", desc = "argument" },
          { "b", desc = ")]} block" },
          { "c", desc = "class" },
          { "d", desc = "digit(s)" },
          { "e", desc = "CamelCase / snake_case" },
          { "f", desc = "function" },
          { "g", desc = "entire file" },
          { "o", desc = "block, conditional, loop" },
          { "q", desc = "quote `\"'" },
          { "t", desc = "tag" },
          { "l", desc = "line" },
          { "u", desc = "use/call" },
          { "{", desc = "{} block" },
          { "}", desc = "{} with ws" },
        }

        local modes = { "x", "o" }
        local ret = {}
        ---@type table<string, string>
        local mappings = {
          around = "a",
          inside = "i",
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",
        }

        for _, prefix in pairs(mappings) do
          if prefix == "" then
            goto continue
          end
          for _, mode in ipairs(modes) do
            for _, obj in ipairs(objects) do
              local desc = obj.desc
              if prefix:sub(1, 1) == "i" then
                desc = desc:gsub(" with ws", "")
              end
              ret[#ret + 1] = { mode = mode, keys = prefix .. obj[1], desc = desc }
            end
          end
          ::continue::
        end

        return ret
      end
      miniclue.setup({
        window = {
          config = {},
          delay = 300,
        },
        triggers = {
          -- Leader triggers
          { mode = { "n", "x" }, keys = "<Leader>" },

          -- `[` and `]` keys
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = { "n", "x" }, keys = "g" },

          -- Marks
          { mode = { "n", "x" }, keys = "'" },
          { mode = { "n", "x" }, keys = "`" },

          -- Registers
          { mode = { "n", "x" }, keys = '"' },
          { mode = { "i", "c" }, keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = { "n", "x" }, keys = "z" },

          -- "around" and "inside" text objects
          { mode = "x", keys = "a" },
          { mode = "o", keys = "a" },
          { mode = "x", keys = "i" },
          { mode = "o", keys = "i" },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.square_brackets(),
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
          ai_clue(),
        },
      })
    end,
  },
}
