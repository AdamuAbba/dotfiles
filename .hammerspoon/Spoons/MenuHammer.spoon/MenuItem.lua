----------------------------------------------------------------------------------------------------
------------------------------------ Menu Item Definition ------------------------------------------
----------------------------------------------------------------------------------------------------

local MenuItem = {}
MenuItem.__index = MenuItem

MenuItem.category = nil
MenuItem.modifier = {}
MenuItem.key = nil
MenuItem.desc = nil
MenuItem.args = {}

MenuItem.row = nil
MenuItem.column = nil

MenuItem.xValue = nil
MenuItem.yValue = nil
MenuItem.width = nil
MenuItem.height = nil

MenuItem.textColor = nil
MenuItem.backgroundColor = nil

MenuItem.commands = nil
MenuItem.menuManager = nil
MenuItem.menu = nil

-- Internal function used to find our location, so we know where to load files from
local function scriptPath()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end
MenuAction = dofile(scriptPath() .. "/MenuAction.lua")

----------------------------------------------------------------------------------------------------
-- Constructor
function MenuItem.new(category, modifier, key, desc, row, column, width, height, commands, menuManager, menu)
	assert(desc ~= nil, "Description is nil")
	assert(category, "Category name is nil")
	assert(row, desc .. " row is nil")
	assert(column, desc .. " column is nil")

	local self = setmetatable({}, MenuItem)

	self.category = category
	self.modifier = modifier
	self.key = key
	self.desc = desc
	self.row = row
	self.column = column
	self.height = tostring(height)

	-- Vertical layout: use percentage-based positioning within the fixed-width canvas
	self.width = "100%"  -- Full width of menu container
	self.xValue = "0%"   -- Always at left edge (single column)
	self.yValue = tostring(height * row)  -- Sequential vertical positioning

	self.commands = commands
	self.menuManager = menuManager
	self.menu = menu

	return self
end

----------------------------------------------------------------------------------------------------
-- Convert modifier keys to symbols
function MenuItem:modifierToSymbol()
	if self.modifier == nil or self.modifier == "" then
		return ""
	end
	
	local symbols = {
		shift = "⇧",
		cmd = "⌘",
		alt = "⌥",
		ctrl = "⌃",
	}
	
	-- Handle string modifier (e.g., "shift")
	if type(self.modifier) == "string" then
		return symbols[self.modifier] or ""
	end
	
	-- Handle table of modifiers (e.g., {"cmd", "shift"})
	if type(self.modifier) == "table" then
		local result = ""
		for _, mod in ipairs(self.modifier) do
			result = result .. (symbols[mod] or "")
		end
		return result
	end
	
	return ""
end

function MenuItem:prefix()
	local prefix = menuItemPrefix[self.category]

	assert(prefix ~= nil, "No prefix found for " .. self.desc .. " with category " .. self.category)

	return prefix
end

function MenuItem:displayTitle()
	return self:prefix() .. " " .. self.desc
end

----------------------------------------------------------------------------------------------------
-- Select background canvas
function MenuItem:getBackgroundCanvas()
	return {
		{
			type = "rectangle",
			action = "fill",
			-- NOTE:
			-- alpha is 0 to make entire text background transparent
			-- all indiviual background color settings in `MenuConfigDefauls.lua`
			-- are ignored
			fillColor = { hex = self:backgroundColor(), alpha = 0 },
			frame = {
				x = self.xValue,
				y = self.yValue,
				w = self.width,
				h = self.height,
			},
		},
	}
end

----------------------------------------------------------------------------------------------------
-- Select text canvas
function MenuItem:getTextCanvas()
	assert(menuItemFont, "Can't get menu item font")
	assert(menuItemFontSize, "Can't get menu item font size")
	assert(menuItemTextAlign, "Can't get menu item text align")

	return {
		type = "text",
		text = " " .. self:getWhichKeyDisplayText(),
		textFont = menuItemFont,
		textSize = menuItemFontSize,
		textColor = { hex = self:textColor(), alpha = 1 },
		textAlignment = menuItemTextAlign,
		textLineBreak = "clip",
		frame = {
			x = self.xValue,
			y = self.yValue,
			w = self.width,
			h = self.height,
		},
	}
end

----------------------------------------------------------------------------------------------------
-- Format display text in WhichKey style: "⇧a: + Description" or "a: Description"
function MenuItem:getWhichKeyDisplayText()
	-- Handle display-only items (no keybinding)
	if self.category == cons.cat.display then
		local displayString = nil
		for _, command in ipairs(self.commands) do
			displayString = command()
		end
		return displayString or self.desc
	end
	
	-- Build the key portion with modifier symbols
	local modSymbol = self:modifierToSymbol()
	local keyPart = ""
	
	if self.key ~= nil then
		-- Align on the key letter, modifiers extend to the left
		-- Keys without modifiers get leading space so letters align
		local hasModifier = #modSymbol > 0
		if hasModifier then
			keyPart = modSymbol .. self.key .. " │ "
		else
			keyPart = "  " .. self.key .. " │ "
		end
	end
	
	-- Add prefix for submenus (+ symbol)
	local prefix = ""
	if self.category == cons.cat.submenu then
		prefix = self:prefix() .. ""
	end
	
	return keyPart .. prefix .. self.desc
end

----------------------------------------------------------------------------------------------------
-- Select menu item background color
function MenuItem:backgroundColor()
	if self.category == nil then
		print("Received nil item category.  Defaulting background color.")
		return menuItemColors.default.background
	end

	return menuItemColors[self.category].background
end

----------------------------------------------------------------------------------------------------
-- Select menu item color
function MenuItem:textColor()
	if self.category == nil then
		print("Received nil item category.  Defaulting text color.")
		return menuItemColors.default.text
	end

	return menuItemColors[self.category].text
end

----------------------------------------------------------------------------------------------------
-- Get a function to perform the needed action(s).
function MenuItem:getActionFunction(desc, command)
	assert(desc, self.desc .. " sent a nil desc")

	local menuAction = MenuAction.new(desc, command, self.menu)

	return menuAction:getActionFunction()
end

----------------------------------------------------------------------------------------------------
-- Run menu item action
function MenuItem:runAction()
	local commandFunctions = {}

	-- Loop through the commands
	if self.commands ~= nil then
		for _, command in ipairs(self.commands) do
			local menuItemAction = command[1]
			local subMenuName = command[2]

			-- If the command is to load a menu, ensure the menu exists.
			if menuItemAction == cons.act.menu then
				assert(subMenuName, self.desc .. " has nil submenu identifier")
				assert(
					self.menuManager:checkMenuExists(subMenuName),
					"Menu " .. self.desc .. " has submenu " .. subMenuName .. " which does not exist"
				)
			end
			table.insert(commandFunctions, self:getActionFunction(self.desc, command))
		end
	end

	local finalFunction = function()
		for _, commandFunction in ipairs(commandFunctions) do
			-- If command returns false, don't process any more
			if not commandFunction() then
				break
			end
		end
	end

	finalFunction()
end

----------------------------------------------------------------------------------------------------
-- Get the display value to show
function MenuItem:getDisplayValue()
	if self.category ~= cons.cat.display then
		return self.desc
	else
		local displayString = nil
		for _, command in ipairs(self.commands) do
			displayString = command()
		end
		return displayString
	end
end

return MenuItem
