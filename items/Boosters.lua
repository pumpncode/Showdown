local boosters = {
    mathematic = {},
    logic = {},
	one_of_a_kind = {},
}

-- Mathematic
-- Order 1 to 4

for i = 1, 4 do
    table.insert(boosters.mathematic, {
		type = 'Booster',
		order = i,
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
        pos = coordinate(i, 4),
        atlas = 'showdown_booster_packs',
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

-- Logic
-- Order 5 to 8

for i = 1, 4 do
    table.insert(boosters.logic, {
		type = 'Booster',
		order = 4 + i,
        key = 'boolean_'..(i <= 2 and i or i == 3 and 'jumbo' or 'mega'),
        config = {extra = i <= 2 and 3 or 5, choose = i <= 3 and 1 or 2},
        create_card = function(self, card)
            return create_card('Logic', G.pack_cards, nil, nil, true, true, nil, 'showdown_boolean')
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_BOOLEAN)
            ease_background_colour{new_colour = G.C.SHOWDOWN_BOOLEAN, special_colour = G.C.BLACK, contrast = 2}
        end,
        cost = (i <= 2 and 4 or i == 3 and 6 or 8),
        pos = coordinate(4+i, 4),
        atlas = 'showdown_booster_packs',
		kind = 'booster_boolean',
		group_key = "k_showdown_boolean_pack",
        in_pool = function() return (pseudorandom('boolean'..G.SEED) < 0.4 * (G.GAME.showdown_twice_boolean and 2 or 1)) end,
    })
end

-- One of a Kind
-- Order 9 to ?

for i = 1, 2 do
    table.insert(boosters.one_of_a_kind, {
		type = 'Booster',
		experimental = true,
		order = 8 + i,
        key = 'peasant'..(i == 2 and '_generous' or ''),
        config = {extra = i == 2 and 5 or 3, choose = i, min_cards = i},
        loc_vars = function(self, info_queue, card)
            return { vars = {math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.min_cards + (G.GAME.modifiers.booster_size_mod or 0)), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))} }
        end,
        create_card = function(self, card)
            return create_card('Joker', G.pack_cards, nil, 'Common', nil, nil, nil, 'showdown_peasant')
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_BOOLEAN)
            ease_background_colour{new_colour = G.C.SHOWDOWN_BOOLEAN, special_colour = G.C.BLACK, contrast = 2}
        end,
        cost = (i == 2 and 7 or 5),
        pos = coordinate(8+i, 4),
        atlas = 'showdown_booster_packs',
		kind = 'booster_peasant',
		group_key = "k_showdown_peasant_pack",
        in_pool = function() return (G.GAME.showdown_one_of_a_kind and pseudorandom('peasant'..G.SEED) < (i == 2 and 0.5 or 0.7)) end,
    })
end

for i = 1, 2 do
    table.insert(boosters.one_of_a_kind, {
		type = 'Booster',
		experimental = true,
		order = 10 + i,
        key = 'jester'..(i == 2 and '_generous' or ''),
        config = {extra = i == 2 and 5 or 3, choose = i, min_cards = i},
        loc_vars = function(self, info_queue, card)
            return { vars = {math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.min_cards + (G.GAME.modifiers.booster_size_mod or 0)), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))} }
        end,
        create_card = function(self, card)
            return create_card('Joker', G.pack_cards, nil, 'Uncommon', nil, nil, nil, 'showdown_jester')
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_BOOLEAN)
            ease_background_colour{new_colour = G.C.SHOWDOWN_BOOLEAN, special_colour = G.C.BLACK, contrast = 2}
        end,
        cost = (i == 2 and 7 or 5),
        pos = coordinate(10+i, 4),
        atlas = 'showdown_booster_packs',
		kind = 'booster_jester',
		group_key = "k_showdown_jester_pack",
        in_pool = function() return (G.GAME.showdown_one_of_a_kind and pseudorandom('jester'..G.SEED) < (i == 2 and 0.4 or 0.6)) end,
    })
end

for i = 1, 2 do
    table.insert(boosters.one_of_a_kind, {
		type = 'Booster',
		experimental = true,
		order = 12 + i,
        key = 'knight'..(i == 2 and '_generous' or ''),
        config = {extra = i == 2 and 5 or 3, choose = i, min_cards = i},
        loc_vars = function(self, info_queue, card)
            return { vars = {math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.min_cards + (G.GAME.modifiers.booster_size_mod or 0)), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))} }
        end,
        create_card = function(self, card)
            return create_card('Joker', G.pack_cards, nil, 'Rare', nil, nil, nil, 'showdown_knight')
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_BOOLEAN)
            ease_background_colour{new_colour = G.C.SHOWDOWN_BOOLEAN, special_colour = G.C.BLACK, contrast = 2}
        end,
        cost = (i == 2 and 7 or 5),
        pos = coordinate(12+i, 4),
        atlas = 'showdown_booster_packs',
		kind = 'booster_knight',
		group_key = "k_showdown_knight_pack",
        in_pool = function() return (G.GAME.showdown_one_of_a_kind and pseudorandom('knight'..G.SEED) < (i == 2 and 0.3 or 0.5)) end,
    })
end

for i = 1, 2 do
    table.insert(boosters.one_of_a_kind, {
		type = 'Booster',
		experimental = true,
		order = 14 + i,
        key = 'royal_'..i,
        config = {extra = 2, choose = 1, min_cards = 1},
        loc_vars = function(self, info_queue, card)
            return { vars = {math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.min_cards + (G.GAME.modifiers.booster_size_mod or 0)), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))} }
        end,
        create_card = function(self, card)
            return create_card('Joker', G.pack_cards, true, nil, nil, nil, nil, 'showdown_royal')
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_BOOLEAN)
            ease_background_colour{new_colour = G.C.SHOWDOWN_BOOLEAN, special_colour = G.C.BLACK, contrast = 2}
        end,
        cost = 14,
        pos = coordinate(14+i, 4),
        atlas = 'showdown_booster_packs',
		kind = 'booster_royal',
		group_key = "k_showdown_royal_pack",
        in_pool = function() return (G.GAME.showdown_one_of_a_kind and pseudorandom('royal'..G.SEED) < 0.1) end,
    })
end

for i = 1, 2 do
    table.insert(boosters.one_of_a_kind, {
		type = 'Booster',
		experimental = true,
		order = 16 + i,
        key = 'tag'..(i == 2 and '_generous' or ''),
        config = {extra = i == 2 and 5 or 3, choose = i, min_cards = i},
        loc_vars = function(self, info_queue, card)
            return { vars = {math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.min_cards + (G.GAME.modifiers.booster_size_mod or 0)), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))} }
        end,
        create_card = function(self, card)
            return card:create_tag_card()
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_BOOLEAN)
            ease_background_colour{new_colour = G.C.SHOWDOWN_BOOLEAN, special_colour = G.C.BLACK, contrast = 2}
        end,
        cost = (i == 2 and 6 or 4),
        pos = coordinate(16+i, 4),
        atlas = 'showdown_booster_packs',
		kind = 'booster_tag',
		group_key = "k_showdown_tag_pack",
        --in_pool = function() return (G.GAME.showdown_one_of_a_kind and pseudorandom('tag'..G.SEED) < (i == 2 and 0.35 or 0.6)) end,
        in_pool = function() return (G.GAME.showdown_one_of_a_kind and pseudorandom('tag'..G.SEED) < 1) end,
    })
end

return {
	enabled = true,
	list = function ()
        local list = {}
        if Showdown.config["Consumables"]["Mathematics"] then
            for _, v in ipairs(boosters.mathematic) do
                table.insert(list, v)
            end
        end
        if Showdown.config["Consumables"]["Logics"] then
            for _, v in ipairs(boosters.logic) do
                table.insert(list, v)
            end
        end
        if Showdown.config["Decks"] then
            for _, v in ipairs(boosters.one_of_a_kind) do
                table.insert(list, v)
            end
        end
		return list
	end,
    order = 1,
	atlases = {
		{key = 'showdown_booster_packs', path = 'Boosters.png', px = 71, py = 95},
	},
    exec = function()
        local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
		function G.UIDEF.use_and_sell_buttons(card) -- Thanks Cryptid
			if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then
				if card.ability.set == "Mathematic" or card.ability.set == "Logic" then
					if (card.ability.set == "Mathematic" and G.GAME.draw_hand_math) or (card.ability.set == "Logic" and G.GAME.showdown_pull_logics) then
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
										func = "can_use_consumable",
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
					if card.ability.set == "Mathematic" then
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