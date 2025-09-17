local def_list = {}

table.insert(def_list, {
    key = 'crouton',
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        local playing_hand = next(G.play.cards)
        local count = 0
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_hand or not playing_card.highlighted then
                if not (playing_card.facing == 'back') and not playing_card.debuff then
                    count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                end
            end
        end
        card.joker_display_values.x_mult = card.ability.extra.x_mult ^ count
    end
})

table.insert(def_list, {
    key = 'pinpoint',
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_chips", retrigger_type = "exp" }
            },
            border_colour = G.C.CHIPS,
        }
    },
    calc_function = function(card)
        local playing_hand = next(G.play.cards)
        local count = 0
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_hand or not playing_card.highlighted then
                if not (playing_card.facing == 'back') and not playing_card.debuff and SMODS.is_zero(playing_card) then
                    count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                end
            end
        end
        card.joker_display_values.x_chips = card.ability.extra.x_chips ^ count
    end
})

table.insert(def_list, {
    key = 'math_teacher',
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "chips" }
    },
    text_config = { colour = G.C.CHIPS },
})

table.insert(def_list, {
    key = 'gruyere',
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
})

table.insert(def_list, {
    key = 'mirror',
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return (SMODS.is_zero(context.other_card) or SMODS.is_counterpart(context.other_card)) and
            joker_card.ability.extra.retrigger * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
})

table.insert(def_list, {
    key = 'crime_scene',
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    }
})

--table.insert(def_list, { key = 'ping_pong' })

--table.insert(def_list, { key = 'color_splash' })

table.insert(def_list, {
    key = 'blue',
    text = {
        { text = "+1" },
    },
    text_config = { colour = G.C.CHIPS }
})

table.insert(def_list, {
    key = 'spotted_joker',
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "chips" }
    },
    text_config = { colour = G.C.CHIPS },
    reminder_text = {
        { text = "(0)" },
    },
    calc_function = function(card)
        if not next(G.play.cards) then
            local count = 0
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' then
                for _, scoring_card in pairs(scoring_hand) do
                    if SMODS.is_zero(scoring_card) then
                        count = count + JokerDisplay.calculate_card_triggers(scoring_card, nil, true)
                    end
                end
            end
            local chips = 0
            for i = 1, count do
                chips = chips + card.ability.extra.chips + card.ability.extra.chip_mod * i
            end
            card.joker_display_values.chips = chips
        end
    end
})

table.insert(def_list, {
    key = 'golden_roulette',
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "money", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MONEY },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, 5, 6, 'golden_roulette')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
})

--table.insert(def_list, { key = 'bacteria' })

table.insert(def_list, {
    key = 'empty_joker',
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(0)" },
    },
    calc_function = function(card)
        local mult = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring_card in pairs(scoring_hand) do
                if SMODS.is_zero(scoring_card) then
                    mult = card.ability.extra.mult
                end
            end
        end
        card.joker_display_values.mult = mult
    end
})

-- needs to be finished

return {
    enabled = JokerDisplay,
    exec = function ()
        for _, def in ipairs(def_list) do
            JokerDisplay.Definitions["j_showdown_"..def.key] = def
        end
    end,
    order = 3,
}