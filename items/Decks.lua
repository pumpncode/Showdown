local mirror = {
	type = 'Back',
	name = "Mirror Deck",
	key = "Mirror",
	atlas = "showdown_decks",
	pos = coordinate(1),
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				for i = #G.playing_cards, 1, -1 do
					local card = G.playing_cards[i]
					local count = get_counterpart(card.base.value)
					if count then
						assert(SMODS.change_base(card, nil, count))
					elseif card.base.value == 'Ace' then
						assert(SMODS.change_base(card, nil, 'showdown_Zero'))
					end
				end
				return true
			end
		}))
	end
}

local calculus = {
	type = 'Back',
	name = "Calculus Deck",
	key = "Calculus",
	atlas = "showdown_decks",
	pos = coordinate(2),
	config = { vouchers = { "v_showdown_number" }, consumables = {'c_showdown_genie'}, showdown_calculus = true },
	unlocked = false,
	check_for_unlock = function (self, args)
		if G.GAME.consumeable_usage_total and (G.GAME.consumeable_usage_total.mathematic or 0) >= 10 then
			unlock_card(self)
		end
	end,
	apply = function(self, back)
		G.GAME.first_booster_calculus = true
	end
}

local starter = {
	type = 'Back',
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
	end,
	apply = function(self, back)
		if G.GAME.selected_sleeve and G.GAME.selected_sleeve ~= 'sleeve_showdown_Starter' then
			G.GAME.starting_params.dollars = -5
			give_starter()
		end
	end
}

local cheater = {
	type = 'Back',
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
				cards = cards + joker.ability.extra.extra_card
			end
			local ranks = get_all_ranks({onlyFace = true, whitelist = {"showdown_Zero"}})
			local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
			create_cards_in_deck(ranks, suits, cards)
		end
	end,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				local hasZero = false
				local countFaces = {
					['2'] = 'showdown_Lord',
					['3'] = 'showdown_Princess',
					['4'] = 'showdown_Butler',
				}
				for i = #G.playing_cards, 1, -1 do
					local card = G.playing_cards[i]
					if not hasZero and not countFaces[card.base.value] and not card:is_face() then
						assert(SMODS.change_base(card, nil, 'showdown_Zero'))
						hasZero = true
					elseif countFaces[card.base.value] and not G.GAME.starting_params.no_faces then
						assert(SMODS.change_base(card, nil, countFaces[card.base.value]))
					elseif not card:is_face() then
						card:remove()
					end
				end
				return true
			end
		}))
	end
}

local engineer = { -- Not done at all
	type = 'Back',
	name = "Engineer Deck",
	key = "Engineer",
	atlas = "showdown_decks",
	pos = coordinate(5),
	config = { showdown_engineer = true },
	unlocked = false,
	check_for_unlock = function (self, args)
		--
	end,
	apply = function(self, back)
		G.GAME.showdown_engineer = true
	end
}

return {
	enabled = Showdown.config["Decks"],
	list = function()
		local list = {
			starter,
		}
		if Showdown.config["Ranks"] then
			table.insert(list, mirror)
			table.insert(list, cheater)
		end
		if Showdown.config["Consumeables"]["Mathematics"] then
			table.insert(list, calculus)
		end
		if Showdown.config["Tags"]["Switches"] then
			table.insert(list, engineer)
		end
		return list
	end,
	atlases = {
		{key = "showdown_decks", path = "Decks.png", px = 71, py = 95},
	},
	exec = function()
		function give_starter(starter_sleeve)
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.jokers then
						local card = create_card("Joker", G.jokers, nil, starter_sleeve and 1, nil, nil, nil, "showdown_starter")
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
			if G.PROFILES[G.SETTINGS.profile].starter_next_run then
				G.PROFILES[G.SETTINGS.profile].starter_next_run = false
				give_starter()
			end
			if self.effect.config.showdown_cheater then
				G.GAME.showdown_cheater = true
				G.GAME.cheater_destroy_odd = 6
			end
		end
	end
}