return {
  {
    "nvim-mini/mini.pick",
    dependencies = {
      {
        "nvim-mini/mini.bufremove",
        version = false,
      },
    },
    version = false,
    config = function(_, opts)
      local MiniPick = require("mini.pick")
      local bufremove = require("mini.bufremove")
      local wk = require("which-key")
      local icons = require("lib.icons")

      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)

      opts.window = {
        config = {
          border = icons.custom_border,
          relative = "editor",
          anchor = "NW",
          height = height,
          width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        },
      }

      MiniPick.setup(opts)

      local add_items_to_qfl = function(items)
        local qf_items = {}

        for _, item in ipairs(items) do
          -- Split by null byte delimiter
          local parts = vim.split(item, "\0", { plain = true })

          if #parts >= 4 then
            table.insert(qf_items, {
              filename = parts[1],
              lnum = tonumber(parts[2]) or 0,
              col = tonumber(parts[3]) or 0,
              text = parts[4],
            })
          end
        end

        vim.notify("+" .. #qf_items .. " quickfix list")
        if #qf_items > 0 then
          vim.fn.setqflist({}, "r", { items = qf_items, title = "Grep Results" })
        end

        return false
      end

      --============================================= Local grep Deps API  =============================================
      -- copied and modified from https://github.com/james-orcales/big_bang/blob/master/dotfiles/common/.config/nvim/init.lua
      -- dude is a genius

      local rules = {
        Lua = {
          Function = [[(?:function [a-zA-Z0-9_]+\(|[a-zA-Z0-9_]+ = function\(|= def\()]],
        },

        Rust = {
          -- We don't filter by file extension because Rust API searches often target
          -- individual files, unlike Go or Odin, where the package system makes it
          -- more common to search the entire directory.
          Function = [[^\s*pub (const )?(unsafe )?fn +[a-zA-Z0-9_#]+]],
          Macro = [[^\s*macro_rules! [a-zA-Z0-9_#]+]],
          Impl = [[^\s*impl\b]],
          Type = [[^\s*pub (?:struct|union|enum|trait|type) [a-zA-Z0-9_#]+]],
        },

        JavaScript = {
          Function = [[(^\s*function [a-zA-Z0-9_$]+\(|^\s*const [a-zA-Z0-9_$]+ *= *\(|^\s*[a-zA-Z0-9_$]+ *= *\([^)]*\) *=>)]],
          Class = [[^\s*class [a-zA-Z0-9_$]+]],
        },

        TypeScript = {
          Function = [[(^\s*function [a-zA-Z0-9_$]+\(|^\s*const [a-zA-Z0-9_$]+ *= *\(|^\s*[a-zA-Z0-9_$]+ *= *\([^)]*\) *=>)]],
          Type = [[^\s*(export )?(interface|type) [a-zA-Z0-9_$]+]],
          Class = [[^\s*(export )?class [a-zA-Z0-9_$]+]],
        },
      }

      local parse_programming_language = function(path)
        if path:match("%.lua$") then
          return "Lua"
        elseif path:match("%.rs$") or path:lower() == "cargo.toml" then
          return "Rust"
        elseif path:match("%.js$") or path:match("%.jsx$") or path:lower() == "package.json" then
          return "JavaScript"
        elseif path:match("%.ts$") or path:match("%.tsx$") then
          return "TypeScript"
        end
        return nil
      end

      local get_dependency_paths = function(programming_language)
        if programming_language == "Rust" then
          local cargo_src = vim.fn.expand("~/.cargo/registry/src")
          if vim.fn.isdirectory(cargo_src) == 1 then
            -- Find the index.crates.io directory (there should be only one)
            local handle = vim.uv.fs_scandir(cargo_src)
            if handle then
              local index_dir = vim.uv.fs_scandir_next(handle)
              if index_dir then
                return { vim.fs.joinpath(cargo_src, index_dir) }
              end
            end
          end
          return nil
        elseif programming_language == "Lua" then
          local paths = {}
          -- local candidates = {
          --   vim.fn.expand("~/.local/share/nvim/"),
          -- }
          -- for _, path in ipairs(candidates) do
          --   if vim.fn.isdirectory(path) == 1 then
          --     table.insert(paths, path)
          --   end
          -- end

          -- Add Neovim runtime Lua API (vim.*)
          -- Use $VIMRUNTIME to get the current Neovim runtime path dynamically
          local vimruntime = vim.env.VIMRUNTIME
          if vimruntime then
            local nvim_lua_path = vim.fs.joinpath(vimruntime, "lua")
            if vim.fn.isdirectory(nvim_lua_path) == 1 then
              table.insert(paths, nvim_lua_path)
            end
          end

          -- Add system Lua libraries
          -- local lua_paths = {
          --   "/opt/homebrew/share/lua/5.1",
          --   "/opt/homebrew/share/luajit-2.1",
          --   "/usr/local/share/lua/5.1",
          -- }
          -- for _, lua_path in ipairs(lua_paths) do
          --   if vim.fn.isdirectory(lua_path) == 1 then
          --     table.insert(paths, lua_path)
          --   end
          -- end

          return #paths > 0 and paths or nil
        elseif programming_language == "JavaScript" or programming_language == "TypeScript" then
          local cwd = vim.uv.cwd()
          ---@diagnostic disable-next-line: param-type-mismatch
          local node_modules = vim.fs.joinpath(cwd, "node_modules")
          if vim.fn.isdirectory(node_modules) == 1 then
            return { node_modules }
          end
          return nil
        end
        return nil
      end

      local dependency_api_search = function()
        local path = vim.api.nvim_buf_get_name(0)
        local programming_language = nil

        -- Detect language from current buffer or directory
        if not path:match("^oil://.*") then
          programming_language = parse_programming_language(path)
        else
          ---@diagnostic disable-next-line: param-type-mismatch
          local handle = vim.uv.fs_scandir(vim.uv.cwd())
          if handle then
            while true do
              local name, t = vim.uv.fs_scandir_next(handle)
              if not name then
                break
              end
              if t == "file" then
                programming_language = parse_programming_language(name)
                if programming_language then
                  break
                end
              end
            end
          end
        end

        if programming_language == nil then
          vim.notify("Unable to detect language for dependency search", vim.log.levels.WARN)
          return
        end

        -- Get dependency paths
        local dependency_paths = get_dependency_paths(programming_language)
        if dependency_paths == nil then
          local location_hint = programming_language == "Rust" and "~/.cargo/registry"
            or programming_language == "Lua" and "~/.local/share/nvim/lazy or ~/.luarocks"
            or programming_language == "JavaScript" and "./node_modules"
            or programming_language == "TypeScript" and "./node_modules"
            or "dependency directory"
          vim.notify(
            string.format("No dependencies found for %s in %s", programming_language, location_hint),
            vim.log.levels.WARN
          )
          return
        end

        MiniPick.builtin.grep_live({ tool = "rg" }, {
          source = {
            cwd = dependency_paths[1],
            name = dependency_paths[1],
          },
        })
      end

      --============================================= buffer picker =============================================
      local function handle_buffer()
        local wipeout_cur = function()
          local exclude_map = {}
          local matches = MiniPick.get_picker_matches()

          if vim.tbl_count(matches.marked) > 0 then
            for _, mark in pairs(matches.marked) do
              if mark == nil then
                return
              end
              exclude_map[mark.bufnr] = true
              bufremove.delete(mark.bufnr)
            end
          elseif matches.current then
            exclude_map[matches.current.bufnr] = true
            bufremove.delete(matches.current.bufnr)
          end

          local filter = vim.tbl_filter(function(value)
            return not exclude_map[value.bufnr]
          end, MiniPick.get_picker_items())
          MiniPick.set_picker_items(filter)
        end

        local buffer_mappings = { wipeout = { char = "<C-d>", func = wipeout_cur } }
        MiniPick.builtin.buffers(_, { mappings = buffer_mappings })
      end

      wk.add({
        {
          "<leader>fb",
          handle_buffer,
          icon = icons.documents.Buffer,
          desc = "Pick buffer",
          silent = true,
          mode = { "n" },
        },
        {
          "<leader>ff",
          function()
            MiniPick.builtin.files({ tool = "rg" })
          end,
          icon = icons.documents.File,
          desc = "Find Files",
          silent = true,
          mode = { "n" },
        },
        {
          "<leader>sh",
          function()
            MiniPick.builtin.help({
              default_split = "vertical",
            })
          end,
          icon = icons.documents.Help,
          desc = "Help Pages",
          silent = true,
          mode = { "n" },
        },
        {
          "<leader>fg",
          function()
            MiniPick.builtin.grep_live({ tool = "rg" }, {
              source = {
                choose_marked = add_items_to_qfl,
              },
            })
          end,
          icon = icons.documents.SearchInFile,
          desc = "Grep (live)",
          silent = true,
          mode = { "n" },
        },
        {
          "<leader>sw",
          function()
            MiniPick.builtin.grep({
              pattern = vim.fn.expand("<cword>"),
              tool = "rg",
            })
          end,
          desc = "Grep visual selection",
          mode = { "n", "x" },
        },
        {
          "<leader>fa",
          dependency_api_search,
          desc = "Local grep Dep API",
          silent = true,
          mode = { "n" },
        },
      })
    end,
  },
}
