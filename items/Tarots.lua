local reflection = {
	type = 'Consumable',
	order = 1,
	key = 'reflection',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	config = {max_highlighted = 2},
	loc_vars = function(self, info_queue)
		info_queue[#info_queue+1] = { key = 'counterpart_ranks', set = 'Other' }
		return {vars = {self.config.max_highlighted}}
	end,
    pos = coordinate(1),
	can_use = function(self)
		if G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1 then
            for i=1, #G.hand.highlighted do
				local card = G.hand.highlighted[i]
				if not SMODS.Ranks[card.base.value].counterpart then return false end
			end
			return true
        end
        return false
    end,
    use = function()
		for i=1, #G.hand.highlighted do flipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
        delay(0.2)
		for i=1, #G.hand.highlighted do
            event({trigger = 'after', delay = 0.1, func = function()
				assert(SMODS.change_base(G.hand.highlighted[i], nil, SMODS.Ranks[G.hand.highlighted[i].base.value].counterpart.value))
            return true end })
        end
		for i=1, #G.hand.highlighted do unflipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
}

local vessel = {
	type = 'Consumable',
	order = 2,
	key = 'vessel',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	config = {max_highlighted = 1},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
    pos = coordinate(2),
	can_use = function()
		if G.hand and #G.hand.highlighted == 1 then
            return true
        end
        return false
    end,
    use = function()
		flipCard(G.hand.highlighted[1], nil, #G.hand.highlighted)
        delay(0.2)
		event({trigger = 'after', delay = 0.1, func = function()
			assert(SMODS.change_base(G.hand.highlighted[1], nil, "showdown_Zero"))
		return true end })
		if pseudorandom("showdown_Probability") < 2 / 3 then
			local cen_pool = getEnhancements({"m_wild"})
			event({trigger = 'after', delay = 0.1, func = function()
				G.hand.highlighted[1]:set_ability(pseudorandom_element(cen_pool, pseudoseed('spe_card')), true);
			return true end })
		else
			event({trigger = 'after', delay = 0.1, func = function()
				G.hand.highlighted[1]:set_seal(SMODS.poll_seal({guaranteed = true}))
			return true end })
		end
		unflipCard(G.hand.highlighted[1], nil, #G.hand.highlighted)
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
}

local genie = {
	type = 'Consumable',
	order = 3,
	key = 'genie',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	config = { create = 1 },
    loc_vars = function(self) return {vars = {self.config.create}} end,
    pos = coordinate(3),
	can_use = function(self, card)
		return #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables
    end,
    use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.consumeable.create, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						play_sound("timpani")
						local _card = create_card("Mathematic", G.consumeables, nil, nil, nil, nil, nil, "showdown_genie")
						_card:add_to_deck()
						G.consumeables:emplace(_card)
						card:juice_up(0.3, 0.5)
					end
					return true
				end,
			}))
		end
		delay(0.6)
    end
}

local lost = {
	type = 'Consumable',
	order = 4,
	key = 'lost',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	config = { max_highlighted = 1, mod_conv = "m_showdown_ghost" },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_showdown_ghost
		return {vars = {self.config.max_highlighted}}
	end,
    pos = coordinate(4),
}

local angel = {
	type = 'Consumable',
	order = 5,
	key = 'angel',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	config = { max_highlighted = 1, mod_conv = "m_showdown_holy" },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_showdown_holy
		return {vars = {self.config.max_highlighted}}
	end,
    pos = coordinate(5),
	can_use = function(self)
		return G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1
    end
}

local red_key_piece_1 = {
	type = 'Consumable',
	order = 6,
	key = 'red_key_piece_1',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	no_collection = true,
    pos = coordinate(6),
	can_use = function(self)
		local lockJ = find_joker('4_locks')[next(find_joker('4_locks'))]
		return next(find_joker('c_showdown_red_key_piece_2')) and lockJ and not lockJ.ability.extra.locks[1]
    end,
    use = function(self, card, area, copier)
		local lockJ = find_joker('4_locks')[next(find_joker('4_locks'))]
		lockJ.ability.extra.locks[1] = true
		find_joker('c_showdown_red_key_piece_2')[next(find_joker('c_showdown_red_key_piece_2'))]:start_dissolve(nil, true)
		forced_message(localize('k_unlocked'), lockJ, G.C.RED, true)
    end,
	in_pool = function(self, args)
		return next(find_joker('4_locks')) and not find_joker('4_locks')[next(find_joker('4_locks'))].ability.extra.locks[1]
	end
}

local red_key_piece_2 = {
	type = 'Consumable',
	order = 7,
	key = 'red_key_piece_2',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	no_collection = true,
    pos = coordinate(7),
	can_use = function(self)
		local lockJ = find_joker('4_locks')[next(find_joker('4_locks'))]
		return next(find_joker('c_showdown_red_key_piece_1')) and lockJ and not lockJ.ability.extra.locks[1]
    end,
    use = function(self, card, area, copier)
		local lockJ = find_joker('4_locks')[next(find_joker('4_locks'))]
		lockJ.ability.extra.locks[1] = true
		find_joker('c_showdown_red_key_piece_1')[next(find_joker('c_showdown_red_key_piece_1'))]:start_dissolve(nil, true)
		forced_message(localize('k_unlocked'), lockJ, G.C.RED, true)
    end,
	in_pool = function(self, args)
		return next(find_joker('4_locks')) and not find_joker('4_locks')[next(find_joker('4_locks'))].ability.extra.locks[1]
	end
}

-- Bunco

local randomExotics = {"bunc_Halberds", "bunc_Fleurons"}

local beast = {
	type = 'Consumable',
	order = 1000,
	key = 'beast',
	set = 'Tarot',
	atlas = 'showdown_buncoTarots',
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize("k_showdown_mysterious_tarot"), get_type_colour(self or card.config, card), nil, 1.2)
    end,
	config = {max_highlighted = 2},
    loc_vars = function(self, info_queue)
		info_queue[#info_queue+1] = { key = 'exotic_cards', set = 'Other' }
		info_queue[#info_queue+1] = { key = 'counterpart_ranks', set = 'Other' }
        return {vars = {self.config.max_highlighted}}
    end,
    pos = coordinate(1),
	can_use = function(self)
		if G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1 then
            return true
        end
        return false
    end,
    use = function()
		enable_exotics()
		local randomCounterparts = get_all_ranks({onlyCounterpart = true})
		for i=1, #G.hand.highlighted do flipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
        delay(0.2)
		for i=1, #G.hand.highlighted do
            event({trigger = 'after', delay = 0.1, func = function()
				assert(SMODS.change_base(G.hand.highlighted[i], randomExotics[math.random(#randomExotics)], randomCounterparts[math.random(#randomCounterparts)]))
            return true end })
        end
		for i=1, #G.hand.highlighted do unflipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
}

return {
	enabled = Showdown.config["Consumeables"]["Tarots"],
	list = function ()
		local list = {}
		if Showdown.config["Ranks"] then
			table.insert(list, reflection)
			table.insert(list, vessel)
			if (SMODS.Mods["Bunco"] or {}).can_load and Showdown.config["CrossMod"]["Bunco"] then
				table.insert(list, beast)
			end
		end
		if Showdown.config["Consumeables"]["Mathematics"] then
			table.insert(list, genie)
		end
		if Showdown.config["Enhancements"] then
			table.insert(list, lost)
			table.insert(list, angel)
		end
		if Showdown.config["Jokers"]["Final"] then
			table.insert(list, red_key_piece_1)
			table.insert(list, red_key_piece_2)
		end
		return list
	end,
	atlases = {
		{key = "showdown_tarots", path = "Consumables/Tarots.png", px = 71, py = 95},
		{key = "showdown_buncoTarots", path = "CrossMod/Bunco/Consumables/Tarots.png", px = 71, py = 95},
	},
}