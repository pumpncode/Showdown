---- Final Rarity

SMODS.Rarity{
    key = "Final",
    default_weight = 0,
    badge_colour = HEX("b5a653"),
    get_weight = function(self, weight, object_type)
        return weight
    end,
    gradient = function(self, dt)
        --
    end
}

---- Jokers

create_joker({ -- Crouton
    name = 'crouton',
	atlas = "showdown_jokers",
    pos = coordinate(2), soul = coordinate(3),
    vars = {{x_mult = 1.2}},
    rarity = 'Legendary', --cost = 5,
    blueprint = true, eternal = true, perishable = true,
    unlocked = false,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand then
            return {
                x_mult = card.ability.extra.x_mult,
                card = card
            }
        end
    end
})

create_joker({ -- Pinpoint
    name = 'pinpoint',
	atlas = "showdown_jokers",
	pos = coordinate(4),
    vars = {{x_chips = 1.5}},
    rarity = 'Rare', --cost = 5,
    blueprint = true, perishable = true, eternal = true,
	unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local zero = 0
            for j = 1, #args.cards do
                if args.cards[j]:get_id() == 1 then
                    zero = zero + 1
                end
            end
            if zero >= 5 then
                unlock_card(self)
            end
        end
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.other_card:get_id() == 1 then
            return {
                x_chips = card.ability.extra.x_chips,
                card = card
            }
        end
    end
})

create_joker({ -- Math Teacher
    name = 'math_teacher',
	atlas = "showdown_jokers",
	pos = coordinate(5),
    vars = {{chips = 0}, {chip_mod = 2.5}},
    custom_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'counterpart_ranks'}
		return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = false, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local eval = evaluate_poker_hand(args.cards)
            if next(eval['Three of a Kind']) then
                local counterpart = 0
                for j = 1, #args.cards do
                    if SMODS.is_counterpart(args.cards[j]) then counterpart = counterpart + 1 end
                end
                if counterpart >= 3 then unlock_card(self) end
            end
        end
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.is_counterpart(context.other_card) and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            forced_message(localize('k_upgrade_ex'), card, G.C.CHIPS, true)
        end
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
				chip_mod = card.ability.extra.chips,
			}
		end
    end
})

create_joker({ -- Gruyère
    name = 'gruyere',
	atlas = "showdown_jokers",
	pos = coordinate(6),
    vars = {{mult = 0}, {mult_mod = 2}},
    custom_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = false, eternal = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 1 and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            forced_message(localize('k_upgrade_ex'), card, G.C.MULT, true)
        end
		if context.joker_main then
			return {
				message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
				mult_mod = card.ability.extra.mult,
			}
		end
    end
})

create_joker({ -- Mirror
    name = 'mirror',
	atlas = "showdown_jokers",
	pos = coordinate(7),
    custom_config = {extra = {retrigger = 1}},
    custom_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'counterpart_ranks'}
	end,
    rarity = 'Rare', --cost = 4,
    blueprint = true, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == 1 or SMODS.is_counterpart(context.other_card) then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.extra.retrigger,
					card = card,
				}
			end
		end
    end
})

--[[create_joker({ -- Crime Scene
    name = 'crime_scene',
    atlas = "showdown_jokers",
    pos = coordinate(8),
    vars = {{x_mult = 1}, {x_mult_mod = 0.1}},
    custom_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_mod } }
    end,
    rarity = 'Rare', --cost = 4,
    blueprint = true, perishable = false, eternal = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.debuff then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
            forced_message(localize('k_upgrade_ex'), card, G.C.XMULT, true)
        end
        if context.joker_main and card.ability.extra.x_mult > 1 then
            return {
                message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
                x_mult = card.ability.extra.x_mult,
            }
        end
    end
})]]--

create_joker({ -- Ping Pong
    name = 'ping_pong',
    atlas = "showdown_jokers",
    pos = coordinate(9),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not context.blueprint_card and not context.blueprint and not context.retrigger_joker then
            for i=1, #context.scoring_hand do
                local _card = context.scoring_hand[i]
                if _card:get_id() == 7 or _card:get_id() == 14 then
                    flipCard(_card, i, #context.scoring_hand)
                    delay(0.2)
                    if _card:get_id() == 7 then
                        event({trigger = 'after', delay = 0.15, func = function() assert(SMODS.change_base(_card, nil, 'Ace')); return true end})
                    else
                        event({trigger = 'after', delay = 0.15, func = function() assert(SMODS.change_base(_card, nil, '7')); return true end})
                    end
                    unflipCard(_card, i, #context.scoring_hand)
                    delay(0.2)
                end
            end
        end
    end
})

create_joker({ -- Color Splash
    name = 'color_splash',
    atlas = "showdown_jokers",
    pos = coordinate(10),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(args.cards)
            local suits = {}
            for i = 1, #args.cards do
                if not findInTable(args.cards[i], scoring_hand) and not findInTable(args.cards[i].base.suit, suits) then
                    table.insert(suits, args.cards[i].base.suit)
                end
            end
            if #suits >= 4 then unlock_card(self) end
        end
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not context.blueprint_card and not context.blueprint and not context.retrigger_joker then
            local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
            for i=1, #G.play.cards do
                local _card = G.play.cards[i]
                if _card:get_id() ~= 1 and not findInTable(_card, context.scoring_hand) then
                    flipCard(_card, i, #G.play.cards)
                    delay(0.2)
                    event({trigger = 'after', delay = 0.15, func = function()
                        assert(SMODS.change_base(_card, suits[math.random(#suits)], nil))
                    return true end})
                    unflipCard(_card, i, #G.play.cards)
                    delay(0.6)
                end
            end
        end
    end
})

create_joker({ -- Blue
    name = 'blue',
    atlas = "showdown_jokers",
    pos = coordinate(11),
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = true, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'chip_score' then
            if
                (type(args.chips) == 'number' and args.chips < 10)
                or (type(args.chips) == 'table' and args.chips.array[1] < 10)
            then
                unlock_card(self)
            end
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			return {
				message = localize({ type = "variable", key = "a_chips", vars = { 1 } }),
				chip_mod = 1,
			}
		end
    end
})

create_joker({ -- Spotted Joker
    name = 'spotted_joker',
	atlas = "showdown_jokers",
	pos = coordinate(12),
    vars = {{chips = 0}, {chip_mod = 0.5}},
    custom_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = false, eternal = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 1 then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                return {
                    message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
                    chips = card.ability.extra.chips,
                }
            end
        end
    end
})

create_joker({ -- Golden Roulette
    name = 'golden_roulette',
    atlas = "showdown_jokers",
    pos = coordinate(13),
    vars = {{money = 6}},
    custom_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money } }
	end,
    rarity = 'Uncommon', --cost = 4,
    blueprint = true, perishable = true, eternal = false,
    calculate = function(self, card, context)
        if context.end_of_round then
            if pseudorandom('golden_roulette') < G.GAME.probabilities.normal / 6 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                }))
                return {
                    message = localize('k_BAM')
                }
            else
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$')..card.ability.extra.money,
                    colour = G.C.MONEY,
                    delay = 0.45,
                    card = card
                }
            end
		end
    end
})

create_joker({ -- Bacteria
    name = 'bacteria',
    atlas = "showdown_jokers",
    pos = coordinate(14),
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not context.blueprint_card and not context.retrigger_joker then
            local eval = evaluate_poker_hand(context.scoring_hand)
            if next(eval['Flush']) then
                local notZeros = {}
                for i=1, #context.scoring_hand do
                    local _card = context.scoring_hand[i]
                    if _card:get_id() ~= 1 then table.insert(notZeros, _card) end
                end
                if #notZeros > 0 and #notZeros < #context.scoring_hand then
                    local _card = notZeros[math.random(#notZeros)]
                    flipCard(_card, nil, #context.scoring_hand)
                    delay(0.2)
                    event({trigger = 'after', delay = 0.15, func = function() assert(SMODS.change_base(_card, nil, 'showdown_Zero')); return true end})
                    unflipCard(_card, nil, #context.scoring_hand)
                    delay(0.6)
                end
            end
        end
    end
})

create_joker({ -- Empty Joker
    name = 'empty_joker',
    atlas = "showdown_jokers",
    pos = coordinate(15),
    vars = {{mult = 12}},
    custom_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if context.joker_main then
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 1 then
                    return {
                        message = localize({ type = "variable", key = "a_mult", vars = { card.ability.extra.mult } }),
                        mult_mod = card.ability.extra.mult,
                    }
                end
            end
            
        end
    end
})

create_joker({ -- Baby Jimbo
    name = 'baby_jimbo',
    atlas = "showdown_jokers",
    pos = coordinate(16),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if not context.blueprint
            and (context.destroying_cards or context.removing_cards)
            and context.destroyed_card
            and context.destroyed_card ~= card
            and context.destroyed_card.ability.set == "Joker"
            and G.latest_area_baby_jimbo
            and G.latest_area_baby_jimbo == G.jokers
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
        then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.0,
                func = (function()
                        --local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'baby_jimbo')
                        local card = SMODS.create_card({set = 'Spectral', area = G.consumeables, edition = {negative = true}})
                        --card:set_edition({negative = true}, true)
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                )
            }))
            G.latest_area_baby_jimbo = nil
            return {
                message = localize('k_plus_spectral'),
                colour = G.C.SECONDARY_SET.Spectral,
                card = self
            }
        end
    end
})

create_joker({ -- Parmesan
    name = 'parmesan',
    atlas = "showdown_jokers",
    pos = coordinate(17),
    rarity = 'Uncommon', --cost = 4,
    blueprint = true, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.repetition then
            local lowestRank = 11
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i].base.nominal < lowestRank then
                    lowestRank = context.scoring_hand[i].base.nominal
                end
            end
            if lowestRank > 0 then
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + lowestRank
                return {
                    extra = {message = localize('k_upgrade_ex'), colour = G.C.CHIPS},
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end
    end
})

create_joker({ -- Chaos Card
    name = 'chaos_card',
    atlas = "showdown_jokers",
    pos = coordinate(18),
    rarity = 'Rare', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local hands = G.GAME.chaos_card_hands
            local eval = evaluate_poker_hand(args.cards)
            hands.flush = hands.flush or next(eval['Flush'])
            hands.straight = hands.straight or next(eval['Straight'])
            hands.five = hands.five or next(eval['Five of a Kind'])
            if hands.flush and hands.straight and hands.five then unlock_card(self) end
        elseif args.type == 'round_win' then
            local hands = G.GAME.chaos_card_hands
            hands.flush = false
            hands.straight = false
            hands.five = false
        end
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not context.blueprint_card and not context.blueprint and not context.retrigger_joker then
            local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
            local ranks = get_all_ranks()
            for i=1, #context.scoring_hand do
                local _card = context.scoring_hand[i]
                flipCard(_card, i, #context.scoring_hand)
                delay(0.2)
                event({trigger = 'after', delay = 0.15, func = function()
                    assert(SMODS.change_base(_card, suits[math.random(#suits)], ranks[math.random(#ranks)]))
                return true end})
                unflipCard(_card, i, #context.scoring_hand)
                delay(0.6)
            end
        end
    end
})

create_joker({ -- SIM Card
    name = 'sim_card',
    atlas = "showdown_jokers",
    pos = coordinate(19),
    custom_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'counterpart_ranks'}
	end,
    rarity = 'Rare', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
})

create_joker({ -- Wall
    name = 'wall',
    atlas = "showdown_jokers",
    pos = coordinate(20),
    rarity = 'Rare', cost = 1,
    blueprint = false, perishable = false, eternal = true,
})

create_joker({ -- one doller
    name = 'one_doller',
    atlas = "showdown_jokers",
    pos = coordinate(21),
    rarity = 'Common', cost = 1,
    blueprint = false, perishable = false, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'buying_card' then
            if args.price <= 0 then unlock_card(self) end
        end
    end,
    calculate = function(self, card, context)
        if context.buying_card or context.open_booster and not context.blueprint then
            ease_dollars(1)
            return {
                message = localize('$')..1,
                colour = G.C.MONEY,
                delay = 0.45,
                card = card
            }
        end
    end
})

create_joker({ -- Revolution
    name = 'revolution',
    atlas = "showdown_jokers",
    pos = coordinate(22),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not context.blueprint_card and not context.blueprint and not context.retrigger_joker and not next(find_joker('Pareidolia')) then
            local ranks = get_all_ranks({noFace = true})
            for i=1, #context.scoring_hand do
                local _card = context.scoring_hand[i]
                if _card:is_face() then
                    flipCard(_card, i, #context.scoring_hand)
                    delay(0.2)
                    event({trigger = 'after', delay = 0.15, func = function()
                        assert(SMODS.change_base(_card, nil, ranks[math.random(#ranks)]))
                    return true end})
                    unflipCard(_card, i, #context.scoring_hand)
                    delay(0.6)
                end
            end
        end
    end
})

create_joker({ -- Fruit Sticker
    name = 'fruit_sticker',
    atlas = "showdown_jokers",
    pos = coordinate(23),
    vars = {{x_mult = 2.5}},
    custom_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult } }
	end,
    rarity = 'Rare', --cost = 4,
    blueprint = true, perishable = true, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        -- Have stickers on your maximum amount or higher of jokers (no stake stickers)
    end,
    calculate = function(self, card, context)
        --if context.joker_main or context.other_joker or (context.individual and context.cardarea == G.hand) then
        if context.other_joker then
            for k, v in pairs(context.other_joker.ability) do
                print(k)
                if findInTable(k, SMODS.Sticker.obj_buffer) and v then
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = context.other_joker
                    }
                end
            end
        end
    end
})

create_joker({ -- Sinful Joker
    name = 'sinful_joker',
    atlas = "showdown_jokers",
    pos = coordinate(24),
    vars = {{scaling = 3}},
    custom_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.scaling } }
	end,
    rarity = 'Rare', --cost = 4,
    blueprint = true, perishable = true, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if next(find_joker('Greedy Joker')) and next(find_joker('Lusty Joker')) and next(find_joker('Wrathful Joker')) and next(find_joker('Gluttonous Joker')) then
            unlock_card(self)
        end
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before then
            local jokers = {}
            for i=1, #G.jokers.cards do
                local name = G.jokers.cards[i].ability.name
                if name == 'Greedy Joker' or name == 'Lusty Joker' or name == 'Wrathful Joker' or name == 'Gluttonous Joker' then
                    table.insert(jokers, G.jokers.cards[i])
                end
            end
            for i=1, #jokers do
                jokers[i].ability.extra.s_mult = jokers[i].ability.extra.s_mult + card.ability.extra.scaling
            end
            if #jokers > 0 then
                return {
                    message = localize('k_upgrade_ex')
                }
            end
        end
    end
})

create_joker({ -- Egg Drawing
    name = 'egg_drawing',
    atlas = "showdown_jokers",
    pos = coordinate(25),
    vars = {{money = 4}},
    custom_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'selling_card' then
            if args.sell_cost > 10 then unlock_card(self) end
        end
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            print("egg drawing")
            local joker = pseudorandom_element(G.jokers.cards, pseudoseed('egg_drawing'))
            joker.ability.extra_value = joker.ability.extra_value + card.ability.extra.money
            joker:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY,
                card = joker
            }
        end
    end
})

create_joker({ -- Jimbo's Makeup
    name = 'jimbo_makeup',
    atlas = "showdown_jokers",
    pos = coordinate(26),
    rarity = 'Rare',
    blueprint = false, perishable = false, eternal = false,
})

create_joker({ -- Jimbo's Hat
    name = 'jimbo_hat',
    atlas = "showdown_jokers",
    pos = coordinate(27),
    rarity = 'Rare',
    blueprint = false, perishable = false, eternal = false,
})

create_joker({ -- Jimbo's Bells
    name = 'jimbo_bells',
    atlas = "showdown_jokers",
    pos = coordinate(28),
    rarity = 'Rare',
    blueprint = false, perishable = false, eternal = false,
})

create_joker({ -- Jimbo's Collar
    name = 'jimbo_collar',
    atlas = "showdown_jokers",
    pos = coordinate(29),
    rarity = 'Rare',
    blueprint = false, perishable = false, eternal = false,
})

create_joker({ -- Gary McCready
    name = 'gary_mccready',
    atlas = "showdown_jokers",
    pos = coordinate(30),
    vars = {{created = false}},
    rarity = 'Rare',
    blueprint = false, perishable = false, eternal = false,
    calculate = function(self, card, context)
        if not context.blueprint and not card.ability.extra.created then
            local makeup, hat, bells, collar = find_joker('jimbo_makeup'), find_joker('jimbo_hat'), find_joker('jimbo_bells'), find_joker('jimbo_collar')
            if next(makeup) and next(hat) and next(bells) and next(collar) then
                card.ability.extra.created = true
                if not G.GAME.won then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        blocking = false,
                        blockable = false,
                        func = (function()
                            win_game()
                            G.GAME.won = true
                            return true
                        end)
                    }))
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        local jokers = {card, makeup[1], hat[1], bells[1], collar[1]}
                        for i=1, #jokers do
                            jokers[i]:start_dissolve(nil, i == #jokers)
                        end
                        local _card = SMODS.create_card({set = 'Joker', area = G.jokers, key = 'j_showdown_ultimate_joker', no_edition = true})
                        _card:add_to_deck()
                        G.jokers:emplace(_card)
                        return true
                    end
                }))
            end
        end
    end
})

create_joker({ -- Ultimate Joker
    name = 'ultimate_joker',
    atlas = "showdown_jokers",
    pos = coordinate(31),
    custom_vars = function(self, info_queue, card)
		return { vars = { G.GAME.round } }
	end,
    rarity = 'showdown_Final', cost = 20,
    blueprint = true, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.round > 1 then
            return {
                message = 'X' .. G.GAME.round,
                Xchip_mod = G.GAME.round,
                Xmult_mod = G.GAME.round,
                colour = G.C.PURPLE,
                card = card
            }
        end
    end
})

create_joker({ -- Strainer
    name = 'strainer',
    atlas = "showdown_jokers",
    pos = coordinate(32),
    vars = {{money = 0}, {moneyRequirement = 10}, {boss_shop = false}},
    custom_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'counterpart_ranks'}
        if card.ability.extra.boss_shop then
            return { key = "j_showdown_strainer_active", vars = { card.ability.extra.moneyRequirement, card.ability.extra.money } }
        else
            return { key = "j_showdown_strainer", vars = { card.ability.extra.moneyRequirement } }
        end
	end,
    rarity = 'Uncommon', --cost = 4,
    blueprint = true, perishable = true, eternal = false,
    calculate = function(self, card, context)
        if G.GAME and G.GAME.blind and G.GAME.blind.boss and not context.blueprint then
            card.ability.extra.boss_shop = true
        end
        if card.ability.extra.boss_shop then
            if (context.buying_card or context.open_booster) and not context.blueprint then
                card.ability.extra.money = card.ability.extra.money + math.max(context.card.cost, 0)
            elseif context.reroll_shop and not context.blueprint then
                card.ability.extra.money = card.ability.extra.money + math.max(G.GAME.current_round.reroll_cost, 0)
            elseif context.ending_shop then
                local ranks = get_all_ranks({onlyCounterpart = true, noFace = true, whitelist = {"showdown_Zero"}})
                local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
                while card.ability.extra.money >= card.ability.extra.moneyRequirement do
                    card.ability.extra.money = card.ability.extra.money - card.ability.extra.moneyRequirement
                    local rank = pseudorandom_element(ranks, pseudoseed('strainer'))
                    local suit = pseudorandom_element(suits, pseudoseed('strainer'))
                    local created_card = get_card_from_rank_suit(rank, suit)
                    if created_card then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                                local _card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, get_card_from_rank_suit(rank, suit), G.P_CENTERS.c_base, {playing_card = G.playing_card})
                                _card:start_materialize({G.C.SECONDARY_SET.Enhanced})
                                G.play:emplace(_card)
                                table.insert(G.playing_cards, _card)
                                return true
                        end}))
                        delay(0.6)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.deck.config.card_limit = G.deck.config.card_limit + 1
                                return true
                        end}))
                        draw_card(G.play,G.deck, 90,'up', nil)
                        playing_card_joker_effects({true})
                        delay(0.2)
                    end
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end}))
                        return true
                    end
                }))
                return {
                    message = localize('k_strainer_broke')
                }
            end
        end
    end
})
--[[
create_joker({ -- Billiard
    name = 'billiard',
    atlas = "showdown_jokers",
    pos = coordinate(33),
    rarity = 'Rare', --cost = 4,
    blueprint = true, perishable = true, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        --
    end,
    calculate = function(self, card, context)
        if context.scoring_hand and context.cardarea == G.play then
            local idx = findInTable(context.card, G.play.cards)
            print(idx)
            local rep = 0
            if idx and ((idx > 1 and G.play.cards[idx-1]:get_id() == 1) or (idx < #G.play.cards and G.play.cards[idx+1]:get_id() == 1)) then
                rep = rep + 1
            end
            if rep > 0 then
                return {
                    message = localize("k_again_ex"),
                    repetitions = rep,
                    card = context.card,
                }
            end
		end
    end
})
]]
create_joker({ -- Hiding in the Details
    name = 'hiding_details',
    atlas = "showdown_jokers",
    pos = coordinate(34),
    custom_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'counterpart_ranks'}
	end,
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
})

create_joker({ -- What a Steel!
    name = 'what_a_steel',
    atlas = "showdown_jokers",
    pos = coordinate(35),
    vars = {{steel_tally = 0}},
    custom_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS['m_steel']
        return { vars = { card.ability.extra.steel_tally, G.GAME.discount_percent } }
	end,
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'playing_card_added' then
            if args.card.config.center == G.P_CENTERS.m_steel then
                unlock_card(self)
            end
        end
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            G.GAME.discount_percent = G.GAME.used_vouchers.v_liquidation and 50 or G.GAME.used_vouchers.v_clearance_sale and 25 or 0 -- There's no compatibility if mods change the discount
            card.ability.extra.steel_tally = 0
            for k, v in pairs(G.playing_cards) do
                if v.config.center == G.P_CENTERS.m_steel then
                    card.ability.extra.steel_tally = card.ability.extra.steel_tally+1
                    G.GAME.discount_percent = G.GAME.discount_percent + 1
                end
            end
            card.ability.extra.steel_tally = math.min(card.ability.extra.steel_tally, 80)
            G.GAME.discount_percent = math.min(G.GAME.discount_percent, 80)
            G.E_MANAGER:add_event(Event({func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
            return true end }))
        end
    end
})

create_joker({ -- Diplomatic Immunity
    name = 'diplomatic_immunity',
    atlas = "showdown_jokers",
    pos = coordinate(36),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true
})

create_joker({ -- Nitroglycerin
    name = 'nitroglycerin',
    atlas = "showdown_jokers",
    pos = coordinate(37),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = false, eternal = false,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint and not G.booster_pack then
            for i=#G.hand.cards, 1, -1 do
                G.hand.cards[i]:start_dissolve(nil, i == #G.hand.cards)
            end
        end
    end
})

create_joker({ -- Substitute Teacher
    name = 'substitute_teacher',
    atlas = "showdown_jokers",
    pos = coordinate(38),
    vars = {{chips_scale = 4}, {mult_scale = 2}},
    custom_vars = function(self, info_queue, card)
        local mathUsed = G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.mathematic or 0
        return { vars = { card.ability.extra.chips_scale, card.ability.extra.mult_scale, mathUsed * card.ability.extra.chips_scale, mathUsed * card.ability.extra.mult_scale } }
	end,
    locked_vars = function(self, info_queue, card)
        return { vars = { 20, math.max(G.PROFILES[G.SETTINGS.profile].career_stats.c_maths_used or 0, 20) } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = false, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if G.PROFILES[G.SETTINGS.profile].career_stats.c_maths_used >= 20 then
            unlock_card(self)
        end
    end,
    calculate = function(self, card, context)
        local mathUsed = G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.mathematic or 0
        local chips_scale = mathUsed * card.ability.extra.chips_scale
        local mult_scale = mathUsed * card.ability.extra.mult_scale
        if context.using_consumeable and not context.blueprint and (context.consumeable.ability.set == "Mathematic") then
            G.E_MANAGER:add_event(Event({
                func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_chips_mult',vars={chips_scale, mult_scale}}}); return true
            end}))
        end
        if context.cardarea == G.jokers and context.joker_main and mathUsed > 0 then
            return {
                message = localize{type='variable',key='a_chips_mult',vars={chips_scale, mult_scale}},
                chip_mod = chips_scale,
                mult_mod = mult_scale,
            }
        end
    end
})

create_joker({ -- World Map
    name = 'world_map',
    atlas = "showdown_jokers",
    pos = coordinate(39),
    vars = {{chips_scale = 12.5}, {chips = 0}},
    custom_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_scale, card.ability.extra.chips } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = false, eternal = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers then
            if context.joker_main and card.ability.extra.chips > 0 then
                return {
                    message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            elseif context.before and not context.blueprint then
                local eval = evaluate_poker_hand(context.scoring_hand)
                if next(eval['Flush']) then
                    local zero = false
                    for i=1, #context.scoring_hand do
                        local _card = context.scoring_hand[i]
                        if _card:get_id() == 1 then zero = true break end
                    end
                    if zero then
                        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_scale
                        return {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.CHIPS,
                            card = card
                        }
                    end
                end
            end
        end
    end
})

create_joker({ -- Bugged Seed
    name = 'bugged_seed',
    atlas = "showdown_jokers",
    pos = coordinate(40),
    locked_vars = function(self, info_queue, card)
        if false then -- If Erratic Deck hasn't been discovered
            return { key = "j_showdown_bugged_seed_unknown" }
        end
        return { key = "j_showdown_bugged_seed" }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if G.GAME.seeded and args.type == '7LB2WVPK' then
            unlock_card(self)
        end
    end,
    calculate = function(self, card, context)
        --
    end
})

create_joker({ -- Sick Trick
    name = 'sick_trick',
    atlas = "showdown_jokers",
    pos = coordinate(41),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not context.blueprint_card and not context.blueprint and not context.retrigger_joker and #context.scoring_hand > 1 then
            local idx = 1
            for i=2, #context.scoring_hand do
                if context.scoring_hand[idx].base.nominal < context.scoring_hand[i].base.nominal then
                    idx = i
                end
            end
            if idx > 1 then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    copy_card(context.scoring_hand[idx], context.scoring_hand[idx-1])
                return true end }))
            end
        end
    end
})

create_joker({ -- Jaws
    name = 'jaws',
    atlas = "showdown_jokers",
    pos = coordinate(42),
    vars = {{chips_scale = 2}, {chips = 0}},
    custom_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_scale, card.ability.extra.chips } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = false, eternal = true,
    unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'discard_custom' then
            local allFaces = #args.cards > 0
            for i=1, #args.cards do
                allFaces = allFaces and args.cards[i]:is_face()
            end
            if allFaces then unlock_card(self) end
        end
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and card.ability.extra.chips > 0 then
            return {
                message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        elseif not context.blueprint and context.discard and context.other_card:is_face() then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_scale
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
})