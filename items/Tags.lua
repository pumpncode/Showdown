SMODS.Atlas({key = 'showdown_tags', path = 'Tags.png', px = 34, py = 34})

SMODS.Tag({
	key = "green_key",
	atlas = "showdown_tags",
	pos = coordinate(1),
	no_collection = true,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			if next(find_joker('4_locks')) then
				local lockJ = find_joker('4_locks')[next(find_joker('4_locks'))]
				tag:yep("+", G.C.GREEN, function()
					if not lockJ.ability.extra.locks[3] then
						lockJ.ability.extra.locks[3] = true
						forced_message(localize('k_unlocked'), lockJ, G.C.GREEN, true)
					end
					return true
				end)
				tag.triggered = true
				return true
			end
		end
	end,
	in_pool = function(self, args)
		return next(find_joker('4_locks')) and not find_joker('4_locks')[next(find_joker('4_locks'))].ability.extra.locks[3]
	end
})

SMODS.Tag({
	key = "jean_paul",
	atlas = "showdown_tags",
	pos = coordinate(2),
	min_ante = 8,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			if G.jokers then
				local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:yep('+', G.C.GREEN, function()
					local card = create_card("Joker", G.jokers, nil, 0.8, nil, nil, 'j_showdown_jean_paul', 'jean_paul')
					card:add_to_deck()
					G.jokers:emplace(card)
                	G.CONTROLLER.locks[lock] = nil
					check_for_unlock({ type = 'jean_paul_tag' })
                	return true
                end)
			else
				tag:nope()
			end
            tag.triggered = true
            return true
		end
	end
})

SMODS.Tag({
	key = "theorem",
	atlas = "showdown_tags",
	pos = coordinate(3),
	min_ante = 2,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = { set = "Other", key = "p_showdown_calculus_mega", specific_vars = { 2, 4 } }
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			tag:yep("+", G.C.SHOWDOWN_CALCULUS, function()
				local key = "p_showdown_calculus_mega"
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
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
})

SMODS.Tag({
	key = "mystery_switch",
	atlas = "showdown_tags",
	pos = coordinate(11),
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
                    pseudorandom_element(G.P_CENTER_POOLS.Booster, pseudoseed('random_booster')),
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
})

SMODS.Tag({
	key = "money_switch",
	atlas = "showdown_tags",
	pos = coordinate(12),
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
				atlas = 'showdown_tags',
				tag = tag
			}
		end
	end
})

SMODS.Tag({
	key = "nebula_switch",
	atlas = "showdown_tags",
	pos = coordinate(13),
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
})

SMODS.Tag({
	key = "gift_switch",
	atlas = "showdown_tags",
	pos = coordinate(14),
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
					local rand = pseudorandom('gift_switch')
					if rand < 1/3 and G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
						local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'gift_switch')
						card:add_to_deck()
						G.jokers:emplace(card)
					elseif rand < 2/3 and G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
						local card = create_card(pseudorandom_element(SMODS.ConsumableType.ctype_buffer), G.consumeables, nil, nil, nil, nil, nil, 'gift_switch')
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
})

SMODS.Tag({
	key = "burning_switch",
	atlas = "showdown_tags",
	pos = coordinate(15),
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
})

SMODS.Tag({
	key = "duplicate_switch",
	atlas = "showdown_tags",
	pos = coordinate(16),
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
					add_tag(Tag(pseudorandom_element(SMODS.Tag.ctype_buffer).key))
					G.orbital_hand = nil
				end
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
})