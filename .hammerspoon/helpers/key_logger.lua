local M = {}

local function logModifiers(mods)
	local active = {}
	for mod, pressed in pairs(mods) do
		if pressed then
			table.insert(active, mod)
		end
	end
	if #active > 0 then
		print("Modifiers active: " .. table.concat(active, " + "))
	end
end

M.keyTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
	local keyCode = event:getKeyCode()
	local keyChar = hs.keycodes.map[keyCode]
	print("Key pressed: ", keyChar or keyCode)
	return false
end)

M.flagTap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
	logModifiers(event:getFlags())
	return false
end)

return M
