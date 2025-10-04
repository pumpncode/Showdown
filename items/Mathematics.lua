local consumeable_type = {
	type = 'ConsumableType',
    key = 'Mathematic',
    primary_colour = G.C.SHOWDOWN_CALCULUS,
    secondary_colour = G.C.SHOWDOWN_CALCULUS_DARK,
    collection_rows = {4, 4}
}

local undiscovered_sprite = {
	type = 'UndiscoveredSprite',
    key = 'Mathematic',
    atlas = 'showdown_mathematic_undiscovered',
    pos = coordinate(1)
}

local constant = {
	type = 'Consumable',
	order = 1,
	key = 'constant',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
    pos = coordinate(1),
	config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        return G.hand and #G.hand.highlighted == self.config.max_highlighted and #G.hand.cards >= 2
    end,
    use = function()
		local card = G.hand.highlighted[1]
		local rank = card:get_id()
		local toEnhance = {}
		for i=1, #G.hand.cards do
			local _card = G.hand.cards[i]
			if
				_card ~= card
				and _card:get_id() == rank
				--and _card.ability.effect == "Base"
			then
				toEnhance[#toEnhance+1] = _card
			end
		end
		event({trigger = 'after', delay = 0.1, func = function() mathDestroyCard(card) return true end })
        delay(0.2)
		for i=1, #toEnhance do flipCard(toEnhance[i], i, #toEnhance) end
        delay(0.2)
		local cen_pool = getEnhancements(rank == 1 and {"m_wild"} or {})
		for i=1, #toEnhance do
            event({trigger = 'after', delay = 0.1, func = function()
				toEnhance[i]:set_ability(pseudorandom_element(cen_pool, pseudoseed('spe_card')), true)
            return true end })
        end
		for i=1, #toEnhance do unflipCard(toEnhance[i], i, #toEnhance) end
    end
}

local variable = {
	type = 'Consumable',
	order = 2,
	key = 'variable',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
    pos = coordinate(2),
	config = {max_highlighted = 3, minMoney = 0, maxMoney = 6},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted, self.config.minMoney, self.config.maxMoney}} end,
	can_use = function(self)
        return #G.hand.highlighted >= 1 and #G.hand.highlighted <= self.config.max_highlighted
    end,
    use = function(self)
		local money = 0
		for i=#G.hand.highlighted, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function()
				mathDestroyCard(G.hand.highlighted[i], {nil, i == #G.hand.highlighted})
			return true end })
			money = money + math.random(self.config.minMoney, self.config.maxMoney)
        end
		delay(0.6)
		if money > 0 then ease_dollars(money) end
    end
}

local func = {
	type = 'Consumable',
	order = 3,
	key = 'function',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
    pos = coordinate(3),
	config = {max_highlighted = 4, toDestroy = 1},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted, self.config.toDestroy}} end,
	can_use = function(self)
        return G.hand and #G.hand.highlighted == self.config.max_highlighted
    end,
    use = function(self)
		for i=1, #G.hand.highlighted do flipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
		local cen_pool = getEnhancements()
		local cen_pool_zero = getEnhancements({"m_wild"})
		for i=1, #G.hand.highlighted do
			local _card = G.hand.highlighted[i]
            event({trigger = 'after', delay = 0.1, func = function()
				_card:set_ability(pseudorandom_element(SMODS.is_zero(_card) and cen_pool_zero or cen_pool, pseudoseed('spe_card')), true);
            return true end })
        end
        delay(0.2)
		for i=self.config.toDestroy, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function()
				local card = pseudorandom_element(G.hand.highlighted, pseudoseed('seed'))
				if mathDestroyCard(card) then table.remove(G.hand.highlighted, findInTable(card, G.hand.highlighted)) end
            return true end })
        end
		for i=1, #G.hand.highlighted do unflipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
}

local shape = {
	type = 'Consumable',
	order = 4,
	key = 'shape',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
    pos = coordinate(4),
	config = {max_highlighted = 4, toDestroy = 2},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted, self.config.toDestroy}} end,
	can_use = function(self)
        if G.hand and #G.hand.highlighted == self.config.max_highlighted then
            return true
        end
        return false
    end,
    use = function(self)
		for i=1, #G.hand.highlighted do
            event({trigger = 'after', delay = 0.1, func = function()
				local edition = poll_edition(nil, nil, nil, true); G.hand.highlighted[i]:set_edition(edition, true);
            return true end })
        end
        delay(0.2)
		for i=self.config.toDestroy, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function()
				local card = pseudorandom_element(G.hand.highlighted, pseudoseed('seed'))
				if mathDestroyCard(card, {nil, i == 1}) then table.remove(G.hand.highlighted, findInTable(card, G.hand.highlighted)) end
            return true end })
        end
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
}

local vector = {
	type = 'Consumable',
	order = 5,
	key = 'vector',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
    pos = coordinate(5),
	config = {max_highlighted = 2},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted, (G.GAME and G.GAME.showdown_vector or 0)}} end,
	can_use = function(self)
        if G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1 then
            return true
        end
        return false
    end,
    use = function()
		G.GAME.showdown_vector = (G.GAME.showdown_vector or 0) + #G.hand.highlighted
		for i=#G.hand.highlighted, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function() mathDestroyCard(G.hand.highlighted[i], {nil, i == #G.hand.highlighted}) return true end })
        end
    end
}

local function joker_probability_compat(jonkler)
	if not jonkler then return false end
	return true
end

local probability = {
	type = 'Consumable',
	order = 6,
	key = 'probability',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
    pos = coordinate(6),
	config = {max_highlighted = 3, mult_joker = 1.25, extra = { initial_odds = 2, odds = 5 }},
    loc_vars = function(self, info_queue, card)
		return { vars = {self.config.max_highlighted, self.config.mult_joker, G.GAME.probabilities.normal * self.config.extra.initial_odds, self.config.extra.odds} }
	end,
	can_use = function(self)
        if G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1 and #G.jokers.cards >= 1 then
            return joker_probability_compat(G.jokers.cards[1])
        end
        return false
    end,
    use = function(self, card, area, copier)
		local first_dissolved = true
		local joker = G.jokers.cards[1]
		for i=#G.hand.highlighted, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function()
				if G.hand.highlighted ~= nil and (pseudorandom("showdown_probability") < (G.GAME.probabilities.normal * self.config.extra.initial_odds) / card.ability.extra.odds) then
                	if mathDestroyCard(G.hand.highlighted[i], {nil, first_dissolved}) then first_dissolved = false end
					for k, v in pairs(joker.ability) do
						if
							(type(v) == "number" or type(v) == "table")
							and not (k == "id")
							and not (k == "colour")
							and not (k == "suit_nominal")
							and not (k == "base_nominal")
							and not (k == "face_nominal")
							and not (k == "qty")
							and not ((k == "x_mult" or k == "Xmult") and v == 1 and not joker.ability.override_x_mult_check)
							and not (k == "selected_d6_face")
							and not (k == "x")
							and not (k == "y")
						then
							if type(v) == "table" then
								for kk, vv in pairs(v) do
									if type(vv) == "number" then
										v[kk] = tonumber(('%%.%dg'):format(2.11):format(vv * card.ability.mult_joker))
									end
								end
							elseif not ((k == "x_mult" or k == "Xmult") and v == 1) then joker.ability[k] = tonumber(('%%.%dg'):format(2.11):format(v * card.ability.mult_joker)) end
						end
					end
				end
            return true end })
        end
    end,
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		SMODS.Consumable.super.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		--[[ if G.GAME and card.area and (card.area == G.consumeables or (card.area == G.pack_cards and G.GAME.used_vouchers['v_showdown_axiom'])) then
			local jonkler_compat = joker_probability_compat(G.jokers.cards[1])
			desc_nodes[#desc_nodes+1] = {
				{n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
					{n=G.UIT.C, config={ref_table = self, align = "m", colour = jonkler_compat and G.C.GREEN or G.C.RED, r = 0.05, padding = 0.06}, nodes={
						{n=G.UIT.T, config={text = ' '..localize(jonkler_compat and 'k_compatible' or 'k_incompatible')..' ',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.9}},
					}}
				}}
			}
		end ]]
	end,
}

local sequence = {
	type = 'Consumable',
	order = 7,
	key = 'sequence',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
    pos = coordinate(7),
	config = {max_highlighted = 3, extra = { levels = 3 }},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.extra.levels}} end,
	can_use = function()
        if G.hand and #G.hand.highlighted <= 5 and #G.hand.highlighted >= 1 then
            return true
        end
        return false
    end,
    use = function(self, card, area, copier)
		local text, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
		local used_consumable = copier or card
		update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
		level_up_hand(used_consumable, text, nil, self.config.extra.levels)
		update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
		for i=#G.hand.highlighted, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function()
                if G.hand.highlighted ~= nil then mathDestroyCard(G.hand.highlighted[i], {nil, i == 1}); end
            return true end })
        end
		
    end
}

local operation = {
	type = 'Consumable',
	order = 8,
	key = 'operation',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
    pos = coordinate(8),
	config = {max_highlighted = 2},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted}} end,
	can_use = function()
        if G.hand and #G.hand.highlighted == 2 then
            return true
        end
        return false
    end,
    use = function(self)
		local card1 = G.hand.highlighted[1]
		local card2 = G.hand.highlighted[2]
		event({trigger = 'after', delay = 0.1, func = function()
			mathDestroyCard(card1, {nil, true})
			mathDestroyCard(card2)
		return true end })
		delay(0.2)
		event({trigger = 'after', delay = 0.7, func = function()
			local function randomValue(value1, value2)
				if not value1 then return value2
				elseif not value2 then return value1
				elseif pseudorandom("showdown_Probability") < G.GAME.probabilities.normal / 2 then
					return value1
				else
					return value2
				end
			end
			local cardValues1 = {
				ability = card1.config.center,
				edition = card1.edition,
				seal = card1.seal
			}
			local cardValues2 = {
				ability = card2.config.center,
				edition = card2.edition,
				seal = card2.seal
			}
			local _rank = pseudorandom_element(get_all_ranks(), pseudoseed('showdown_Probability'))
			local _suit = pseudorandom_element(get_all_suits(), pseudoseed('showdown_Probability'))
			local center = G.P_CENTERS.c_base
			---- This is horrendous
			local enhancements = {}
			for k, v in pairs(G.P_CENTERS) do if v.set == "Enhanced" then enhancements[v.name] = k end end
			enhancements["Default Base"] = "c_base"
			if enhancements[cardValues1.ability.name] == "Default Base" then center = G.P_CENTERS[enhancements[cardValues2.ability.name]]
			elseif enhancements[cardValues2.ability.name] == "Default Base" then center = G.P_CENTERS[enhancements[cardValues1.ability.name]]
			elseif pseudorandom("showdown_Probability") < G.GAME.probabilities.normal / 2 then
				center = G.P_CENTERS[enhancements[cardValues2.ability.name]]
			else
				center = G.P_CENTERS[enhancements[cardValues1.ability.name]]
			end
			----
			local edition = randomValue(cardValues1.edition, cardValues2.edition)
			local seal = randomValue(cardValues1.seal, cardValues2.seal)
			local card = create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = center}, G.hand, true)
			if edition then card:set_edition(edition) end
			if seal then card:set_seal(seal) end
			card:start_materialize()
			playing_card_joker_effects(card)
		return true end })
    end
}

-- Booster Packs

local boosters = {}

for i = 1, 4 do
    table.insert(boosters, {
		type = 'Booster',
		order = 8 + i,
        key = 'calculus_'..(i <= 2 and i or i == 3 and 'jumbo' or 'mega'),
        config = {extra = i <= 2 and 2 or 4, choose =  i <= 3 and 1 or 2},
        create_card = function(self, card)
            return create_card('Mathematic', G.pack_cards, nil, nil, true, true, nil, 'showdown_calculus')
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_CALCULUS)
            ease_background_colour{new_colour = G.C.SHOWDOWN_CALCULUS, special_colour = G.C.BLACK, contrast = 2}
        end,
        cost = (i <= 2 and 4 or i == 3 and 6 or 8),
        pos = coordinate(i),
        atlas = 'showdown_booster_packs_mathematic',
		kind = 'booster_calculus',
		group_key = "k_showdown_calculus_pack",
        in_pool = function() return (pseudorandom('calculus'..G.SEED) < 0.5) end,
		update_pack = function(self, dt)
            if G.buttons then G.buttons:remove(); G.buttons = nil end
            if G.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
            if not G.STATE_COMPLETE then
                G.STATE_COMPLETE = true
                G.CONTROLLER.interrupt.focus = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        if self.particles and type(self.particles) == "function" then self:particles() end
                        G.booster_pack = UIBox{
                            definition = self:create_UIBox(),
                            config = {align="tmi", offset = {x=0,y=G.ROOM.T.y + 9}, major = G.hand, bond = 'Weak'}
                        }
                        G.booster_pack.alignment.offset.y = -2.2
                        G.ROOM.jiggle = G.ROOM.jiggle + 3
                        self:ease_background_colour()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            func = function()
                                if G.GAME.draw_hand_math then G.FUNCS.draw_from_deck_to_hand() end
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.5,
                                    func = function()
                                        G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                        return true
                                    end}))
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
        end,
    })
end

return {
	enabled = Showdown.config["Consumeables"]["Mathematics"],
	list = function ()
		local list = {
			consumeable_type,
			undiscovered_sprite,
			constant,
			variable,
			func,
			shape,
			vector,
			probability,
			sequence,
			operation,
		}
		for _, b in ipairs(boosters) do
			table.insert(list, b)
		end
		return list
	end,
	atlases = {
		{key = 'showdown_mathematic_undiscovered', path = 'Consumables/MathematicsUndiscovered.png', px = 71, py = 95},
		{key = 'showdown_mathematic', path = 'Consumables/Mathematics.png', px = 71, py = 95},
		{key = 'showdown_booster_packs_mathematic', path = 'BoostersMathematic.png', px = 71, py = 95},
	},
	exec = function()
		function mathDestroyCard(card, args)
			if not card then return end
			if not args then args = {} end
			if
				not G.GAME.mathematic_no_destroy_chance
				or (G.GAME.mathematic_no_destroy_chance and pseudorandom('mathematic_no_destroy_chance') < G.GAME.probabilities.normal / 3)
			then
				card:start_dissolve(args.dissolve_colours, args.silent, args.dissolve_time_fac, args.no_juice)
				return true
			else
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
					attention_text({
						text = localize('k_nope_ex'),
						scale = 1.3,
						hold = 1.4,
						major = card,
						backdrop_colour = G.C.RED,
						align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
						offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -2.2 or -2},
						silent = true
						})
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
							play_sound('tarot2', 0.76, 0.4);return true end}))
						play_sound('tarot2', 1, 0.4)
						card:juice_up(0.3, 0.5)
				return true end }))
			end
		end

		local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
		function G.UIDEF.use_and_sell_buttons(card) -- Thanks Cryptid
			if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then
				if card.ability.set == "Mathematic" then
					if G.GAME.draw_hand_math then
						return {
							n = G.UIT.ROOT,
							config = { padding = -0.1, colour = G.C.CLEAR },
							nodes = {
								{
									n = G.UIT.R,
									config = {
										ref_table = card,
										r = 0.08,
										padding = 0.1,
										align = "bm",
										minw = 0.5 * card.T.w - 0.15,
										minh = 0.7 * card.T.h,
										maxw = 0.7 * card.T.w - 0.15,
										hover = true,
										shadow = true,
										colour = G.C.UI.BACKGROUND_INACTIVE,
										one_press = true,
										button = "use_card",
										func = "can_reserve_card",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("b_pull"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.55,
												shadow = true,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = {
										ref_table = card,
										r = 0.08,
										padding = 0.1,
										align = "bm",
										minw = 0.5 * card.T.w - 0.15,
										maxw = 0.9 * card.T.w - 0.15,
										minh = 0.1 * card.T.h,
										hover = true,
										shadow = true,
										colour = G.C.UI.BACKGROUND_INACTIVE,
										one_press = true,
										button = "Do you know that this parameter does nothing?",
										func = "can_use_consumeable",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("b_use"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.45,
												shadow = true,
											},
										},
									},
								},
								{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
								{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
								{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
								{ n = G.UIT.R, config = { align = "bm", w = 7.7 * card.T.w } },
								-- Betmma can't explain it, neither can I
							},
						}
					end
					return {
						n = G.UIT.ROOT,
						config = { padding = -0.1, colour = G.C.CLEAR },
						nodes = {
							{
								n = G.UIT.R,
								config = {
									ref_table = card,
									r = 0.08,
									padding = 0.1,
									align = "bm",
									minw = 0.5 * card.T.w - 0.15,
									minh = 0.7 * card.T.h,
									maxw = 0.7 * card.T.w - 0.15,
									hover = true,
									shadow = true,
									colour = G.C.UI.BACKGROUND_INACTIVE,
									one_press = true,
									button = "use_card",
									func = "can_reserve_card",
								},
								nodes = {
									{
										n = G.UIT.T,
										config = {
											text = localize("b_pull"),
											colour = G.C.UI.TEXT_LIGHT,
											scale = 0.55,
											shadow = true,
										},
									},
								},
							},
						},
					}
				end
			end
			return G_UIDEF_use_and_sell_buttons_ref(card)
		end
		if not (SMODS.Mods["Cryptid"] or {}).can_load then
			--Code from Betmma's Vouchers
			G.FUNCS.can_reserve_card = function(e)
				if #G.consumeables.cards < G.consumeables.config.card_limit then
					e.config.colour = G.C.GREEN
					e.config.button = "reserve_card"
				else
					e.config.colour = G.C.UI.BACKGROUND_INACTIVE
					e.config.button = nil
				end
			end
			G.FUNCS.reserve_card = function(e)
				local c1 = e.config.ref_table
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						c1.area:remove_card(c1)
						c1:add_to_deck()
						if c1.children.price then
							c1.children.price:remove()
						end
						c1.children.price = nil
						if c1.children.buy_button then
							c1.children.buy_button:remove()
						end
						c1.children.buy_button = nil
						remove_nils(c1.children)
						G.consumeables:emplace(c1)
						G.GAME.pack_choices = G.GAME.pack_choices - 1
						if G.GAME.pack_choices <= 0 then
							G.FUNCS.end_consumeable(nil, delay_fac)
						end
						return true
					end,
				}))
			end
		end
	end,
}