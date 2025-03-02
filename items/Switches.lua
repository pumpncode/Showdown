local mystery = {
	type = 'Switch',
	order = 1,
	key = "mystery_switch",
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
	key = "money_switch",
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
	key = "nebula_switch",
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
	key = "gift_switch",
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
	key = "burning_switch",
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
	key = "duplicate_switch",
	pos = coordinate(6),
	config = { type = "immediate", tags = 3 },
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.tags } }
	end,
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "immediate" then
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

return {
	enabled = Showdown.config["Tags"]["Switches"],
	list = function ()
		local list = {
			mystery,
			money,
			nebula,
			gift,
			burning,
			duplicate,
		}
		return list
	end,
	atlases = {
		{key = 'showdown_switches', path = 'Switches.png', px = 34, py = 34},
	},
	exec = function()
		SMODS.Switch = SMODS.Tag:extend{
			atlas = 'showdown_switches',
			set = 'Switch',
		}
		G.P_CENTER_POOLS.Switch = {}
	end,
}