local green_key = {
	type = 'Tag',
	order = 1,
	key = "green_key",
	atlas = "showdown_tags",
	shiny_atlas = "showdown_tags_shiny",
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
}

local jean_paul = {
	type = 'Tag',
	order = 2,
	key = "jean_paul",
	atlas = "showdown_tags",
	shiny_atlas = "showdown_tags_shiny",
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
}

local theorem = {
	type = 'Tag',
	order = 3,
	key = "theorem",
	atlas = "showdown_tags",
	shiny_atlas = "showdown_tags_shiny",
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
}

local logical = {
	type = 'Tag',
	order = 4,
	key = "logical",
	atlas = "showdown_tags",
	shiny_atlas = "showdown_tags_shiny",
	pos = coordinate(4),
	min_ante = 2,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = { set = "Other", key = "p_showdown_boolean_mega", specific_vars = { 2, 5 } }
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			tag:yep("+", G.C.SHOWDOWN_CALCULUS, function()
				local key = "p_showdown_boolean_mega"
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
}

return {
	enabled = Showdown.config["Tags"]["Classic"],
	list = function ()
		local list = {}
		if Showdown.config["Jokers"]["Final"] then
			table.insert(list, green_key)
		end
		if Showdown.config["Jokers"]["Jean-Paul"] then
			table.insert(list, jean_paul)
		end
		if Showdown.config["Consumeables"]["Mathematics"] then
			table.insert(list, theorem)
		end
		if Showdown.config["Consumeables"]["Logics"] then
			table.insert(list, logical)
		end
		return list
	end,
	atlases = {
		{key = 'showdown_tags', path = 'Tags.png', px = 34, py = 34},
		{key = "showdown_tags_shiny", path = "CrossMod/Cryptid/TagsShiny.png", px = 34, py = 34, mod_compat = "Cryptid"},
	},
}