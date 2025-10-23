local order_nb = 0
local function make_achievement(key, hidden)
	order_nb = order_nb + 1
	return {
		type = 'Achievement',
		order = order_nb,
		key = key,
		hidden_text = hidden or false,
		bypass_all_unlocked = true,
		--reset_on_startup = true,
		unlock_condition = function(self, args)
			if args.type == key then
				return true
			end
		end,
	}
end

local get_jean_paul = make_achievement('get_jean_paul') -- :3
local sell_jean_paul = make_achievement('sell_jean_paul', true) -- :(
local jean_paul_tag = make_achievement('jean_paul_tag', true) -- :D
local jimbodia = make_achievement('jimbodia', true) -- Jimbodia
local chains = make_achievement('chains', true) -- Free from the chains
local versatility = make_achievement('versatility') -- Versatility
local blued = make_achievement('blued', true) -- You've been Blue'd!
local metal_cap = make_achievement('metal_cap') -- Metal Cap
local cronch = make_achievement('cronch', true) -- cronch
local green_deck_home = make_achievement('green_deck_home') -- We have Green Deck at home
local rico_kaboom = make_achievement('rico_kaboom', true) -- Yes Rico, kaboom
local whole_new_deck = make_achievement('whole_new_deck', true) -- A whole new deck
local minecraft_reference = make_achievement('minecraft_reference', true) -- How did we get here?
local completionist = make_achievement('completionist', true) -- Completionist+++
local you_can_stop_now = make_achievement('you_can_stop_now', true) -- ok you can stop now

return {
	enabled = Showdown.config["Achievements"],
	list = function()
		local list = {}
		if Showdown.config["Jokers"]["Jean-Paul"] then
			table.insert(list, get_jean_paul)
			table.insert(list, sell_jean_paul)
			table.insert(list, jean_paul_tag)
		end
		if Showdown.config["Jokers"]["Versatile"] then
			table.insert(list, versatility)
		end
		if Showdown.config["Jokers"]["Normal"] then
			table.insert(list, jimbodia)
			table.insert(list, chains)
			table.insert(list, blued)
			table.insert(list, metal_cap)
			table.insert(list, cronch)
			table.insert(list, green_deck_home)
			--table.insert(list, rico_kaboom)
			table.insert(list, whole_new_deck)
		end
		if Showdown.config["Vouchers"] then
			table.insert(list, minecraft_reference)
		end
		if Showdown.config["Stakes"] then
			--table.insert(list, completionist)
			--table.insert(list, you_can_stop_now)
		end
		return list
	end,
	exec = function ()
		function Showdown.versatility_description(ach)
			ach.config.speech_bubble_align = {align='tm', offset = {x=0,y=0},parent = ach}
			ach.children.speech_bubble = UIBox{
				definition = Showdown.speech_bubble('versatility_desc_bruh', 'quips', nil, true),
				config = ach.config.speech_bubble_align
			}
			ach.children.speech_bubble:set_role{
				role_type = 'Major',
				xy_bond = 'Strong',
				r_bond = 'Strong',
				major = ach,
			}
			--[[
			if not G.PROFILES[G.SETTINGS.profile].versatility then G.PROFILES[G.SETTINGS.profile].versatility = {} end
			local no_versatile_deck = {}
			local decks = {}
			for k, v in pairs(G.P_CENTERS) do
				if v.set == 'Back' and findInTable(v.name, G.PROFILES[G.SETTINGS.profile].versatility) == -1 then
					decks[k] = v
				end
			end
			table.sort(decks, function(a, b)
				return a.order < b.order
			end)
			for k, v in pairs(decks) do
				if v.unlocked then
					table.insert(no_versatile_deck, {
						--type = 'name_text',
						type = 'name',
						set = 'Back',
						key = k
					})
				else
					table.insert(no_versatile_deck, {
						type = 'quips',
						key = 'using_unknown_8', -- i reused a jean-paul quip lol
					})
				end
			end
			ach.config.speech_bubble_align = {align='tm', offset = {x=0,y=0},parent = ach}
			ach.children.speech_bubble = UIBox{
				definition = Showdown.speech_bubble('versatility_desc', 'quips', nil, true, no_versatile_deck),
				config = ach.config.speech_bubble_align
			}
			ach.children.speech_bubble:set_role{
				role_type = 'Major',
				xy_bond = 'Strong',
				r_bond = 'Strong',
				major = ach,
			}
			]]--
		end
	end
}