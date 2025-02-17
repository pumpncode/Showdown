filesystem = NFS or love.filesystem
shdwn = SMODS.current_mod
mod_path = shdwn.path
Showdown.config = shdwn.config

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
		if item and item.enabled then
			if item.exec then item.exec() end
			if item.list then
				local list = item.list()
				for _, obj in ipairs(list) do
					if obj.type and SMODS[obj.type] then
						SMODS[obj.type](obj)
					end
				end
			end
		end
	end
end

function shdwn.save_config(self)
    SMODS.save_mod_config(self)
end

local showdown_config_tab = function()
	return{
		{
		label = localize("showdown_config"),
		chosen = true,
		tab_definition_function = function()
		return {
			n = G.UIT.ROOT,
				config = {
					emboss = 0.05,
					minh = 6,
					r = 0.1,
					minw = 10,
					align = "cm",
					padding = 0.2,
					colour = G.C.BLACK,
				},
				nodes = {
				
					{n=G.UIT.R, config={align = "cm"}, nodes={
						
						{n=G.UIT.R, config={align = "cm"}, nodes={{n = G.UIT.T, config = {text = localize("showdown_config_restart"), colour = G.C.RED, scale = 0.4}}}},
						}},
				
					{n=G.UIT.R, config={align = "cm"}, nodes={ --Base Box containing everything
		
						-- Left Side Column
						{n=G.UIT.C, config={align = "cl", padding = 0.2}, nodes={
							{n=G.UIT.R, config={align = "cl"}, nodes={

								create_toggle({label = localize("showdown_config_ranks"), ref_table = Showdown.config, ref_value = 'Ranks', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_achievements"), ref_table = Showdown.config, ref_value = 'Achievements', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_blinds"), ref_table = Showdown.config, ref_value = 'Blinds', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_decks"), ref_table = Showdown.config, ref_value = 'Decks', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_deckskins"), ref_table = Showdown.config, ref_value = 'DeckSkins', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_enhancements"), ref_table = Showdown.config, ref_value = 'Enhancements', callback = function() shdwn:save_config() end}),

							}},
						}},
						
						-- Middle Side Column
						{n=G.UIT.C, config={align = "cl"}, nodes={
							{n=G.UIT.R, config={align = "cl"}, nodes={
								
								{n=G.UIT.R, config={align = "cm"}, nodes={{n = G.UIT.T, config = {text = localize("showdown_config_jokers_header"), colour = G.C.ORANGE, scale = 0.5}}}},
								create_toggle({label = localize("showdown_config_jokers_normal"), ref_table = Showdown.config["Jokers"], ref_value = 'Normal', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_jokers_jean_paul"), ref_table = Showdown.config["Jokers"], ref_value = 'Jean-Paul', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_jokers_versatile"), ref_table = Showdown.config["Jokers"], ref_value = 'Versatile', callback = function() shdwn:save_config() end}),
							
							}},

							{n=G.UIT.R, config={align = "cl"}, nodes={
								
								{n=G.UIT.R, config={align = "cm"}, nodes={{n = G.UIT.T, config = {text = localize("showdown_config_tags_header"), colour = G.C.ORANGE, scale = 0.5}}}},
								create_toggle({label = localize("showdown_config_tags_classic"), ref_table = Showdown.config["Tags"], ref_value = 'Classic', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_tags_switches"), ref_table = Showdown.config["Tags"], ref_value = 'Switches', callback = function() shdwn:save_config() end}),
							
							}},
						}},
						
						-- Right Side Column
						{n=G.UIT.C, config={align = "cl"}, nodes={
							{n=G.UIT.R, config={align = "cl"}, nodes={
								{n=G.UIT.R, config={align = "cl"}, nodes={
								
									create_toggle({label = localize("showdown_config_vouchers"), ref_table = Showdown.config, ref_value = 'Vouchers', callback = function() shdwn:save_config() end}),
									create_toggle({label = localize("showdown_config_stickers"), ref_table = Showdown.config, ref_value = 'Stickers', callback = function() shdwn:save_config() end}),
								
								}},
								{n=G.UIT.R, config={align = "cl"}, nodes={
								
									{n=G.UIT.R, config={align = "cm"}, nodes={{n = G.UIT.T, config = {text = localize("showdown_config_consumeables_header"), colour = G.C.ORANGE, scale = 0.5}}}},
									create_toggle({label = localize("showdown_config_consumeables_tarots"), ref_table = Showdown.config["Consumeables"], ref_value = 'Tarots', callback = function() shdwn:save_config() end}),
									create_toggle({label = localize("showdown_config_consumeables_spectrals"), ref_table = Showdown.config["Consumeables"], ref_value = 'Spectrals', callback = function() shdwn:save_config() end}),
									create_toggle({label = localize("showdown_config_consumeables_mathematics"), ref_table = Showdown.config["Consumeables"], ref_value = 'Mathematics', callback = function() shdwn:save_config() end}),
									create_toggle({label = localize("showdown_config_consumeables_logics"), ref_table = Showdown.config["Consumeables"], ref_value = 'Logics', callback = function() shdwn:save_config() end}),
								
								}}
							
							}},
						}},
					
					}}
				},
		}
		end
		},
	}
end

shdwn.extra_tabs = showdown_config_tab
shdwn.config_tab = true

---- Mod Compatibility

--[[ if (SMODS.Mods["Bunco"] or {}).can_load then
	modCompatibility("Bunco", "compat/buncoCompat.lua")
end
if (SMODS.Mods["Cryptid"] or {}).can_load then
	modCompatibility("Cryptid", "compat/cryptidCompat.lua")
end ]]