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
local function execute_item(item)
	if item and item.enabled then
		if not item.class then item.class = SMODS end
		if item.exec then item.exec() end
		if item.atlases then
			for _, atlas in ipairs(item.atlases) do
				SMODS.Atlas(atlas)
			end
		end
		if item.list and (type(item.list) == 'function' or type(item.list) == 'table') then
			local load_list = {}
			for _, obj in ipairs(type(item.list) == 'function' and item.list() or item.list) do
				if not obj.activated or obj.activated[1] then
					if not obj.order then obj.order = 0 end
					if obj.type then
						if item.class[obj.type] then
							table.insert(load_list, obj)
						else
							sendErrorMessage("Error creating "..obj.key.." in file "..item.fileName..": Type "..(item.type or "nil").." does not exist in class", "Showdown")
						end
					else
						sendErrorMessage("Error creating "..obj.key.." in file "..item.fileName..": No type was given", "Showdown")
					end
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
local sortedItems = {}
for _, file in ipairs(files) do
	sendTraceMessage("Loading file "..file, "Showdown")
	local f, err = SMODS.load_file("Items/" .. file)
	if err then
		--sendErrorMessage("Error loading "..file..": "..err, "Showdown")
		error(err)
	else
		local result = f()
		result.fileName = file
		if not result.order then result.order = 0 end
		table.insert(sortedItems, result)
	end
end
table.sort(sortedItems, function(a, b)
	return a.order < b.order
end)
for _, item in ipairs(sortedItems) do
	execute_item(item)
end

function shdwn.save_config(self)
    SMODS.save_mod_config(self)
end

local function create_config_toggle(loc, value, category)
	return create_toggle({label = localize(loc), ref_table = category and Showdown.config[category] or Showdown.config, ref_value = value, callback = function() shdwn:save_config() end})
end

local function create_config_header(loc)
	return {n=G.UIT.R, config={align = "cm"}, nodes={{n = G.UIT.T, config = {text = localize(loc), colour = G.C.ORANGE, scale = 0.5}}}}
end

local Gamemain_menu = Game.main_menu
local function main_menu(change_context)
	local ret = Gamemain_menu(change_context)
		local newcard = Card(
			G.title_top.T.x,
			G.title_top.T.y,
			G.CARD_W,
			G.CARD_H,
			G.P_CARDS.empty,
			G.P_CENTERS.j_showdown_jean_paul,
			{ bypass_discovery_center = true }
		)
		G.title_top.T.w = G.title_top.T.w * 1.7675
		G.title_top.T.x = G.title_top.T.x - 0.8
		G.title_top:emplace(newcard)
		newcard.T.w = newcard.T.w * 1.1 * 1.2
		newcard.T.h = newcard.T.h * 1.1 * 1.2
		newcard.no_ui = true
		newcard.states.visible = false
		SMODS.giveSpeech(newcard) -- Crashes if speech bubble disappear while dragging jean-paul (only in main menu)

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0,
			blockable = false,
			blocking = false,
			func = function()
				if change_context == "splash" then
					newcard.states.visible = true
					newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 2.5)
				else
					newcard.states.visible = true
					newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
				end
				return true
			end,
		}))

		return ret
end
Game.main_menu = main_menu

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

								create_config_toggle('showdown_config_ranks', 'Ranks'),
								create_config_toggle('showdown_config_achievements', 'Achievements'),
								create_config_toggle('showdown_config_blinds', 'Blinds'),
								create_config_toggle('showdown_config_decks', 'Decks'),
								create_config_toggle('showdown_config_deckskins', 'DeckSkins'),
								create_config_toggle('showdown_config_enhancements', 'Enhancements'),
								create_config_toggle('showdown_config_stakes', 'Stakes'),

							}},
						}},
						
						-- Middle Side Column
						{n=G.UIT.C, config={align = "cl"}, nodes={
							{n=G.UIT.R, config={align = "cl"}, nodes={
								
								create_config_header('showdown_config_jokers_header'),
								create_config_toggle('showdown_config_jokers_normal', 'Normal', 'Jokers'),
								create_config_toggle('showdown_config_jokers_final', 'Final', 'Jokers'),
								create_config_toggle('showdown_config_jokers_jean_paul', 'Jean-Paul', 'Jokers'),
								create_config_toggle('showdown_config_jokers_versatile', 'Versatile', 'Jokers'),
							
							}},

							{n=G.UIT.R, config={align = "cl"}, nodes={
								
								create_config_header('showdown_config_tags_header'),
								create_config_toggle('showdown_config_tags_classic', 'Classic', 'Tags'),
								create_config_toggle('showdown_config_tags_switches', 'Switches', 'Tags'),
							
							}},
						}},
						
						-- Right Side Column
						{n=G.UIT.C, config={align = "cl"}, nodes={
							{n=G.UIT.R, config={align = "cl"}, nodes={
								{n=G.UIT.R, config={align = "cl"}, nodes={
								
									create_config_toggle('showdown_config_vouchers', 'Vouchers'),
									create_config_toggle('showdown_config_stickers', 'Stickers'),
									create_config_toggle('showdown_config_challenges', 'Challenges'),
								
								}},
								{n=G.UIT.R, config={align = "cl"}, nodes={
								
									create_config_header('showdown_config_consumeables_header'),
									create_config_toggle('showdown_config_consumeables_tarots', 'Tarots', 'Consumeables'),
									create_config_toggle('showdown_config_consumeables_spectrals', 'Spectrals', 'Consumeables'),
									create_config_toggle('showdown_config_consumeables_mathematics', 'Mathematics', 'Consumeables'),
									create_config_toggle('showdown_config_consumeables_logics', 'Logics', 'Consumeables'),
								
								}}
							
							}},
						}},
					
					}}
				},
		}
		end
		},
		
		{
			label = localize("showdown_technical_config"),
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
					
						{n=G.UIT.R, config={align = "cm"}, nodes={ -- Base Box containing everything
			
							{n=G.UIT.C, config={align = "cl", padding = 0.2}, nodes={
								{n=G.UIT.R, config={align = "cl"}, nodes={

									create_config_toggle('showdown_config_easter_eggs', 'Easter Eggs', 'Technical'),
									create_slider({label = localize("showdown_config_engineer_versatile_weight_limit"), w = 4, h = 0.4, ref_table = Showdown.config["Technical"], ref_value = 'Engineer Versatile Weight Limit', min = 50, max = 200}),
	
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