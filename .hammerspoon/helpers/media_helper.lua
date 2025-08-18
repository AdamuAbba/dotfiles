local m = {}

-- increase volume
local function get_volume()
	---@diagnostic disable-next-line: undefined-field
	local volume = hs.audiodevice.defaultOutputDevice():volume()
	return volume
end

-- helper to send system key events
local function systemKey(key)
	hs.eventtap.event.newSystemKeyEvent(key, true):post()
	hs.timer.usleep(10000)
	hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

-- media controls
m.play_pause = function()
	systemKey("PLAY")
end
m.next_track = function()
	systemKey("NEXT")
end
m.prev_track = function()
	systemKey("PREVIOUS")
end

-- volume controls
m.volume_up = function()
	systemKey("SOUND_UP")
end
m.volume_down = function()
	systemKey("SOUND_DOWN")
end
m.volume_mute = function()
	systemKey("MUTE")
end

---@param level number|nil
m.set_volume = function(level)
	local current = get_volume()
	local new_level = current + level

	-- clamp to [0, 100]
	if new_level < 0 then
		new_level = 0
	elseif new_level > 100 then
		new_level = 100
	end

	---@diagnostic disable-next-line: undefined-field
	hs.audiodevice.defaultOutputDevice():setVolume(new_level)
	hs.alert.show(string.format("🔉 %d%%", get_volume()))
end

return m
