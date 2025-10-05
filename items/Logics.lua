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
            return findInTable(rarity, Showdown.buffer_logic_rarity_blacklist) == -1
        end
        return false
    end,
    use = function(self)
        local joker = G.jokers.highlighted[1]
        local rarity = type(joker.config.center.rarity) == "number" and SMODS.Rarity.obj_buffer[joker.config.center.rarity] or joker.config.center.rarity
        joker.getting_sliced = true
        G.E_MANAGER:add_event(Event({func = function()
            joker:start_dissolve({G.C.SHOWDOWN_BOOLEAN}, nil, 1.6)
        return true end }))
        local card = create_card('Joker', G.jokers, nil, rarity) -- add card modifiers
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
    use = function(self)
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
	--config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.max_highlighted}}
    end,
	can_use = function(self)
        --
    end,
    use = function(self)
		--
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
        return false
    end,
    use = function(self)
        --
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
    use = function(self)
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
    use = function(self)
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
    use = function(self)
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
    use = function(self)
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
	--config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.max_highlighted}}
    end,
	can_use = function(self)
        --
    end,
    use = function(self)
		--
    end
}

local logic_nimply = {
    type = 'Consumable',
	order = 10,
	key = 'nimply',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(10),
	--config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {self.config.max_highlighted}}
    end,
	can_use = function(self)
        --
    end,
    use = function(self)
		--
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