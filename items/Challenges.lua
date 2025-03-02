local bugged = {
    type = 'Challenge',
    order = 1,
    key = '7LB2WVPK',
    deck = {
        type = 'Challenge Deck',
        cards = {},
    },
    rules = {
        custom = {
            { id = 'showdown_bugged_seed' },
        },
    },
    unlocked = function(self)
        return G.P_CENTERS.b_erratic.unlocked
    end,
}

for _=1, 52 do
    table.insert(bugged.deck.cards, { s = 'S', r = 'T' })
end

local all_in_one = {
    type = 'Challenge',
    order = 2,
    key = "all_in_one",
    rules = {
        custom = {
            {id = 'no_shop_jokers'},
            {id = 'showdown_exponential_blinds'},
        },
        modifiers = {
            {id = 'joker_slots', value = 1},
        }
    },
    jokers = {
        {id = 'j_showdown_versatile_joker_all_in_one', eternal = true},
    },
    deck = {
        type = 'Challenge Deck'
    },
    restrictions = {
        banned_cards = {
            {id = 'c_judgement'},
            {id = 'c_wraith'},
            {id = 'c_soul'},
            {id = 'v_antimatter'},
            {id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
            }},
        },
        banned_tags = {
            {id = 'tag_rare'},
            {id = 'tag_uncommon'},
            {id = 'tag_holo'},
            {id = 'tag_polychrome'},
            {id = 'tag_negative'},
            {id = 'tag_foil'},
            {id = 'tag_buffoon'},
            {id = 'tag_top_up'},
        },
        banned_other = {
            {id = 'bl_final_acorn', type = 'blind'},
            {id = 'bl_final_heart', type = 'blind'},
            {id = 'bl_final_leaf', type = 'blind'}
        }
    },
    unlocked = function(self)
        for k, v in pairs(SMODS.Achievements) do
            if k == 'ach_showdown_versatility' then
                return v.earned
            end
        end
    end,
}

return {
	enabled = Showdown.config["Challenges"],
	list = function()
		local list = {
            bugged,
		}
		if Showdown.config["Jokers"]["Versatile"] then
			table.insert(list, all_in_one)
		end
		return list
	end,
}