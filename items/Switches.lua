local mystery = {
	type = 'Switch',
	order = 1,
	key = "mystery",
	pos = coordinate(1),
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			tag:yep("+", G.C.SWITCH, function()
				local card = Card(
                    G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                    G.CARD_W * 1.27,
                    G.CARD_H * 1.27,
                    G.P_CARDS.empty,
                    pseudorandom_element(G.P_CENTER_POOLS.Booster, pseudoseed('mystery')),
                    { bypass_discovery_center = true, bypass_discovery_ui = true }
                )
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = card } })
                card:start_materialize()
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local money = {
	type = 'Switch',
	order = 2,
	key = "money",
	pos = coordinate(2),
	config = { type = "eval", triggers = 4, dollars = 5 },
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.dollars, tag.config.triggers } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "eval" then
			tag.config.triggers = tag.config.triggers - 1
			if tag.config.triggers == 0 then
				tag:yep(localize('ph_money_switch_end'), G.C.SWITCH, function()
					return true
				end)
				tag.triggered = true
			end
			return {
				dollars = tag.config.dollars,
				condition = localize('ph_money_switch'),
				pos = tag.pos,
				atlas = 'showdown_switches',
				tag = tag
			}
		end
	end
}

local nebula = {
	type = 'Switch',
	order = 3,
	key = "nebula",
	pos = coordinate(3),
	config = { type = "immediate", triggers = 3 },
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.triggers } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local hands = {}
			for k, _ in pairs(G.GAME.hands) do
				table.insert(hands, k)
			end
			tag:yep("+", G.C.SWITCH, function()
				for _=1, tag.config.triggers do
					local randomIdx = math.random(1, #hands)
					local randomHand = hands[randomIdx]
					update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(randomHand, 'poker_hands'),chips = G.GAME.hands[randomHand].chips, mult = G.GAME.hands[randomHand].mult, level=G.GAME.hands[randomHand].level})
					level_up_hand(nil, randomHand)
					update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
					table.remove(hands, randomIdx)
				end
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local gift = {
	type = 'Switch',
	order = 4,
	key = "gift",
	pos = coordinate(4),
	config = { type = "immediate", money = 10 },
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.money } }
	end,
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.SWITCH, function()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					local rand = pseudorandom('gift')
					if rand < 1/3 and G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
						local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'gift')
						card:add_to_deck()
						G.jokers:emplace(card)
					elseif rand < 2/3 and G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
						local card = create_card(pseudorandom_element(SMODS.ConsumableType.ctype_buffer), G.consumeables, nil, nil, nil, nil, nil, 'gift')
						card:add_to_deck()
						G.consumeables:emplace(card)
					else
						ease_dollars(tag.config.money, true)
					end
					return true
				end
			}))
			tag.triggered = true
			return true
		end
	end
}

local burning = {
	type = 'Switch',
	order = 5,
	key = "burning",
	pos = coordinate(5),
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.SWITCH, function()
				G.GAME.burning_double_hands = true
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local duplicate = {
	type = 'Switch',
	order = 6,
	key = "duplicate",
	pos = coordinate(6),
	config = { type = "tag_add", tags = 3 },
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.tags } }
	end,
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "tag_add" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLUE,function()
				for _=1, tag.config.tags do
					add_tag(Tag(pseudorandom_element(SMODS.Tag.obj_table, pseudoseed('duplicate_switch')).key))
					G.orbital_hand = nil
				end
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local souvenir = {
	type = 'Switch',
	order = 7,
	key = "souvenir",
	pos = coordinate(7),
	config = { type = "immediate" },
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLUE,function()
				print('bleeeeeh :P')
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local vacuum = {
	type = 'Switch',
	order = 8,
	key = "vacuum",
	pos = coordinate(8),
	config = { type = "immediate", dollars = 4 },
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.dollars } }
	end,
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLUE,function()
				local vacuum_money = 0
				for i = #G.GAME.tags-1, 1, -1 do
					G.GAME.tags[i]:yep('-', G.C.BLUE,function()
						return true
					end)
					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
							vacuum_money = vacuum_money + tag.config.dollars
							return true
						end
					}))
				end
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
						ease_dollars(vacuum_money)
						return true
					end
				}))
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local conversion = {
	type = 'Switch',
	order = 9,
	key = "conversion",
	pos = coordinate(9, 8),
	config = { type = "tag_add" },
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "tag_add" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLUE,function()
				local tag_key = context.tag.key
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
						for i = #G.GAME.tags, 1, -1 do
							local _tag = G.GAME.tags[i]
							if _tag.key and _tag.key ~= tag_key then _tag:change_tag(tag_key) end
							delay(0.5)
						end
						return true
					end
				}))
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local splendid = {
	type = 'Switch',
	order = 10,
	key = "splendid",
	pos = coordinate(10, 8),
	config = { type = "immediate" },
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local can_apply_to_jokers = {}
			if G.jokers and G.jokers.cards then
				for _, v in ipairs(G.jokers.cards) do
					if not v.edition and findInTable(G.GAME.edition_buffer_cards, v) == -1 then table.insert(can_apply_to_jokers, v) end
				end
			end
			if not G.GAME.edition_buffer_cards then
				G.GAME.edition_buffer_cards = {}
			end
			if #can_apply_to_jokers - #G.GAME.edition_buffer_cards > 0 then
				local joker = can_apply_to_jokers[math.random(#can_apply_to_jokers)]
				table.insert(G.GAME.edition_buffer_cards, joker)
				tag:yep('+', G.C.BLUE,function()
					local edition = poll_edition('splendid_switch', nil, true, true)
					if edition then joker:set_edition(edition)
					else print('No edition was polled with Splendid Switch') end
					table.remove(G.GAME.edition_buffer_cards, findInTable(joker, G.GAME.edition_buffer_cards))
					return true
				end)
			end
			tag.triggered = true
			return true
		end
	end
}

local void = {
	type = 'Switch',
	order = 11,
	key = "void",
	pos = coordinate(11, 8),
	config = { type = "immediate" },
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLUE,function()
				local can_apply_to_jokers = {}
				local can_destroy_jokers = {}
				if G.jokers and G.jokers.cards then
					for _, v in ipairs(G.jokers.cards) do
						if not v.edition then table.insert(can_apply_to_jokers, v) end
						if not v.ability.eternal then table.insert(can_destroy_jokers, v) end
					end
				end
				if #can_apply_to_jokers > 0 and #can_destroy_jokers > 0 then
					local joker = can_destroy_jokers[math.random(#can_destroy_jokers)]
					if findInTable(joker, can_apply_to_jokers) ~= -1 then
						table.remove(joker)
					end
					if #can_apply_to_jokers > 0 then
						tag:yep('+', G.C.BLUE,function()
							play_sound('tarot1')
							joker:start_dissolve(nil, true)
							can_apply_to_jokers[math.random(#can_apply_to_jokers)]:set_edition({negative = true})
							return true
						end)
					else tag:nope()
					end
				else tag:nope()
				end
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local playing = {
	type = 'Switch',
	order = 12,
	key = "playing",
	pos = coordinate(12, 8),
	config = { type = "immediate", cards_generated = 4 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLUE,function()
				local ranks = get_all_ranks()
				local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
				for _=1, tag.config.cards_generated do
					create_card_in_deck(
						pseudorandom_element(ranks, pseudoseed('playing')),
						pseudorandom_element(suits, pseudoseed('playing'))
					)
				end
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local numbered = {
	type = 'Switch',
	order = 13,
	key = "numbered",
	pos = coordinate(13, 8),
	config = { type = "immediate", cards_generated = 2 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLUE,function()
				local ranks = get_all_ranks({noFace = true})
				local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
				for _=1, tag.config.cards_generated do
					create_card_in_deck(
						pseudorandom_element(ranks, pseudoseed('playing')),
						pseudorandom_element(suits, pseudoseed('playing'))
					)
				end
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local royal = {
	type = 'Switch',
	order = 14,
	key = "royal",
	pos = coordinate(14, 8),
	config = { type = "immediate", cards_generated = 2 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLUE,function()
				local ranks = get_all_ranks({onlyFace = true})
				local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
				for _=1, tag.config.cards_generated do
					create_card_in_deck(
						pseudorandom_element(ranks, pseudoseed('playing')),
						pseudorandom_element(suits, pseudoseed('playing'))
					)
				end
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local decimal = {
	type = 'Switch',
	order = 15,
    activated = { Showdown.config["Ranks"] },
	key = "decimal",
	pos = coordinate(15, 8),
	config = { type = "immediate", cards_generated = 2 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'counterpart_ranks'}
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLUE,function()
				local ranks = get_all_ranks({onlyCounterpart = true})
				local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
				for _=1, tag.config.cards_generated do
					create_card_in_deck(
						pseudorandom_element(ranks, pseudoseed('playing')),
						pseudorandom_element(suits, pseudoseed('playing'))
					)
				end
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local top = {
	type = 'Switch',
	order = 16,
	key = "top",
	pos = coordinate(16, 8),
	config = { type = "immediate", cards_generated = 2 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLUE,function()
				local ranks = get_all_ranks({noVanilla = true, noModded = true, whitelist = {'Ace'}})
				local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
				for _=1, tag.config.cards_generated do
					create_card_in_deck(
						pseudorandom_element(ranks, pseudoseed('playing')),
						pseudorandom_element(suits, pseudoseed('playing'))
					)
				end
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local buffoon = {
	type = 'Switch',
	order = 17,
	key = "buffoon",
	pos = coordinate(17, 8),
	config = { type = "immediate", cards_generated = 2 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
				tag:yep('+', G.C.BLUE,function()
					local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'buffoon')
					card:add_to_deck()
					G.jokers:emplace(card)
					G.GAME.joker_buffer = G.GAME.joker_buffer - 1
					for _=2, tag.config.cards_generated do
						if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
							card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'buffoon')
							card:add_to_deck()
							G.jokers:emplace(card)
						end
					end
					return true
				end)
			else tag:nope()
			end
			tag.triggered = true
			return true
		end
	end
}

local destiny = {
	type = 'Switch',
	order = 18,
	key = "destiny",
	pos = coordinate(18, 8),
	config = { type = "immediate", cards_generated = 2 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
				tag:yep('+', G.C.BLUE,function()
					local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'destiny')
					card:add_to_deck()
					G.consumeables:emplace(card)
					for _=2, tag.config.cards_generated do
						if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
							card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'destiny')
							card:add_to_deck()
							G.consumeables:emplace(card)
						end
					end
					return true
				end)
			else tag:nope()
			end
			tag.triggered = true
			return true
		end
	end
}

local exoplanet = {
	type = 'Switch',
	order = 19,
	key = "exoplanet",
	pos = coordinate(19, 8),
	config = { type = "immediate", cards_generated = 2 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
				tag:yep('+', G.C.BLUE,function()
					local card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'exoplanet')
					card:add_to_deck()
					G.consumeables:emplace(card)
					for _=2, tag.config.cards_generated do
						if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
							card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'exoplanet')
							card:add_to_deck()
							G.consumeables:emplace(card)
						end
					end
					return true
				end)
			else tag:nope()
			end
			tag.triggered = true
			return true
		end
	end
}

local summoning = {
	type = 'Switch',
	order = 20,
	key = "summoning",
	pos = coordinate(20, 8),
	config = { type = "immediate", cards_generated = 2 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
				tag:yep('+', G.C.BLUE,function()
					local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'summoning')
					card:add_to_deck()
					G.consumeables:emplace(card)
					for _=2, tag.config.cards_generated do
						if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
							card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'summoning')
							card:add_to_deck()
							G.consumeables:emplace(card)
						end
					end
					return true
				end)
			else tag:nope()
			end
			tag.triggered = true
			return true
		end
	end
}

local parabola = {
	type = 'Switch',
	order = 21,
    activated = { Showdown.config["Consumeables"]["Mathematics"] },
	key = "parabola",
	pos = coordinate(21, 8),
	config = { type = "immediate", cards_generated = 2 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
				tag:yep('+', G.C.BLUE,function()
					local card = create_card('Mathematic', G.consumeables, nil, nil, nil, nil, nil, 'parabola')
					card:add_to_deck()
					G.consumeables:emplace(card)
					for _=2, tag.config.cards_generated do
						if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
							card = create_card('Mathematic', G.consumeables, nil, nil, nil, nil, nil, 'parabola')
							card:add_to_deck()
							G.consumeables:emplace(card)
						end
					end
					return true
				end)
			else tag:nope()
			end
			tag.triggered = true
			return true
		end
	end
}

local operation = {
	type = 'Switch',
	order = 22,
    activated = { Showdown.config["Consumeables"]["Logics"] },
	key = "operation",
	pos = coordinate(22, 8),
	config = { type = "immediate", cards_generated = 2 },
    loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.cards_generated } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
				tag:yep('+', G.C.BLUE,function()
					local card = create_card('Label', G.consumeables, nil, nil, nil, nil, nil, 'operation')
					card:add_to_deck()
					G.consumeables:emplace(card)
					for _=2, tag.config.cards_generated do
						if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
							card = create_card('Label', G.consumeables, nil, nil, nil, nil, nil, 'operation')
							card:add_to_deck()
							G.consumeables:emplace(card)
						end
					end
					return true
				end)
			else tag:nope()
			end
			tag.triggered = true
			return true
		end
	end
}

local execute = {
	type = 'Switch',
	order = 23,
	key = "execute",
	pos = coordinate(26, 8),
	config = { type = "store_joker_create" },
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then -- change context to store_joker_modify
			local card = create_card('Joker', context.area, nil, nil, nil, nil, nil, 'execute')
			create_shop_card_ui(card, 'Joker', context.area)
			card.states.visible = false
			tag:yep('+', G.C.BLUE,function()
				card:start_materialize()
				card.ability.eternal = true
				card.ability.couponed = true
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
	end
}

local encore = {
	type = 'Switch',
	order = 24,
	key = "encore",
	pos = coordinate(28, 8),
	config = { type = "store_joker_create" },
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" and G.GAME.encore_card then
			local card = SMODS.create_card({
				set = G.GAME.encore_card.set,
				area = context.area,
				key = G.GAME.encore_card.key,
				enhancement = G.GAME.encore_card.enhancement,
				seal = G.GAME.encore_card.seal,
				edition = G.GAME.encore_card.edition,
				stickers = G.GAME.encore_card.stickers
			})
			create_shop_card_ui(card, G.GAME.encore_card.set, context.area)
			card.states.visible = false
			G.GAME.encore_card = nil
			tag:yep('+', G.C.BLUE,function()
				card:start_materialize()
				return true
			end)
			tag.triggered = true
			return card
		end
	end
}

local offering = {
	type = 'Switch',
	order = 25,
	key = "offering",
	pos = coordinate(29, 8),
	config = { type = "shop_final_pass" },
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "shop_final_pass" and G.shop then
			tag:yep('+', G.C.BLUE,function()
				if G.shop_vouchers then
					for _, v in pairs(G.shop_vouchers.cards) do
						v.ability.couponed = true
						v:set_cost()
					end
				end
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

local mega_mystery = {
	type = 'Switch',
	order = 26,
	key = "mega_mystery",
	pos = coordinate(27, 8),
	config = { type = "immediate", tags = 2 },
    loc_vars = function(self, info_queue, tag)
        --info_queue[#info_queue+1] = {set = 'Switch', key = 'tag_showdown_mystery'}
		return { vars = { tag.config.tags } }
	end,
	min_ante = 1,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep('+', G.C.BLUE,function()
				for _=1, tag.config.tags do
					add_tag(Tag('tag_showdown_mystery'))
				end
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

return {
	enabled = Showdown.config["Tags"]["Switches"],
	list = {
		mystery,
		money,
		nebula,
		gift,
		burning,
		duplicate,
		--souvenir,
		vacuum,
		conversion,
		splendid,
		void,
		playing,
		numbered,
		royal,
		decimal,
		top,
		buffoon,
		destiny,
		exoplanet,
		summoning,
		parabola,
		operation,
		execute,
		encore,
		offering,
		mega_mystery,
	},
	atlases = {
		{key = 'showdown_switches', path = 'Switches.png', px = 34, py = 34},
	},
	exec = function()
		G.P_CENTER_POOLS['Switch'] = {}
		Showdown.Switch = SMODS.Tag:extend{
			atlas = 'showdown_switches',
			set = 'Switch',
			inject = function(self)
				if not G.P_CENTER_POOLS[self.set] then G.P_CENTER_POOLS[self.set] = {} end
				SMODS.Tag.inject(self)
			end,
		}

		function Tag:change_tag(new_key) -- needs to be finished
			local idx
			for i=1, #G.HUD_tags do
				if G.HUD_tags[i] == self.HUD_tag then idx = i end
				break
			end
			if idx ~= nil then
				self:init(new_key, nil, self.ability._blind_type)
				play_sound('other1')
				self:juice_up(0.05, 0.02)
				HUD_tag = UIBox{
					definition = {n=G.UIT.ROOT, config={align = "cm",padding = 0.05, colour = G.C.CLEAR}, nodes={
						self:generate_UI()
					}},
					config = {
						align = G.HUD_tags[idx].config.align,
						offset = G.HUD_tags[idx].config.offset,
						major = G.HUD_tags[idx].config.major,
					}
				}
				G.HUD_tags[idx] = HUD_tag
				self.HUD_tag = HUD_tag
			end
			-- particles here
		end

		local new_roundRef = new_round
		function new_round()
			G.GAME.encore_card = nil
			new_roundRef()
		end
	end,
	order = 1,
    class = Showdown,
}