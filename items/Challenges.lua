local vanilla_challenges_restrictions = {
    ['c_omelette_1'] = {
        banned_cards = {
            {id = 'j_showdown_golden_roulette'},
            {id = 'j_showdown_red_coins'},
            {id = 'j_showdown_money_cutter'},
            {id = 'j_showdown_jimbocoin'},
        },
        banned_tags = {},
        banned_other = {}
    },
    ['c_non_perishable_1'] = {
        banned_cards = {
            {id = 'j_showdown_golden_roulette'},
            {id = 'j_showdown_nitroglycerin'},
            {id = 'j_showdown_banana'},
            {id = 'j_showdown_label'},
            {id = 'j_showdown_yipeee'},
            {id = 'j_showdown_whatever'},
            {id = 'j_showdown_mouthwash'},
            {id = 'j_showdown_infection'},
        },
        banned_tags = {},
        banned_other = {}
    },
    ['c_fragile_1'] = {
        banned_cards = {
            {id = 'c_showdown_vessel'},
            {id = 'c_showdown_lost'},
            {id = 'c_showdown_angel'},
            {id = 'c_showdown_vision'},
            {id = 'c_showdown_constant'},
            {id = 'c_showdown_function'},
            {id = 'c_showdown_nimply'},
            {id = 'j_showdown_strainer'},
        },
        banned_tags = {
            {id = 'tag_showdown_playing'},
            {id = 'tag_showdown_numbered'},
            {id = 'tag_showdown_royal'},
            {id = 'tag_showdown_decimal'},
            {id = 'tag_showdown_top'},
            {id = 'tag_showdown_mystery'},
            {id = 'tag_showdown_mega_mystery'},
        },
        banned_other = {
            {id = 'bl_showdown_shameful', type = 'blind'},
        }
    },
    ['c_blast_off_1'] = {
        banned_cards = {
            {id = 'j_showdown_shady_dealer'},
            {id = 'j_showdown_versatile_joker_challenge_restriction', ids = {'j_showdown_versatile_joker'}},
        },
        banned_tags = {},
        banned_other = {}
    },
    ['c_golden_needle_1'] = {
        banned_cards = {
            {id = 'j_showdown_shady_dealer'},
            {id = 'j_showdown_versatile_joker_challenge_restriction', ids = {'j_showdown_versatile_joker'}},
        },
        banned_tags = {},
        banned_other = {}
    },
    ['c_jokerless_1'] = {
        banned_cards = {
            {id = 'p_showdown_boolean_1', ids = {
                'p_showdown_boolean_1', 'p_showdown_boolean_2', 'p_showdown_boolean_jumbo', 'p_showdown_boolean_mega',
            }},
        },
        banned_tags = {
            {id = 'tag_showdown_logical'},
            {id = 'tag_showdown_gift'},
            {id = 'tag_showdown_buffoon'},
            {id = 'tag_showdown_execute'},
            {id = 'tag_showdown_mystery'},
            {id = 'tag_showdown_mega_mystery'},
        },
        banned_other = {}
    },
}

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
            {id = 'tag_showdown_gift'},
            {id = 'tag_showdown_buffoon'},
            {id = 'tag_showdown_execute'},
            {id = 'tag_showdown_mystery'},
            {id = 'tag_showdown_mega_mystery'},
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
            {id = 'c_strength'},
            {id = 'c_familiar'},
            {id = 'c_grim'},
            {id = 'c_incantation'},
            {id = 'c_sigil'},
            {id = 'c_showdown_operation'},
            {id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1','p_standard_normal_2','p_standard_normal_3','p_standard_normal_4','p_standard_jumbo_1','p_standard_jumbo_2','p_standard_mega_1','p_standard_mega_2',
            }},
        },
        banned_tags = {
            {id = 'tag_standard'},
            {id = 'tag_showdown_playing'},
            {id = 'tag_showdown_numbered'},
            {id = 'tag_showdown_royal'},
            {id = 'tag_showdown_decimal'},
            {id = 'tag_showdown_top'},
            {id = 'tag_showdown_mystery'},
            {id = 'tag_showdown_mega_mystery'},
        },
        banned_other = {
            {id = 'bl_showdown_ceiling', type = 'blind'},
        }
    },
}

local shifting_strategy = {
    type = 'Challenge',
    order = 4,
    key = "shifting_strategy",
    rules = {
        custom = {
            {id = 'showdown_rules_card_all'},
        },
        modifiers = {
            {id = 'joker_slots', value = 2},
        }
    },
    jokers = {
        {id = 'j_showdown_rules_card', eternal = true, edition = 'negative'},
        {id = 'j_showdown_rules_card', eternal = true, edition = 'negative'},
        {id = 'j_showdown_rules_card', eternal = true, edition = 'negative'},
        {id = 'j_showdown_rules_card', eternal = true, edition = 'negative'},
        {id = 'j_showdown_rules_card', eternal = true, edition = 'negative'},
    },
}

return {
	enabled = Showdown.config["Challenges"],
	list = function()
		local list = {
            bugged,
            shifting_strategy,
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
        for id, restrictions in pairs(vanilla_challenges_restrictions) do
            for _, challenge in ipairs(G.CHALLENGES) do
                if challenge.id == id then
                    if not challenge.restrictions then challenge.restrictions = {} end
                    for ban, cards in pairs(restrictions) do
                        if not challenge.restrictions[ban] and #cards > 0 then challenge.restrictions[ban] = {} end
                        for _, card in ipairs(cards) do
                            table.insert(challenge.restrictions[ban], card)
                        end
                    end
                    break
                end
            end
        end

		if (SMODS.Mods["Bunco"] or {}).can_load then
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_showdown_beast'})
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_bunc_universe'})
			table.insert(empty_deck.restrictions.banned_tags, {id = 'tag_bunc_filigree'})
			table.insert(empty_deck.restrictions.banned_other, {id = 'bl_bunc_tine', type = 'blind'})
			table.insert(empty_deck.restrictions.banned_other, {id = 'bl_bunc_cadaver', type = 'blind'})
			table.insert(empty_deck.restrictions.banned_other, {id = 'bl_bunc_final_crown', type = 'blind'})
		end
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
		if (SMODS.Mods["MoreFluff"] or {}).can_load then
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_mf_deepblue'})
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_mf_seaweed'})
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_mf_red'})
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_mf_orange'})
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_mf_rot_strength'})
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_mf_rot_star'})
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_mf_rot_moon'})
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_mf_rot_sun'})
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_mf_rot_world'})
			table.insert(empty_deck.restrictions.banned_cards, {id = 'c_showdown_rot_reflection'})
            if (SMODS.Mods["Bunco"] or {}).can_load then
                table.insert(empty_deck.restrictions.banned_cards, {id = 'c_showdown_rot_beast'})
            end
		end
	end
}