local strange = {
    type = 'Consumable',
	key = 'strange_thing',
	set = 'Unique',
	atlas = 'showdown_cryptidUnique',
    pos = coordinate(1),
	config = { extra = {Xmult_min = 1, Xmult_max = 2}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_min, card.ability.extra.Xmult_max } }
	end,
	can_use = function()
        return true
    end,
    use = function(self, card, area, copier)
        local _card = SMODS.create_card({set = 'Joker', area = G.jokers, key = 'j_showdown_infection', edition = { negative = true }})
        _card:add_to_deck()
        G.jokers:emplace(_card)
        _card.ability.extra.Xmult = tonumber(('%%.%dg'):format(2.11):format((card.ability.extra.Xmult_min + math.random() * card.ability.extra.Xmult_max)))
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if G.GAME.infection and not G.GAME.infection.triggered_this_shop then -- strange thing values persist between games
            card.ability.extra.Xmult_min = self.config.extra.Xmult_min * (G.GAME.infection and G.GAME.infection.value or 1)
            card.ability.extra.Xmult_max = self.config.extra.Xmult_max * (G.GAME.infection and G.GAME.infection.value or 1)
            G.GAME.infection.triggered_this_shop = true
        end
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
	exec = function()
        local GFUNCStoggle_shopRef = G.FUNCS.toggle_shop
        G.FUNCS.toggle_shop = function(e)
            GFUNCStoggle_shopRef(e)
            if G.shop and G.GAME.infection then
                G.GAME.infection.triggered_this_shop = false
            end
        end
	end,
}