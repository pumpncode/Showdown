filesystem = NFS or love.filesystem
mod_path = SMODS.current_mod.path

filesystem.load(mod_path.."functions.lua")()
SMODS.Atlas({key = "showdown_modicon", path = "ModIcon.png", px = 36, py = 36})

local files = filesystem.getDirectoryItems(mod_path.."items/")
for _, file in ipairs(files) do
	sendTraceMessage("Loading file "..file, "Showdown")
	local f, err = SMODS.load_file("Items/" .. file)
	if err then
		sendErrorMessage("Error loading file: "..err, "Showdown")
	else
		local item = f()
	end
end

---- Mod Compatibility

--[[ if (SMODS.Mods["Bunco"] or {}).can_load then
	modCompatibility("Bunco", "compat/buncoCompat.lua")
end
if (SMODS.Mods["Cryptid"] or {}).can_load then
	modCompatibility("Cryptid", "compat/cryptidCompat.lua")
end ]]