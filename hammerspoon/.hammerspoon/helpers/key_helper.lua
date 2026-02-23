local keys = {}

keys.hyper = { "cmd", "ctrl", "alt" }

-- Shallow copy manually
keys.hyper_shift = {}
for i, v in ipairs(keys.hyper) do
	keys.hyper_shift[i] = v
end
table.insert(keys.hyper_shift, "shift")

return keys
