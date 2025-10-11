local consumeable_type = {
	type = 'ConsumableType',
    key = 'Logic',
    primary_colour = G.C.SHOWDOWN_BOOLEAN,
    secondary_colour = G.C.SHOWDOWN_BOOLEAN_DARK,
    collection_rows = {5, 5}
}

local undiscovered_sprite = {
	type = 'UndiscoveredSprite',
    key = 'Logic',
    atlas = 'showdown_logic_undiscovered',
    pos = coordinate(1)
}

Showdown.buffer_logic_rarity_blacklist = { 'showdown_final' }

local logic_buffer = {
    type = 'Consumable',
	order = 1,
	key = 'buffer',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(1),
	config = {max_highlighted = 1},
	can_use = function(self)
        local one_selected = G.jokers and #G.jokers.highlighted == self.config.max_highlighted
        if one_selected then
            local joker = G.jokers.highlighted[1]
            local rarity = type(joker.config.center.rarity) == "number" and SMODS.Rarity.obj_buffer[joker.config.center.rarity] or joker.config.center.rarity
            return findInTable(rarity, Showdown.buffer_logic_rarity_blacklist) == -1 and not SMODS.is_eternal(joker, self)
        end
        return false
    end,
    use = function(self, card, area, copier)
        local joker = G.jokers.highlighted[1]
        local rarity = type(joker.config.center.rarity) == "number" and SMODS.Rarity.obj_buffer[joker.config.center.rarity] or joker.config.center.rarity
        joker.getting_sliced = true
        G.E_MANAGER:add_event(Event({func = function()
            joker:start_dissolve({G.C.SHOWDOWN_BOOLEAN}, nil, 1.6)
        return true end }))
        local card = create_card('Joker', G.jokers, nil, rarity)
        card:add_to_deck()
        G.jokers:emplace(card)
    end
}

local logic_and = {
    type = 'Consumable',
	order = 2,
	key = 'and',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(2),
	config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.max_highlighted}}
    end,
	can_use = function(self)
        local one_selected = G.jokers and #G.jokers.highlighted == self.config.max_highlighted
        if one_selected then
            local joker, nb = G.jokers.highlighted[1], 0
            for k, card in pairs(G.jokers.cards) do
                if card.config.center_key == joker.config.center_key then
                    nb = nb + 1
                end
            end
            return #G.jokers.cards < G.jokers.config.card_limit and nb > 1
        end
        return false
    end,
    use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, G.jokers.highlighted[1].config.center_key, 'logic_and')
            card:add_to_deck()
            G.jokers:emplace(card)
            return true end }))
        delay(0.6)
    end
}

local logic_or = {
    type = 'Consumable',
	order = 3,
	key = 'or',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(3),
	config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.max_highlighted}}
    end,
	can_use = function(self)
        if G.jokers and #G.jokers.highlighted == self.config.max_highlighted then
            local joker = G.jokers.highlighted[1]
            if joker.edition then
                local tag = nil
                for _, _tag in pairs(G.P_TAGS) do
                    if _tag.config and _tag.config.type == 'store_joker_modify' and _tag.config.edition == joker.edition.type then
                        tag = _tag
                        break
                    end
                end
                return not not tag and ((joker.edition.type == 'negative' and #G.jokers.cards + 1 <= G.jokers.config.card_limit) or joker.edition.type ~= 'negative')
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
		local joker = G.jokers.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_'..joker.edition.type))
                return true
            end)
        }))
        G.E_MANAGER:add_event(Event({func = function()
            joker:set_edition({}, true)
        return true end }))
    end
}

local logic_xor = {
    type = 'Consumable',
	order = 4,
	key = 'xor',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(4),
	config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.max_highlighted}}
    end,
	can_use = function(self)
        return G.jokers and #G.jokers.highlighted == self.config.max_highlighted and not G.jokers.highlighted[1].ability.xor_retrigger
    end,
    use = function(self, card, area, copier)
        local joker = G.jokers.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.Stickers['showdown_xor_retrigger']:apply(joker, true)
                play_sound("gold_seal", 1.2, 0.4)
                joker:juice_up(0.3, 0.3)
                return true
            end
        }))
    end
}

local logic_imply = {
    type = 'Consumable',
	order = 5,
	key = 'imply',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(5),
	config = {max_highlighted = 1},
	can_use = function(self)
        return G.jokers and #G.jokers.highlighted == self.config.max_highlighted
    end,
    use = function(self, card, area, copier)
		local joker = G.jokers.highlighted[1]
        if joker then
            joker.ability.extra_value = joker.ability.extra_value + joker.sell_cost
            joker:set_cost()
        end
    end
}

local logic_not = {
    type = 'Consumable',
	order = 6,
	key = 'not',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(6),
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    end,
	config = {max_highlighted = 1},
	can_use = function(self)
        local one_selected = G.jokers and #G.jokers.highlighted == self.config.max_highlighted
        if one_selected then
            local joker = G.jokers.highlighted[1]
            return not (joker.edition and joker.edition.negative and joker.ability.perishable) and joker.config.center.perishable_compat
        end
        return false
    end,
    use = function(self, card, area, copier)
		local joker = G.jokers.highlighted[1]
        if joker then
            if not (joker.edition and joker.edition.negative) then
                joker:set_edition({ negative = true }, true)
                check_for_unlock({type = 'have_edition'})
            end
            if not joker.ability.perishable then joker:set_perishable(true) end
        end
    end
}

local logic_nand = {
    type = 'Consumable',
	order = 7,
	key = 'nand',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(7),
	config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.max_highlighted}}
    end,
	can_use = function(self)
        return G.jokers and #G.jokers.highlighted == self.config.max_highlighted and findInTable(G.jokers.highlighted[1], G.jokers.cards) < #G.jokers.cards
    end,
    use = function(self, card, area, copier)
        local joker = G.jokers.highlighted[1]
        local joker_on_right = G.jokers.cards[findInTable(joker, G.jokers.cards) + 1]
        joker:set_edition(joker_on_right.edition or {})
    end
}

local logic_nor = {
    type = 'Consumable',
	order = 8,
	key = 'nor',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(8),
	config = {max_highlighted = 1, sticker_removed = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.sticker_removed}}
    end,
	can_use = function(self)
        local one_selected = G.jokers and #G.jokers.highlighted == self.config.max_highlighted
        if one_selected then
            local joker = G.jokers.highlighted[1]
            local has_sticker = false
            for _, v in ipairs(SMODS.Sticker.obj_buffer) do
                if joker.ability[v] then
                    has_sticker = true
                    break
                end
            end
            return has_sticker
        end
        return false
    end,
    use = function(self, card, area, copier)
        local joker = G.jokers.highlighted[1]
        local stickers = {}
		for _, v in ipairs(SMODS.Sticker.obj_buffer) do
            if joker.ability[v] then
                table.insert(stickers, v)
            end
        end
        for _ = 1, self.config.sticker_removed do
            local sticker_to_remove = pseudorandom_element(stickers, pseudoseed('logic_nor'))
            if sticker_to_remove then
                SMODS.Stickers[sticker_to_remove]:apply(joker, false)
                table.remove(stickers, findInTable(sticker_to_remove, stickers))
            end
        end
    end
}

local logic_xnor = {
    type = 'Consumable',
	order = 9,
	key = 'xnor',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(9),
	config = {max_highlighted = 1, cards_created = 2},
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.cards_created}}
    end,
	can_use = function(self, card)
        return G.jokers and #G.jokers.highlighted == card.ability.max_highlighted
    end,
    use = function(self, card, area, copier)
		local used_consumable = copier or card
        local joker = G.jokers.highlighted[1]
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
                for _ = 1, used_consumable.ability.cards_created do
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        local _card = create_card(
                            "Consumeables",
                            G.consumeables,
                            nil,
                            nil,
                            nil,
                            nil,
                            nil,
                            "logic_xnor"
                        )
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                    end
                end
				return true
			end,
		}))
		delay(0.6)
        joker.getting_sliced = true
        G.E_MANAGER:add_event(Event({func = function()
            joker:start_dissolve({G.C.SHOWDOWN_BOOLEAN}, nil, 1.6)
        return true end }))
    end
}

Showdown.nimply_logic_rarity_cards = {
    ['Common'] = { cards = 2, colour = G.C.RARITY[1] },
    ['Uncommon'] = { cards = 4, colour = G.C.RARITY[2] },
    ['Rare'] = { cards = 6, colour = G.C.RARITY[3] },
    ['Legendary'] = { cards = 8, colour = G.C.RARITY[4] },
    ['showdown_final'] = { cards = 8, colour = HEX("b5a653") },
}

local logic_nimply = {
    type = 'Consumable',
	order = 10,
	key = 'nimply',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(10),
	config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        if G.jokers and #G.jokers.highlighted == self.config.max_highlighted then
            local joker = G.jokers.highlighted[1]
            local rarity = type(joker.config.center.rarity) == "number" and SMODS.Rarity.obj_buffer[joker.config.center.rarity] or joker.config.center.rarity
            if Showdown.nimply_logic_rarity_cards[rarity] then
                return {key = 'c_showdown_nimply', vars = { localize('k_'..(rarity:lower())), Showdown.nimply_logic_rarity_cards[rarity].cards, colours = { Showdown.nimply_logic_rarity_cards[rarity].colour } }}
            end
            return {key = 'c_showdown_nimply_uncompatible'}
        end
        return {key = 'c_showdown_nimply_no_joker'}
    end,
	can_use = function(self)
        local one_selected = G.jokers and #G.jokers.highlighted == self.config.max_highlighted
        if one_selected then
            local joker = G.jokers.highlighted[1]
            local rarity = type(joker.config.center.rarity) == "number" and SMODS.Rarity.obj_buffer[joker.config.center.rarity] or joker.config.center.rarity
            return Showdown.nimply_logic_rarity_cards[rarity] and not SMODS.is_eternal(joker, self)
        end
        return false
    end,
    use = function(self, card, area, copier)
        local joker = G.jokers.highlighted[1]
        local rarity = type(joker.config.center.rarity) == "number" and SMODS.Rarity.obj_buffer[joker.config.center.rarity] or joker.config.center.rarity
        local nbCards = Showdown.nimply_logic_rarity_cards[rarity].cards
        local ranks = get_all_ranks({onlyFace = true, whitelist = {"showdown_Zero"}})
        local suits = get_all_suits()
        local cards = {}
        for _=1, nbCards do
            local rank, suit = pseudorandom_element(ranks, pseudoseed('logic_nimply')), pseudorandom_element(suits, pseudoseed('logic_nimply'))
            local created_card, card = get_card_from_rank_suit(rank, suit), nil
            if created_card then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        card = create_card((pseudorandom(pseudoseed('logic_nimply'..G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base", G.play, nil, nil, nil, true, nil, 'logic_nimply')
                        local edition_rate = 2
                        local edition = poll_edition('logic_nimply'..G.GAME.round_resets.ante, edition_rate, true)
                        card:set_edition(edition)
                        card:set_seal(SMODS.poll_seal({mod = 10}), true, true)
                        cards[#cards+1] = card
                        card:start_materialize({G.C.SHOWDOWN_BOOLEAN})
                        G.play:emplace(card)
                        return true
                end}))
            end
            delay(0.2)
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                G.deck.config.card_limit = G.deck.config.card_limit + nbCards
                playing_card_joker_effects(cards)
                return true
        end}))
        G.E_MANAGER:add_event(Event({
            func = function()
                for i=1, #cards do
                    draw_card(G.play, G.deck, i*100/#cards,'up', nil ,cards[i])
                end
                return true
        end}))
        delay(0.2)
        joker.getting_sliced = true
        G.E_MANAGER:add_event(Event({func = function()
            joker:start_dissolve({G.C.SHOWDOWN_BOOLEAN}, nil, 1.6)
        return true end }))
    end
}

return {
	enabled = Showdown.config["Consumeables"]["Logics"],
	list = function ()
		local list = {
			consumeable_type,
			undiscovered_sprite,
			logic_buffer,
			logic_and,
            logic_or,
            logic_xor,
            logic_imply,
            logic_not,
            logic_nand,
            logic_nor,
            logic_xnor,
            logic_nimply,
		}
		return list
	end,
	atlases = {
		{key = 'showdown_logic_undiscovered', path = 'Consumables/LogicUndiscovered.png', px = 71, py = 95},
        {key = 'showdown_logic', path = 'Consumables/Logic.png', px = 71, py = 95},
	}
}