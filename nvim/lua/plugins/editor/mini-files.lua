return {
  {
    "nvim-mini/mini.files",
    lazy = false,
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        use_as_default_explorer = true,
        permanent_delete = false,
      })
      opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
        close = "<esc>",
        go_in = "l",
        go_in_plus = "<CR>",
        go_out = "H",
        go_out_plus = "h",
        reset = "<BS>",
        reveal_cwd = ".",
        show_help = "g?",
        synchronize = "s",
        trim_left = "<",
        trim_right = ">",
      })

      opts.content = {
        prefix = function(fs_entry)
          if fs_entry.fs_type == "directory" then
            return " ", "MiniFilesDirectory"
          end
          return " ", "MiniFilesFile"
        end,
      }
      opts.windows = vim.tbl_deep_extend("force", opts.windows or {}, {
        preview = true,
        width_focus = 30,
        width_preview = 80,
      })
      opts.custom_keymaps = {
        copy_to_clipboard = "<space>y",
        zip_and_copy = "<space>Y",
        paste_from_clipboard = "<space>p",
        copy_path = "<M-c>",
        open_with_default_app = "<space>O",
        preview_image = "<space>i",
      }
      return opts
    end,
    config = function(_, opts)
      local mini_files = require("mini.files")
      local icons = require("lib.icons")
      local wk = require("which-key")

      mini_files.setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          local win_id = args.data.win_id
          local config = vim.api.nvim_win_get_config(win_id)
          config.border = icons.custom_border
          vim.api.nvim_win_set_config(win_id, config)
        end,
      })

      -- copied and trimmed down from linkarzu's dotfiles dude is a legend i swear
      -- https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/config/modules/mini-files-km.lua

      vim.api.nvim_create_autocmd("User", {
        -- Updated pattern to match what Echasnovski has in the documentation
        -- https://github.com/echasnovski/mini.nvim/blob/c6eede272cfdb9b804e40dc43bb9bff53f38ed8a/doc/mini-files.txt#L508-L529
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          local keymaps = opts.custom_keymaps or {}

          wk.add({
            {
              keymaps.copy_to_clipboard,
              function()
                -- Get the current entry (file or directory)
                local curr_entry = mini_files.get_fs_entry()
                if curr_entry then
                  local path = curr_entry.path
                  local safe_path = path:gsub([[\]], [[\\]]):gsub([["]], [[\"]])
                  -- Build the osascript command to copy the file or directory to the clipboard
                  local result = vim.fn.system({
                    "osascript",
                    "-e",
                    string.format([[tell application "Finder" to set the clipboard to (POSIX file "%s")]], safe_path),
                  })
                  if vim.v.shell_error ~= 0 then
                    vim.notify("Copy failed: " .. result, vim.log.levels.ERROR)
                  else
                    vim.notify(vim.fn.fnamemodify(path, ":t"), vim.log.levels.INFO)
                    vim.notify("Copied to system clipboard", vim.log.levels.INFO)
                  end
                else
                  vim.notify("No file or directory selected", vim.log.levels.WARN)
                end
              end,
              buffer = buf_id,
              noremap = true,
              silent = true,
              desc = "[M]Copy file",
              mode = "n",
            },
            {
              keymaps.zip_and_copy,
              function()
                local curr_entry = require("mini.files").get_fs_entry()
                if curr_entry then
                  local path = curr_entry.path
                  local name = vim.fn.fnamemodify(path, ":t") -- Extract the file or directory name
                  local parent_dir = vim.fn.fnamemodify(path, ":h") -- Get the parent directory
                  local timestamp = os.date("%y%m%d%H%M%S") -- Append timestamp to avoid duplicates
                  local zip_path = string.format("/tmp/%s_%s.zip", name, timestamp) -- Path in macOS's tmp directory
                  -- Create the zip file
                  local zip_cmd = string.format(
                    "cd %s && zip -r %s %s",
                    vim.fn.shellescape(parent_dir),
                    vim.fn.shellescape(zip_path),
                    vim.fn.shellescape(name)
                  )
                  local result = vim.fn.system(zip_cmd)
                  if vim.v.shell_error ~= 0 then
                    vim.notify("Failed to create zip file: " .. result, vim.log.levels.ERROR)
                    return
                  end
                  -- Copy the zip file to the system clipboard
                  local copy_cmd = string.format(
                    [[osascript -e 'set the clipboard to POSIX file "%s"' ]],
                    vim.fn.fnameescape(zip_path)
                  )
                  local copy_result = vim.fn.system(copy_cmd)
                  if vim.v.shell_error ~= 0 then
                    vim.notify("Failed to copy zip file to clipboard: " .. copy_result, vim.log.levels.ERROR)
                    return
                  end
                  vim.notify(zip_path, vim.log.levels.INFO)
                  vim.notify("Zipped and copied to clipboard: ", vim.log.levels.INFO)
                else
                  vim.notify("No file or directory selected", vim.log.levels.WARN)
                end
              end,
              buffer = buf_id,
              noremap = true,
              silent = true,
              desc = "[M]Zip & Copy",
              mode = "n",
            },
            {
              keymaps.paste_from_clipboard,
              -- Paste a file or directory from the macOS system clipboard into the current mini.files directory
              -- NOTE: We intentionally avoid pbpaste here; Finder-style "copied files" are stored as alias / NSFilenamesPboardType,
              -- and pbpaste often returns empty for those. We also avoid NSPasteboardURLReadingFileURLsOnlyKey because it errored
              -- in osascript on this setup during debugging.
              function()
                if not mini_files then
                  vim.notify("mini.files module not loaded.", vim.log.levels.ERROR)
                  return
                end
                local curr_entry = mini_files.get_fs_entry() -- Get the current file system entry
                if not curr_entry then
                  vim.notify("Failed to retrieve current entry in mini.files.", vim.log.levels.ERROR)
                  return
                end
                local curr_dir = curr_entry.fs_type == "directory" and curr_entry.path
                  or vim.fn.fnamemodify(curr_entry.path, ":h") -- Use parent directory if entry is a file
                local script = [[
            use framework "AppKit"
            on run
              -- 1) Clipboard as alias covers "copy file" done via Finder-style entries (including our mini.files copy).
              try
                set theFile to the clipboard as alias
                return POSIX path of theFile
              end try
              -- 2) NSFilenamesPboardType covers multi-file copies; coerce to list to avoid AppleScriptObjC ocid errors.
              set pb to current application's NSPasteboard's generalPasteboard()
              try
                set filesList to (pb's propertyListForType:"NSFilenamesPboardType") as list
                if filesList is not missing value then
                  if (count of filesList) > 0 then return (item 1 of filesList) as text
                end if
              end try
              -- 3) Fallback for some apps: file URL stored as a string type.
              try
                set u to pb's stringForType:"public.file-url"
                if u is not missing value then
                  set nsurl to current application's NSURL's URLWithString:u
                  if nsurl is not missing value then return (nsurl's path()) as text
                end if
              end try
              return "error"
            end run
          ]]
                local output = vim.fn.system({ "osascript", "-e", script }) -- Execute AppleScript command
                output = tostring(output):gsub("%s+$", "")
                if vim.v.shell_error ~= 0 or output == "error" or output == "" then
                  vim.notify("Clipboard does not contain a valid file or directory.", vim.log.levels.WARN)
                  return
                end
                local source_path = output
                local dest_path = curr_dir .. "/" .. vim.fn.fnamemodify(source_path, ":t") -- Destination path in current directory
                local copy_cmd = vim.fn.isdirectory(source_path) == 1 and { "cp", "-R", source_path, dest_path }
                  or { "cp", source_path, dest_path } -- Construct copy command
                local result = vim.fn.system(copy_cmd) -- Execute the copy command
                if vim.v.shell_error ~= 0 then
                  vim.notify("Paste operation failed: " .. result, vim.log.levels.ERROR)
                  return
                end
                mini_files.synchronize() -- Refresh mini.files to show updated directory content
                vim.notify("Pasted successfully.", vim.log.levels.INFO)
              end,
              buffer = buf_id,
              noremap = true,
              silent = true,
              desc = "[M]Paste file",
              mode = "n",
            },
            {
              keymaps.copy_path,
              -- Copy the current file or directory path (relative to home) to clipboard
              function()
                local curr_entry = mini_files.get_fs_entry()
                if curr_entry then
                  local home_dir = vim.fn.expand("~")
                  local relative_path = curr_entry.path:gsub("^" .. home_dir, "~")
                  vim.fn.setreg("+", relative_path) -- Copy the relative path to the clipboard register
                  vim.notify(vim.fn.fnamemodify(relative_path, ":t"), vim.log.levels.INFO)
                  vim.notify("Path copied to clipboard: ", vim.log.levels.INFO)
                else
                  vim.notify("No file or directory selected", vim.log.levels.WARN)
                end
              end,
              buffer = buf_id,
              noremap = true,
              silent = true,
              desc = "[M]Copy path",
              mode = "n",
            },
            {
              keymaps.open_with_default_app,
              function()
                local curr_entry = mini_files.get_fs_entry()
                if curr_entry then
                  vim.system({ "open", curr_entry.path }, { stdout = false, stderr = false })
                else
                  vim.notify("No file or directory selected", vim.log.levels.WARN)
                end
              end,
              buffer = buf_id,
              noremap = true,
              silent = true,
              desc = "[M]Open with default app",
              mode = "n",
            },
            {
              keymaps.preview_image,
              -- Preview the selected image in macOS Quick Look
              function()
                local curr_entry = mini_files.get_fs_entry()
                if curr_entry then
                  -- Preview the file using Quick Look
                  vim.system({ "qlmanage", "-p", curr_entry.path }, {
                    stdout = false,
                    stderr = false,
                  })
                  -- Activate Quick Look window after a small delay
                  vim.defer_fn(function()
                    vim.system({ "osascript", "-e", 'tell application "qlmanage" to activate' })
                  end, 200)
                else
                  vim.notify("No file selected", vim.log.levels.WARN)
                end
              end,
              buffer = buf_id,
              noremap = true,
              silent = true,
              desc = "[M]Preview with Quick Look",
              mode = "n",
            },
          })
        end,
      })
    end,
  },
}
