local function make_achievement(key, hidden)
	return {
		type = 'Achievement',
		key = key,
		hidden_text = hidden or false,
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
		return list
	end,
}