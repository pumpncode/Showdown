---- Atlases

SMODS.Atlas({key = "showdown_placeholders", path = "Jokers/placeholders.png", px = 71, py = 95}) -- Thanks Cryptid
SMODS.Atlas({key = "showdown_jokers", path = "Jokers/Jokers.png", px = 71, py = 95})

---- Jokers

create_joker({ -- Crouton
    name = 'crouton', loc_txt = loc.crouton,
	atlas = "showdown_jokers", pos = coordinate(1), soul = coordinate(2),
    vars = {{x_mult = 1.2}},
    rarity = 'Legendary', --cost = 5,
    blueprint = true, eternal = true, perishable = true,
    unlocked = false,
    unlock_condition = {hidden = true},
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
    name = 'pinpoint', loc_txt = loc.pinpoint,
	pos = coordinate(3),
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
        if
			context.individual
			and context.cardarea == G.hand
			and context.other_card
			and context.other_card:get_id() == 1
			and not context.before
			and not context.after
		then
			if context.other_card.debuff then return debuffedCard(card)
			else
				return {
					x_chips = card.ability.extra.x_chips,
					card = card
				}
			end
        end
    end
})

create_joker({ -- Math Teacher
    name = 'math_teacher', loc_txt = loc.mathTeacher,
	--atlas = "showdown_jokers",
	pos = coordinate(1),
    vars = {{chips = 0}, {chip_mod = 2.5}},
    custom_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'counterpart_ranks'}
		return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = false, eternal = true,
    unlocked = false,
    unlock_condition = {hidden = true},
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
        if context.individual and context.cardarea == G.play and SMODS.is_counterpart(context.other_card) then
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
    name = 'gruyere', loc_txt = loc.gruyere,
	--atlas = "showdown_jokers",
	pos = coordinate(1),
    vars = {{mult = 0}, {mult_mod = 2}},
    custom_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = false, eternal = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 1 then
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
    name = 'mirror', loc_txt = loc.mirror,
	--atlas = "showdown_jokers",
	pos = coordinate(3),
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
--[[
create_joker({ -- Billiard
    name = 'billiard', loc_txt = loc.billiard,
	--atlas = "showdown_jokers",
	pos = coordinate(3),
    custom_config = {extra = {retrigger = 1}},
    rarity = 'Rare', --cost = 4,
    blueprint = true, perishable = true, eternal = true,
    unlocked = false,
    unlock_condition = {hidden = true},
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
        if context.individual and context.cardarea == G.play and SMODS.is_counterpart(context.other_card) then
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

create_joker({ -- Crime Scene
    name = 'crime_scene', loc_txt = loc.crime_scene,
    --atlas = "showdown_jokers",
    pos = coordinate(3),
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
})
]]--
create_joker({ -- Ping Pong
    name = 'ping_pong', loc_txt = loc.ping_pong,
    --atlas = "showdown_jokers",
    pos = coordinate(2),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not context.blueprint_card and not context.retrigger_joker then
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
    name = 'color_splash', loc_txt = loc.color_splash,
    --atlas = "showdown_jokers",
    pos = coordinate(2),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    unlocked = false,
    unlock_condition = {hidden = true},
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
        if context.cardarea == G.jokers and context.after and not context.blueprint_card and not context.retrigger_joker then
            for i=1, #G.play.cards do
                local _card = G.play.cards[i]
                if _card:get_id() ~= 1 and not findInTable(_card, context.scoring_hand) then
                    flipCard(_card, i, #G.play.cards)
                    delay(0.2)
                    event({trigger = 'after', delay = 0.15, func = function()
                        assert(SMODS.change_base(_card, baseSuits[math.random(#baseSuits)], nil)) -- Put modded suits but include Bunco's ones only if exotics are enabled
                    return true end})
                    unflipCard(_card, i, #G.play.cards)
                    delay(0.6)
                end
            end
        end
    end
})

create_joker({ -- Blue
    name = 'blue', loc_txt = loc.blue,
    atlas = "showdown_jokers",
    pos = coordinate(11),
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = true, eternal = true,
    unlocked = false,
    unlock_condition = {hidden = true},
    check_for_unlock = function(self, args)
        if args.type == 'chip_score' then
            if args.chips < 10 then unlock_card(self) end
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
    name = 'spotted_joker', loc_txt = loc.spotted_joker,
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
    name = 'golden_roulette', loc_txt = loc.golden_roulette,
    --atlas = "showdown_jokers",
    pos = coordinate(2),
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
                    message = localize('k_extinct_ex')
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
    name = 'bacteria', loc_txt = loc.bacteria,
    --atlas = "showdown_jokers",
    pos = coordinate(1),
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
    name = 'empty_joker', loc_txt = loc.empty_joker,
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
    name = 'baby_jimbo', loc_txt = loc.baby_jimbo,
    --atlas = "showdown_jokers",
    pos = coordinate(2),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    unlocked = false,
    unlock_condition = {hidden = true},
    check_for_unlock = function(self, args)
        -- 2 times the maximum amount of consumables
    end,
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
                        local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'baby_jimbo')
                        card:set_edition({negative = true}, true)
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