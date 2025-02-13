local function make_achievement(key, hidden)
	SMODS.Achievement({
		key = key,
		hidden_text = hidden or false,
		unlock_condition = function(self, args)
			if args.type == key then
				return true
			end
		end,
	})
end

make_achievement('get_jean_paul') -- :3
make_achievement('sell_jean_paul', true) -- :(
make_achievement('jean_paul_tag', true) -- :D
make_achievement('jimbodia', true) -- Jimbodia
make_achievement('chains', true) -- Free from the chains
make_achievement('versatility') -- Versatility
make_achievement('blued', true) -- You've been Blue'd!
make_achievement('metal_cap') -- Metal Cap
make_achievement('cronch', true) -- cronch
make_achievement('green_deck_home') -- We have Green Deck at home
--make_achievement('rico_kaboom', true) -- Yes Rico, kaboom
make_achievement('whole_new_deck', true) -- A whole new deck