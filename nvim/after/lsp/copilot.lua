---@param bufnr integer,
---@param client vim.lsp.Client
local function sign_in(bufnr, client)
  client:request(
    ---@diagnostic disable-next-line: param-type-mismatch
    "signIn",
    vim.empty_dict(),
    function(err, result)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      if result.command then
        local code = result.userCode
        local command = result.command
        vim.fn.setreg("+", code)
        vim.fn.setreg("*", code)
        local continue = vim.fn.confirm(
          "Copied your one-time code to clipboard.\n" .. "Open the browser to complete the sign-in process?",
          "&Yes\n&No"
        )
        if continue == 1 then
          client:exec_cmd(command, { bufnr = bufnr }, function(cmd_err, cmd_result)
            if cmd_err then
              vim.notify(cmd_err.message, vim.log.levels.ERROR)
              return
            end
            if cmd_result.status == "OK" then
              vim.notify("Signed in as " .. cmd_result.user .. ".")
            end
          end)
        end
      end

      if result.status == "PromptUserDeviceFlow" then
        vim.notify("Enter your one-time code " .. result.userCode .. " in " .. result.verificationUri)
      elseif result.status == "AlreadySignedIn" then
        vim.notify("Already signed in as " .. result.user .. ".")
      end
    end
  )
end

---@param client vim.lsp.Client
local function sign_out(_, client)
  client:request(
    ---@diagnostic disable-next-line: param-type-mismatch
    "signOut",
    vim.empty_dict(),
    function(err, result)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      if result.status == "NotSignedIn" then
        vim.notify("Not signed in.")
      end
    end
  )
end

---@type vim.lsp.Config
return {
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspCopilotSignIn", function()
      sign_in(bufnr, client)
    end, { desc = "Sign in Copilot with GitHub" })
    vim.api.nvim_buf_create_user_command(bufnr, "LspCopilotSignOut", function()
      sign_out(bufnr, client)
    end, { desc = "Sign out Copilot with GitHub" })

    -- Disable Copilot completion for some files "Need to get off the AI high somehow"
    -- list would increase with time till I'm clean and my brain works like it used to again.
    local exclude_filetypes = { "rust" }
    local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr, scope = "local" })
    for _, excluded in ipairs(exclude_filetypes) do
      if ft == excluded then
        client:stop()
        return
      end
    end
  end,
  -- handlers = {
  --   didChangeStatus = function(err, res, ctx)
  --     if err then
  --       return
  --     end
  --     ---@diagnostic disable-next-line: undefined-global
  --     status[ctx.client_id] = res.kind ~= "Normal" and "error" or res.busy and "pending" or "ok"
  --     if res.status == "Error" then
  --       LazyVim.error("Please use `:LspCopilotSignIn` to sign in to Copilot")
  --     end
  --   end,
  -- },
}
