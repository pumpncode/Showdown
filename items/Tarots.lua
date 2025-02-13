SMODS.Atlas({key = "showdown_tarots", path = "Consumables/Tarots.png", px = 71, py = 95})

SMODS.Consumable({ -- The Reflection
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
				if not get_counterpart(G.hand.highlighted[i].base.value) then return false end
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
				assert(SMODS.change_base(G.hand.highlighted[i], nil, get_counterpart(G.hand.highlighted[i].base.value)))
            return true end })
        end
		for i=1, #G.hand.highlighted do unflipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
})

SMODS.Consumable({ -- The Vessel
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
		if pseudorandom("showdown_Probability") < 4 / 5 then
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
})

SMODS.Consumable({ -- The Genie
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
})

SMODS.Consumable({ -- The Lost
	key = 'lost',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	config = { max_highlighted = 1, mod_conv = "m_showdown_ghost" },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_showdown_ghost
		return {vars = {self.config.max_highlighted}}
	end,
    pos = coordinate(4),
})

SMODS.Consumable({ -- The Angel
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
})

SMODS.Consumable({ -- Red Key Piece 1
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
})

SMODS.Consumable({ -- Red Key Piece 2
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
})