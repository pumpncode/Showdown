local ghost = {
	type = 'Enhancement',
	order = 1,
	key = 'ghost',
	atlas = 'showdown_enhancements',
	pos = coordinate(1, 7),
	config = {extra = {x_mult = 1.25, x_chips = 1.25, shatter_chance = 8}},
	loc_vars = function(self, info_queue, card)
		if card then
			return {vars = {card.ability.extra.x_mult, card.ability.extra.x_chips, card.ability.extra.shatter_chance, G.GAME.probabilities.normal}}
		end
		return {vars = {self.config.extra.x_mult, self.config.extra.x_chips, self.config.extra.shatter_chance, G.GAME.probabilities.normal}}
	end,
	calculate = function(self, card, context)
		if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
				x_mult = card.ability.extra.x_mult,
				x_chips = card.ability.extra.x_chips,
				card = card
			}
		elseif
			context.destroy_card
			and context.cardarea == G.play
			and context.destroy_card == card
			and not card.debuff
			and pseudorandom('ghost') < G.GAME.probabilities.normal/card.ability.extra.shatter_chance
		then
			return { remove = true }
		end
	end
}

local holy = {
	type = 'Enhancement',
	order = 2,
	key = 'holy',
	atlas = 'showdown_enhancements',
	pos = coordinate(2, 7),
	config = {extra = {x_mult = 1, x_mult_gain = 0.05}},
	loc_vars = function(self, info_queue, card)
		if card then
			return {vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_gain}}
		end
		return {vars = {self.config.extra.x_mult, self.config.extra.x_mult_gain}}
	end,
	calculate = function(self, card, context)
		if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
	end
}

return {
	enabled = Showdown.config["Enhancements"],
	list = function ()
		local list = {
			ghost,
			holy,
		}
		return list
	end,
	atlases = {
		{key = 'showdown_enhancements', path = 'Enhancements.png', px = 71, py = 95},
	},
	exec = function()
		local Centergenerate_uiRef = SMODS.Center.generate_ui
		function SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
			if specific_vars then
				if not specific_vars.debuffed then
					if specific_vars.act_as then
						localize{type = 'other', key = 'act_as', nodes = desc_nodes, vars = {specific_vars.act_as}}
					end
					if specific_vars.default_wild then
						localize{type = 'other', key = 'default_wild', nodes = desc_nodes, vars = {}}
					end
				end
			end
			Centergenerate_uiRef(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		end
	end
}