filesystem = NFS or love.filesystem
shdwn = SMODS.current_mod
mod_path = shdwn.path
Showdown.config = shdwn.config

filesystem.load(mod_path.."functions.lua")()
SMODS.Atlas({key = "showdown_modicon", path = "ModIcon.png", px = 36, py = 36})

---Execute a given item. Items can have these params (all paramters are optional):
---- enabled: file will be executed or not
---- exec: code that will be executed **before** loading the list of content
---- post_exec: code that will be executed **after** loading the list of content
---- list: the list of content in this file
---- atlases: the list of atlas that will be loaded for this file
---- class: the class used to load the file content (used for mod compatibilities, SMODS by default)
---@param item any The given item
---@param fileName any The name of the file
local function execute_item(item, fileName)
	if item and item.enabled then
		if not item.class then item.class = SMODS end
		if item.exec then item.exec() end
		if item.atlases then
			for _, atlas in ipairs(item.atlases) do
				SMODS.Atlas(atlas)
			end
		end
		if item.list then
			local load_list = {}
			local list = item.list()
			for _, obj in ipairs(list) do
				if not obj.order then obj.order = 0 end
				if obj.type then
					if item.class[obj.type] then
						table.insert(load_list, obj)
					else
						sendErrorMessage("Error creating "..obj.key.." in file "..fileName..": Type "..(item.type or "nil").." does not exist in class", "Showdown")
					end
				else
					sendErrorMessage("Error creating "..obj.key.." in file "..fileName..": No type was given", "Showdown")
				end
			end
			table.sort(load_list, function(a, b)
				return a.order < b.order
			end)
			for _, obj in ipairs(load_list) do
				item.class[obj.type](obj)
			end
		end
		if item.post_exec then item.post_exec() end
	end
end

local files = filesystem.getDirectoryItems(mod_path.."items/")
for _, file in ipairs(files) do
	sendTraceMessage("Loading file "..file, "Showdown")
	local f, err = SMODS.load_file("Items/" .. file)
	if err then
		--sendErrorMessage("Error loading "..file..": "..err, "Showdown")
		error(err)
	else
		execute_item(f(), file)
	end
end

function shdwn.save_config(self)
    SMODS.save_mod_config(self)
end

local showdown_config_tab = function()
	local cryptid = (SMODS.Mods["Cryptid"] or {}).can_load
	local bunco = (SMODS.Mods["Bunco"] or {}).can_load
	local cardsleeves = (SMODS.Mods["CardSleeves"] or {}).can_load
	return {
		{
		label = localize("showdown_content_config"),
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
				
					{n=G.UIT.R, config={align = "cm"}, nodes={ -- Base Box containing everything
		
						-- Left Side Column
						{n=G.UIT.C, config={align = "cl", padding = 0.2}, nodes={
							{n=G.UIT.R, config={align = "cl"}, nodes={

								create_toggle({label = localize("showdown_config_ranks"), ref_table = Showdown.config, ref_value = 'Ranks', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_achievements"), ref_table = Showdown.config, ref_value = 'Achievements', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_blinds"), ref_table = Showdown.config, ref_value = 'Blinds', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_decks"), ref_table = Showdown.config, ref_value = 'Decks', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_deckskins"), ref_table = Showdown.config, ref_value = 'DeckSkins', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_enhancements"), ref_table = Showdown.config, ref_value = 'Enhancements', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_stakes"), ref_table = Showdown.config, ref_value = 'Stakes', callback = function() shdwn:save_config() end}),

							}},
						}},
						
						-- Middle Side Column
						{n=G.UIT.C, config={align = "cl"}, nodes={
							{n=G.UIT.R, config={align = "cl"}, nodes={
								
								{n=G.UIT.R, config={align = "cm"}, nodes={{n = G.UIT.T, config = {text = localize("showdown_config_jokers_header"), colour = G.C.ORANGE, scale = 0.5}}}},
								create_toggle({label = localize("showdown_config_jokers_normal"), ref_table = Showdown.config["Jokers"], ref_value = 'Normal', callback = function() shdwn:save_config() end}),
								create_toggle({label = localize("showdown_config_jokers_final"), ref_table = Showdown.config["Jokers"], ref_value = 'Final', callback = function() shdwn:save_config() end}),
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
		
		{
			label = localize("showdown_crossmod_config"),
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
						{n=G.UIT.R, config={align = "cm"}, nodes={
							{n=G.UIT.R, config={align = "cm"}, nodes={{n = G.UIT.T, config = {text = localize("showdown_config_unloaded"), colour = G.C.UI.TEXT_INACTIVE, scale = 0.4}}}},
						}},
					
						{n=G.UIT.R, config={align = "cm"}, nodes={ -- Base Box containing everything
			
							{n=G.UIT.C, config={align = "cl", padding = 0.2}, nodes={
								{n=G.UIT.R, config={align = "cl"}, nodes={ -- Don't be fooled, label_color is implemented with a lovely patch (see misc.toml)
	
									create_toggle({label = localize("showdown_config_cryptid"), label_color = cryptid and G.C.UI.TEXT_LIGHT or G.C.UI.TEXT_INACTIVE, ref_table = Showdown.config["CrossMod"], ref_value = 'Cryptid', callback = function() shdwn:save_config() end}),
									create_toggle({label = localize("showdown_config_bunco"), label_color = bunco and G.C.UI.TEXT_LIGHT or G.C.UI.TEXT_INACTIVE, ref_table = Showdown.config["CrossMod"], ref_value = 'Bunco', callback = function() shdwn:save_config() end}),
									create_toggle({label = localize("showdown_config_cardsleeves"), label_color = cardsleeves and G.C.UI.TEXT_LIGHT or G.C.UI.TEXT_INACTIVE, ref_table = Showdown.config["CrossMod"], ref_value = 'CardSleeves', callback = function() shdwn:save_config() end}),
	
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