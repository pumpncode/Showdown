SMODS.Atlas({key = "showdown_decks", path = "Decks.png", px = 71, py = 95})

SMODS.Back{ -- Mirror Deck
	name = "Mirror Deck",
	key = "Mirror",
	atlas = "showdown_decks",
	pos = coordinate(1),
	config = {counterpart_replacing = true},
	loc_vars = function(self)
		return {vars = {self.config.counterpart_replacing, localize{type = 'name_text', set = 'Other', key = 'counterpart_ranks'}}}
	end
}

SMODS.Back{ -- Calculus Deck
	name = "Calculus Deck",
	key = "Calculus",
	atlas = "showdown_decks",
	pos = coordinate(2),
	config = { vouchers = { "v_showdown_number" }, consumables = {'c_showdown_genie'}, showdown_calculus = true },
	unlocked = false,
	check_for_unlock = function (self, args)
		if G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.mathematic >= 10 then
			unlock_card(self)
		end
	end
}

SMODS.Back{ -- Starter Deck
	name = "Starter Deck",
	key = "Starter",
	atlas = "showdown_decks",
	pos = coordinate(3),
	config = { showdown_starter = true },
	unlocked = false,
	check_for_unlock = function (self, args)
		if G.jokers and #G.jokers.cards >= 8 then
			unlock_card(self)
		end
	end
}

SMODS.Back{ -- Cheater Deck
	name = "Cheater Deck",
	key = "Cheater",
	atlas = "showdown_decks",
	pos = coordinate(4),
	config = { showdown_cheater = true },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME and G.GAME.probabilities.normal) or 1 } }
	end,
	unlocked = false,
	check_for_unlock = function (self, args)
		if G.deck and G.deck.config.card_limit >= 80 then
			unlock_card(self)
		end
	end,
	calculate = function(self, card, context)
        if context.post_hand then
			local cards = 1
			for _, joker in pairs(find_joker('versatile_joker')) do
				cards = cards + joker.ability.extra.card
			end
            local ranks = get_all_ranks({onlyFace = true, whitelist = {"showdown_Zero"}})
			local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
			create_cards_in_deck(ranks, suits, cards)
        end
    end
}
--[[
SMODS.Back{ -- Engineer Deck
	name = "Engineer Deck",
	key = "Engineer",
	atlas = "showdown_decks",
	pos = coordinate(5),
	config = { showdown_engineer = true },
	unlocked = false,
	check_for_unlock = function (self, args)
		--
	end
}
]]
local function give_starter()
	G.E_MANAGER:add_event(Event({
		func = function()
			if G.jokers then
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "showdown_starter")
				card:add_to_deck()
				card:start_materialize()
				G.jokers:emplace(card)
				return true
			end
		end,
	}))
	G.E_MANAGER:add_event(Event({
		func = function()
			if G.consumeables then
				local card = create_card(pseudorandom_element(SMODS.ConsumableType.ctype_buffer), G.consumeables, nil, nil, nil, nil, nil, "showdown_starter")
				card:add_to_deck()
				G.consumeables:emplace(card)
				return true
			end
		end,
	}))
	local vouchers = {}
	for _, v in pairs(G.P_CENTER_POOLS.Voucher) do
		if not (v.requires and next(v.requires)) then
			table.insert(vouchers, v.key)
		end
	end
	if next(vouchers) then
		local randomVoucher = pseudorandom_element(vouchers)
		G.GAME.used_vouchers[randomVoucher] = true
		G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
		G.E_MANAGER:add_event(Event({
            func = function()
                Card.apply_to_run(nil, G.P_CENTERS[randomVoucher])
                return true
            end
        }))
	end
end

local Backapply_to_runRef = Back.apply_to_run
function Back:apply_to_run()
	Backapply_to_runRef(self)
	if self.effect.config.showdown_calculus then G.GAME.first_booster_calculus = true end
	if self.effect.config.showdown_starter then
		G.GAME.starting_params.dollars = -5
		give_starter()
	end
	if G.PROFILES[G.SETTINGS.profile].starter_next_run then
		G.PROFILES[G.SETTINGS.profile].starter_next_run = false
		give_starter()
	end
	if self.effect.config.showdown_cheater then G.GAME.cheater_destroy_odd = 6 end
end