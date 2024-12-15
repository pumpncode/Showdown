---- Atlases

SMODS.Atlas({key = "showdown_placeholders", path = "Jokers/placeholders.png", px = 71, py = 95}) -- Thanks Cryptid
SMODS.Atlas({key = "showdown_jokers", path = "Jokers/Jokers.png", px = 71, py = 95})

---- Jokers

create_joker({ -- Crouton
    name = 'Crouton', loc_txt = loc.crouton,
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
    name = 'Pinpoint', loc_txt = loc.pinpoint,
	pos = coordinate(3),
    vars = {{x_chips = 1.5}},
    rarity = 'Rare', --cost = 5,
    blueprint = true, perishable = true, eternal = true,
	unlocked = false,
    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local zero = 0
            for j = 1, #args.cards do
                if args.cards[j].base.value == "showdown_Zero" then
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
			and context.other_card.base.value == "showdown_Zero"
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
    name = 'MathTeacher', loc_txt = loc.mathTeacher,
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
    name = 'Gruyere', loc_txt = loc.gruyere,
	--atlas = "showdown_jokers",
	pos = coordinate(1),
    vars = {{mult = 0}, {mult_mod = 2}},
    custom_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
	end,
    rarity = 'Common', --cost = 4,
    blueprint = true, perishable = false, eternal = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 0 then
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
    name = 'Mirror', loc_txt = loc.mirror,
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
			if context.other_card.base.id <= 0 then
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
    name = 'Billiard', loc_txt = loc.billiard,
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
    name = 'CrimeScene', loc_txt = loc.crime_scene,
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
    name = 'PingPong', loc_txt = loc.ping_pong,
    --atlas = "showdown_jokers",
    pos = coordinate(2),
    rarity = 'Uncommon', --cost = 4,
    blueprint = false, perishable = true, eternal = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not context.blueprint_card and not context.retrigger_joker then
            for i=1, #context.scoring_hand do
                local _card = context.scoring_hand[i]
                print(_card:get_id())
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