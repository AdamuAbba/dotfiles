
----------------------------------------------------------------------------------------------------
---------------------------------------- Menu Definition -------------------------------------------
----------------------------------------------------------------------------------------------------

local Menu = {}
Menu.__index = Menu

Menu.name = nil
Menu.menuItemDefinitions = nil
Menu.modal = nil
Menu.hotkey = nil
Menu.parentMenu = nil

Menu.menuManager = nil
Menu.numberOfRows = nil
Menu.numberOfColumns = nil

Menu.windowHeight = nil
Menu.entryWidth = nil
Menu.entryHeight = nil

-- Internal function used to find our location, so we know where to load files from
local function scriptPath()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end
MenuItem = dofile(scriptPath() .. "/MenuItem.lua")

----------------------------------------------------------------------------------------------------
-- Constructor
function Menu.new(menuName,
                  modal,
                  parentMenu,
                  hotkey,
                  menuItemDefinitions,
                  menuManager)

    assert(menuName, "Menu name is nil")
    assert(menuItemDefinitions, "Menu " .. menuName .. " has no menu item definitions")
    assert(menuManager, "Menu " .. menuName .. " has nil manager")

    local self = setmetatable({}, Menu)

    self.name = menuName
    self.menuItemDefinitions = menuItemDefinitions
    self.modal = modal
    self.hotkey = hotkey
    self.parentMenu = parentMenu
    self.menuManager = menuManager

    self.menuItems = {}

    self:buildMenu()

    return self
end

----------------------------------------------------------------------------------------------------
----------------------------------------- Modal Access ---------------------------------------------
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Enter the modal
function Menu:enter()
    self.modal:enter()
end

----------------------------------------------------------------------------------------------------
-- Exit the modal
function Menu:exit()
    self.modal:exit()
end

----------------------------------------------------------------------------------------------------
-- Get the keys from the menu modal.
function Menu:keys()
    return self.modal.keys
end

----------------------------------------------------------------------------------------------------
----------------------------------------- Build Menu -----------------------------------------------
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Build the menu
function Menu:buildMenu()

    assert(self.menuItemDefinitions, "Menu " .. self.name .. " has no menu items")
    assert(self.menuManager, "Menu " .. self.name .. " has nil menu manager")

    -- Vertical layout: single column
    self.numberOfColumns = 1
    self.numberOfRows = tableLength(self.menuItemDefinitions)

    -- Make sure we have the minimum number of rows
    if self.numberOfRows < menuMinNumberOfRows then
        self.numberOfRows = menuMinNumberOfRows
    end

    -- Set the window height based on number of items
    self.windowHeight = menuRowHeight * self.numberOfRows

    -- Fixed width from config (in pixels)
    self.entryWidth = menuWidth

    -- Set the entry height as percentage for canvas
    self.entryHeight = 1 / self.numberOfRows

    -- Build the menu items
    self:buildMenuItemList()
    
    -- Bind ESC and DELETE keys directly (not shown in menu but still functional)
    self.modal:bind('', 'escape', 'Exit Menu', function() 
        self.menuManager:closeMenu() 
    end)
    
    if self.parentMenu ~= nil then
        self.modal:bind('', 'delete', 'Parent Menu', function() 
            self.menuManager:switchMenu(self.parentMenu) 
        end)
    end
end

----------------------------------------------------------------------------------------------------
-- Build the list of menu items
function Menu:buildMenuItemList()
    -- Vertical layout: no Exit/Back buttons displayed, no spacers
    -- ESC and DELETE bindings are handled in buildMenu() directly on the modal
    -- Just use the defined menu items directly
    self:createMenuItems()
end

----------------------------------------------------------------------------------------------------
-- Create the menu items
function Menu:createMenuItems()

    local boundKeys = {}

    -- Loop through the menu items
    for index, menuItem in ipairs(self.menuItemDefinitions) do

        -- Adjust the index to 0 indexed
        local adjustedIndex = index - 1

        -- Get the key combo and description
        local category = menuItem[1]
        local modifier = nil
        local key = nil
        local desc
        local commands
        -- Default to closing the menu
        local remainOpen = false
        if category ~= cons.cat.display then
            modifier = menuItem[2]
            key = menuItem[3]
            desc = menuItem[4]
            commands = menuItem[5]
            -- If remain open is set then use it
            if menuItem[6] ~= nil then
                remainOpen = menuItem[6]
            end
        else
            desc = menuItem[2]
            commands = menuItem[3]
        end

        -- Validate that the key isn't already bound on this menu
        if key ~= nil then
            local keyCombo = modifier .. key
            assert(boundKeys[keyCombo] == nil, "Key " .. keyCombo .. " double bound")
            boundKeys[keyCombo] = true
        end

        -- Vertical layout: items stack top to bottom in single column
        local column = 0  -- Always first (and only) column
        local row = adjustedIndex  -- Sequential: 0, 1, 2, 3...

        -- Create the menuItem object
        self:createMenuItem(category,
                            modifier,
                            key,
                            desc,
                            index,
                            row,
                            column,
                            commands,
                            remainOpen)
    end
end

----------------------------------------------------------------------------------------------------
-- Create a single menu item
function Menu:createMenuItem(category,
                             modifier,
                             key,
                             description,
                             index,
                             row,
                             column,
                             commands,
                             remainOpen)

    local newMenuItem = MenuItem.new(category,
                                     modifier,
                                     key,
                                     description,
                                     row,
                                     column,
                                     self.entryWidth,
                                     self.entryHeight,
                                     commands,
                                     self.menuManager,
                                     self)

    assert(newMenuItem, self.name .. " has nil menu item")

    -- Add the menu item to the list
    self.menuItems[index] = newMenuItem

    self:bindToMenu(newMenuItem, function() newMenuItem:runAction() end, remainOpen)
end

----------------------------------------------------------------------------------------------------
-- Bind a single item to the menu
function Menu:bindToMenu(menuItem,
                         pressedFunction,
                         remainOpen)

    if pressedFunction ~= nil then
        assert(type(pressedFunction) == "function",
               "Pressed function is of type " .. type(pressedFunction))
    end

    assert(menuItem, "Menu item is nil")

    -- Alert the menu manager the item was activated
    local preprocessFunction = function() self.menuManager:itemActivated(menuItem.category, remainOpen) end

    local finalFunction = function()

        preprocessFunction()

        -- If a function was provided, run it.
        if pressedFunction ~= nil then
            pressedFunction()
        end
    end

    -- If we have a key defined, bind it
    if menuItem.key ~= nil then
        self.modal:bind(menuItem.modifier,
                        menuItem.key,
                        menuItem:displayTitle(),
                        finalFunction)
    end

end

----------------------------------------------------------------------------------------------------
----------------------------------- Drawing Functions ----------------------------------------------
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Get the frame to put the menu in
function Menu:getMenuFrame()

    local windowHeight = self.windowHeight

    -- Calculate the dimensions using the size of the main screen.
    local cscreen = hs.screen.mainScreen()
    local cres = cscreen:frame()
    
    -- Vertical layout: fixed width, positioned at bottom-left
    local menuFrame = {
        x = cres.x + menuPaddingX,  -- Left edge + padding
        y = cres.y + (cres.h - windowHeight) - menuPaddingY,  -- Bottom edge + padding
        w = menuWidth,  -- Fixed width from config
        h = windowHeight  -- Dynamic based on number of items
    }

    return menuFrame
end

----------------------------------------------------------------------------------------------------
-- Return the canvases to display
function Menu:getMenuDisplay()

    assert(self.menuItems, "Menu " .. self.name .. " has no menu items defined")

    local newCanvases = {}

    -- Loop through each menu item and build them
    for _, menuItem in pairs(self.menuItems) do

        -- Create the background canvas
        local menuItemCanvases = menuItem:getBackgroundCanvas()

        -- Create the text canvas, if necessary
        if menuItem.desc ~= nil then
            table.insert(menuItemCanvases,
                         menuItem:getTextCanvas()
            )
        end

        -- Append the new canvases
        for _, newCanvas in pairs(menuItemCanvases) do table.insert(newCanvases, newCanvas) end
    end

    return newCanvases
end

return Menu
