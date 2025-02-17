local consumeable_type = {
	type = 'ConsumableType',
    key = 'Logic',
    primary_colour = G.C.SHOWDOWN_LOGIC,
    secondary_colour = G.C.SHOWDOWN_LOGIC_DARK,
    collection_rows = {4, 4}
}

local undiscovered_sprite = {
	type = 'UndiscoveredSprite',
    key = 'Logic',
    atlas = 'showdown_logic_undiscovered',
    pos = coordinate(1)
}

local logic_and = {
    type = 'Consumable',
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
}

local logic_or = {
    type = 'Consumable',
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
}

local logic_xor = {
    type = 'Consumable',
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
}

local logic_not = {
    type = 'Consumable',
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
}

local logic_nand = {
    type = 'Consumable',
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
}

local logic_nor = {
    type = 'Consumable',
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
}

local logic_xnor = {
    type = 'Consumable',
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
}

return {
	enabled = Showdown.config["Consumeables"]["Logics"],
	list = function ()
		local list = {
			consumeable_type,
			undiscovered_sprite,
			logic_and,
            logic_or,
            logic_xor,
            logic_not,
            logic_nand,
            logic_nor,
            logic_xnor,
		}
		return list
	end,
	atlases = {
		{key = 'showdown_logic_undiscovered', path = 'Consumables/LogicUndiscovered.png', px = 71, py = 95},
        {key = 'showdown_logic', path = 'Consumables/Logic.png', px = 71, py = 95},
	},
}