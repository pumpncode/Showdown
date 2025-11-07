local bugged = {
    type = 'Challenge',
    order = 1,
    key = '7LB2WVPK',
    rules = {
        custom = {
            { id = 'showdown_bugged_seed' },
        },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {},
    },
    restrictions = {
        banned_cards = {},
        banned_tags = {},
        banned_other = {}
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

local empty_deck = {
    type = 'Challenge',
    order = 3,
    key = "empty_deck",
    rules = {
        custom = {
            {id = 'showdown_all_zero'},
        },
    },
    jokers = {
        {id = 'j_showdown_nothing_matter', eternal = true},
        {id = 'j_showdown_pinpoint', eternal = true},
    },
    vouchers = {
        {id = 'v_magic_trick'},
        {id = 'v_illusion'},
    },
    deck = {
        type = 'Challenge Deck',
        cards = {{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},{s='D',r='showdown_Z'},}, -- doesn't work
    },
    restrictions = {
        banned_cards = {
            {id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1','p_standard_normal_2','p_standard_normal_3','p_standard_normal_4','p_standard_jumbo_1','p_standard_jumbo_2','p_standard_mega_1','p_standard_mega_2',
            }},
        },
        banned_tags = {
            {id = 'tag_standard'},
            {id = 'tag_showdown_playing'},
        },
        banned_other = {
            {id = 'bl_showdown_ceiling', type = 'blind'},
        }
    },
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
		if Showdown.config["Ranks"] then
			table.insert(list, empty_deck)
		end
		return list
	end,
	exec = function()
		if (SMODS.Mods["UnStable"] or {}).can_load then
			table.insert(empty_deck.restrictions.banned_cards, {id = 'p_unstb_prem_1', ids = {
                'p_unstb_prem_1','p_unstb_prem_2','p_unstb_prem_jumbo','p_unstb_prem_mega',
            }})
		end
		if (SMODS.Mods["StrangePencil"] or {}).can_load then
			table.insert(empty_deck.restrictions.banned_cards, {id = 'p_pencil_clubs'})
			table.insert(empty_deck.restrictions.banned_tags, {id = 'tag_pencil_clubs'})
		end
		if (SMODS.Mods["pta_saka"] or {}).can_load then
            for _, ban in ipairs(empty_deck.restrictions.banned_cards) do
                if ban.id == 'p_standard_normal_1' then
                    print('abcd')
                    table.insert(ban.ids, 'p_payasaka_standard_ultra')
                end
            end
		end
	end
}