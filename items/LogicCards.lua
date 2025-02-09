SMODS.Atlas({key = 'showdown_logic_undiscovered', path = 'Consumables/LogicUndiscovered.png', px = 71, py = 95})
SMODS.Atlas({key = 'showdown_logic', path = 'Consumables/Logic.png', px = 71, py = 95})

SMODS.ConsumableType{
    key = 'Logic',
    primary_colour = G.C.SHOWDOWN_LOGIC,
    secondary_colour = G.C.SHOWDOWN_LOGIC_DARK,
    collection_rows = {4, 4}
}

SMODS.UndiscoveredSprite{
    key = 'Logic',
    atlas = 'showdown_logic_undiscovered',
    pos = coordinate(1)
}

SMODS.Consumable({ -- AND
	key = 'and',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(1),
	--config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        --
    end,
    use = function()
		--
    end
})

SMODS.Consumable({ -- OR
	key = 'or',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(2),
	--config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        --
    end,
    use = function()
		--
    end
})

SMODS.Consumable({ -- XOR
	key = 'xor',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(3),
	--config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        --
    end,
    use = function()
		--
    end
})

SMODS.Consumable({ -- NOT
	key = 'not',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(4),
	--config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        --
    end,
    use = function()
		--
    end
})

SMODS.Consumable({ -- NAND
	key = 'nand',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(5),
	--config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        --
    end,
    use = function()
		--
    end
})

SMODS.Consumable({ -- NOR
	key = 'nor',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(6),
	--config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        --
    end,
    use = function()
		--
    end
})

SMODS.Consumable({ -- XNOR
	key = 'xnor',
	set = 'Logic',
	atlas = 'showdown_logic',
    pos = coordinate(7),
	--config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        --
    end,
    use = function()
		--
    end
})