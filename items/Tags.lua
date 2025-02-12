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