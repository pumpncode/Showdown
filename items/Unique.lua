local strange = {
    type = 'Consumable',
	key = 'strange_thing',
	set = 'Unique',
	atlas = 'showdown_cryptidUnique',
    pos = coordinate(1),
	config = { extra = {Xmult_min = 1, Xmult_max = 2}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.extra.Xmult_min, card.config.extra.Xmult_max } }
	end,
	can_use = function()
        return true
    end,
    use = function(self, card, area, copier)
        local _card = SMODS.create_card({set = 'Joker', area = G.jokers, key = 'j_showdown_infection', edition = { negative = true }})
        _card:add_to_deck()
        G.jokers:emplace(_card)
        _card.ability.extra.Xmult = tonumber(('%%.%dg'):format(2.11):format(card.config.extra.Xmult_min + (math.random() * card.config.extra.Xmult_max)))
    end,
    calculate = function(self, card, context)
        -- G.GAME.infection_value
    end,
}

return {
	enabled = (SMODS.Mods["Cryptid"] or {}).can_load and Showdown.config["CrossMod"]["Cryptid"],
	list = function()
		local list = {}
        if Showdown.config["Jokers"]["Normal"] then
            table.insert(list, strange)
        end
		return list
	end,
	atlases = {
		{key = "showdown_cryptidUnique", path = "CrossMod/Cryptid/Unique.png", px = 71, py = 95},
	},
}