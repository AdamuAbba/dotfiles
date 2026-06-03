local M = {}

--- Absolute path to the user's home directory
M.HOME = os.getenv("HOME") or ""

--- Path to the user's custom scripts directory
M.SCRIPTS = M.HOME .. "/.config/scripts"

--- Path to the dotfiles directory
M.DOTFILES = M.HOME .. "/Documents/dotfiles"

--- Sends a mode update notification using Sketchybar
---@param msg string Message to display in the notification
function M:update_mode(msg)
  os.execute(self.SCRIPTS .. "/sketchybar/show_notification.sh '" .. msg .. "'")
end

M.colors = {
  background = "#000000",
  current_line = "#44475a",
  selection = "#44475a",
  foreground = "#f8f8f2",
  comment = "#6272a4",
  cyan = "#80D6E7",
  green = "#404F3C",
  orange = "#ffb86c",
  glossy_pink = "#DD29D4",
  pink = "#ff79c6",
  purple = "#bd93f9",
  red = "#ff0000",
  -- red = "#ff5555",
  yellow = "#f1fa8c",
  white = "#ffffff",
  black = "#000000",
}

M.hex_to_rgb = function(hex)
  hex = hex:gsub("#", "")
  local r = tonumber(hex:sub(1, 2), 16) / 255
  local g = tonumber(hex:sub(3, 4), 16) / 255
  local b = tonumber(hex:sub(5, 6), 16) / 255
  return { red = r, green = g, blue = b, alpha = 1 }
end

function M.colors:to_rgb()
  local rgb_table = {}
  for name, hex in pairs(self) do
    if type(hex) == "string" then
      rgb_table[name] = M.hex_to_rgb(hex)
    end
  end
  return rgb_table
end

function M:nerd_alert(msg, opts)
  opts = opts or {}
  local styled = hs.styledtext.new(msg, {
    font = { name = "IosevkaInput", size = opts.size or 30 },
    color = opts.color or self.colors:to_rgb().white,
    traits = { bold = true },
  })
  local function with_alpha(rgb, a)
    rgb.alpha = a
    return rgb
  end
  hs.alert.show(styled, {
    strokeColor = with_alpha(self.colors:to_rgb().white, 1),
    fillColor = with_alpha(self.colors:to_rgb().black, 1),
    textStyle = {},
    radius = 8,
  }, opts.screen, opts.duration or 2)
end

function M:restartFrontmostApp()
  local frontApp = hs.application.frontmostApplication()
  if not frontApp then
    return
  end

  local appName = frontApp:name()
  local bundleID = frontApp:bundleID()
  if not bundleID then
    return
  end

  self:nerd_alert("󰜉 Restarting " .. appName)

  frontApp:kill9()
  hs.timer.doAfter(1, function()
    hs.application.launchOrFocusByBundleID(bundleID)
  end)
end

function M:maximizeAppWindow()
  local frontApp = hs.application.frontmostApplication()
  if not frontApp then
    return
  end

  local bundleID = frontApp:bundleID()
  if not bundleID then
    return
  end

  hs.timer.doAfter(0.2, function()
    if frontApp:mainWindow():isMaximizable() then
      frontApp:mainWindow():maximize(0.2)
    end
  end)
end

function M:toggleFullScreen()
  local frontApp = hs.application.frontmostApplication()
  if not frontApp then
    return
  end

  local bundleID = frontApp:bundleID()
  if not bundleID then
    return
  end

  hs.timer.doAfter(0.2, function()
    frontApp:mainWindow():toggleFullScreen()
  end)
end
--- Reloads the Hammerspoon configuration and saves the bundle ID of the currently active
--- application to a file for later restoration
M.reloadHSConfig = function()
  local frontmost = hs.application.frontmostApplication()
  local bundleID = frontmost and frontmost:bundleID()
  if bundleID then
    local f = io.open(os.getenv("HOME") .. "/.hammerspoon_last_app.txt", "w")
    if f then
      f:write(bundleID)
      f:close()
    end
  end
  hs.reload()
end

M.initFocus = function()
  hs.timer.doAfter(1, function()
    local f = io.open(os.getenv("HOME") .. "/.hammerspoon_last_app.txt", "r")
    if f then
      local bundleID = f:read("*l")
      f:close()
      if bundleID and #bundleID > 0 then
        local app = hs.application.get(bundleID)
        if app then
          app:activate(true, true)
        end
      end
    end
  end)
end
return M
