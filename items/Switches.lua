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
				print('bleeeeeh :P')
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

local numbered = {
	type = 'Switch',
	order = 13,
	key = "numbered",
	pos = coordinate(13, 8),
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

local royal = {
	type = 'Switch',
	order = 14,
	key = "royal",
	pos = coordinate(14, 8),
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

local decimal = {
	type = 'Switch',
	order = 15,
	key = "decimal",
	pos = coordinate(15, 8),
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

local top = {
	type = 'Switch',
	order = 16,
	key = "top",
	pos = coordinate(16, 8),
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

local buffoon = {
	type = 'Switch',
	order = 17,
	key = "buffoon",
	pos = coordinate(17, 8),
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
			souvenir,
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
		}
		return list
	end,
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
			self:init(new_key)
			play_sound('other1')
			self:juice_up(0.05, 0.02)
			local idx
			for i=1, #G.HUD_tags do
				if G.HUD_tags[i] == self.HUD_tag then idx = i end
				break
			end
			if idx ~= nil then
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
	end,
	order = 1,
    class = Showdown,
}