local static = {
	type = 'Sticker',
	order = 1,
	key = 'static',
	atlas = 'showdown_stickers',
	pos = coordinate(1, 5),
	badge_colour = HEX("727272"),
	should_apply = false,
	apply = function(self, card)
		card.ability[self.key] = not card.ability[self.key]
		card.states.drag.can = not card.states.drag.can
	end,
}

local cloud = {
	type = 'Sticker',
	order = 2,
	key = 'cloud',
	atlas = 'showdown_stickers',
	pos = coordinate(2, 5),
	badge_colour = HEX("D0B0B8"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	casino = true,
	calculate = function(self, card, context)
		if
			not context.repetition
			and (
				(context.joker_main and context.cardarea == G.jokers)
				or (context.main_scoring and context.cardarea == G.play)
			)
		then
			return {
				dollars = 2,
				colour = G.C.MONEY
			}
		end
	end
}

local mushroom = {
	type = 'Sticker',
	order = 3,
	key = 'mushroom',
	atlas = 'showdown_stickers',
	pos = coordinate(3, 5),
	badge_colour = HEX("F00808"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	casino = true,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
			G.E_MANAGER:add_event(Event({func = function()
				ease_discard(1)
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_discards', vars = {1}}})
			return true end }))
			return { card = card }, true
		end
	end
}

local flower = {
	type = 'Sticker',
	order = 4,
	key = 'flower',
	atlas = 'showdown_stickers',
	pos = coordinate(4, 5),
	badge_colour = HEX("F87800"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	casino = true,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
			G.E_MANAGER:add_event(Event({func = function()
				ease_hands_played(1)
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_hands', vars = {1}}})
			return true end }))
			return { card = card }, true
		end
	end
}

local luigi = {
	type = 'Sticker',
	order = 5,
	key = 'luigi',
	atlas = 'showdown_stickers',
	pos = coordinate(5, 5),
	badge_colour = HEX("006800"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	casino = true,
	calculate = function(self, card, context)
		if
			not context.repetition
			and (
				(context.joker_main and context.cardarea == G.jokers)
				or (context.main_scoring and context.cardarea == G.play)
			)
		then
			return {
                x_mult = 1.5,
                colour = G.C.RED,
			}
		end
	end,
}

local mario = {
	type = 'Sticker',
	order = 6,
	key = 'mario',
	atlas = 'showdown_stickers',
	pos = coordinate(6, 5),
	badge_colour = HEX("B00000"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	casino = true,
	calculate = function(self, card, context)
		if
			-- Joker
			(context.retrigger_joker_check and not context.retrigger_joker and context.other_card == card)
			-- Playing Card
			or ((card.ability.set == "Default" or card.ability.set == "Enhanced") and context.repetition)
		then
			return {
				message = localize("k_again_ex"),
				repetitions = 1,
				card = card,
			}
		end
	end
}

local star = {
	type = 'Sticker',
	order = 7,
	key = 'star',
	atlas = 'showdown_stickers',
	pos = coordinate(7, 5),
	badge_colour = HEX("F8B000"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	casino = true,
	apply = function(self, card, val)
		card.ability[self.key] = val
		card:set_debuff()
	end,
}

local xor_retrigger = {
	type = 'Sticker',
	order = 8,
	key = 'xor_retrigger',
	atlas = 'showdown_stickers',
	pos = coordinate(999, 5),
	badge_colour = G.C.SHOWDOWN_BOOLEAN,
	sets = { Joker = true, Default = false, Enhanced = false },
	should_apply = false,
	apply = function(self, card, val)
		card.ability[self.key] = val
	end,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == card then
			return {
				message = localize("k_again_ex"),
				repetitions = 1,
				card = card,
			}
		elseif context.end_of_round then
			SMODS.Stickers['showdown_xor_retrigger']:apply(card, false)
		end
	end
}

return {
	enabled = Showdown.config["Stickers"],
	list = function ()
		local list = {
			static,
			cloud,
			mushroom,
			flower,
			luigi,
			mario,
			star,
			xor_retrigger,
		}
		return list
	end,
	atlases = {
		{key = "showdown_stickers", path = "Stickers.png", px = 71, py = 95},
	},
	exec = function()
		function have_casino_sticker(card)
			return card.ability.showdown_cloud
				or card.ability.showdown_mushroom
				or card.ability.showdown_flower
				or card.ability.showdown_luigi
				or card.ability.showdown_mario
				or card.ability.showdown_star
		end
		
		local cardSetDebuffRef = Card.set_debuff
		function Card:set_debuff(should_debuff)
			if self.ability.showdown_star then self.debuff = false
			else cardSetDebuffRef(self, should_debuff) end
		end

		local cardCalculate_jokerRef = Card.calculate_joker
		function Card:calculate_joker(context)
			local eval = cardCalculate_jokerRef(self, context)
			if self.ability.showdown_static then
				self.states.drag.can = false
			end
			return eval
		end
		
		if prequire("debugplus") then
			local debugplus = require("debugplus")
			local debugplusHandleKeysRef = debugplus.handleKeys
			function debugplus.handleKeys(controller, key, dt)
				if controller.hovering.target and controller.hovering.target:is(Card) then
					local _card = controller.hovering.target
					if key == "t" then
						if _card.ability.set == 'Joker' then
							SMODS.Sticker.obj_table.showdown_static:apply(_card, not _card.ability.showdown_static)
						end
					elseif key == "y" then
						if _card.ability.set == 'Joker' or _card.ability.set == 'Default' or _card.ability.set == 'Enhanced' then
							if _card.ability.showdown_cloud then
								SMODS.Sticker.obj_table.showdown_cloud:apply(_card, not _card.ability.showdown_cloud)
								SMODS.Sticker.obj_table.showdown_mushroom:apply(_card, not _card.ability.showdown_mushroom)
							elseif _card.ability.showdown_mushroom then
								SMODS.Sticker.obj_table.showdown_mushroom:apply(_card, not _card.ability.showdown_mushroom)
								SMODS.Sticker.obj_table.showdown_flower:apply(_card, not _card.ability.showdown_flower)
							elseif _card.ability.showdown_flower then
								SMODS.Sticker.obj_table.showdown_flower:apply(_card, not _card.ability.showdown_flower)
								SMODS.Sticker.obj_table.showdown_luigi:apply(_card, not _card.ability.showdown_luigi)
							elseif _card.ability.showdown_luigi then
								SMODS.Sticker.obj_table.showdown_luigi:apply(_card, not _card.ability.showdown_luigi)
								SMODS.Sticker.obj_table.showdown_mario:apply(_card, not _card.ability.showdown_mario)
							elseif _card.ability.showdown_mario then
								SMODS.Sticker.obj_table.showdown_mario:apply(_card, not _card.ability.showdown_mario)
								SMODS.Sticker.obj_table.showdown_star:apply(_card, not _card.ability.showdown_star)
							elseif _card.ability.showdown_star then
								SMODS.Sticker.obj_table.showdown_star:apply(_card, not _card.ability.showdown_star)
							else
								SMODS.Sticker.obj_table.showdown_cloud:apply(_card, not _card.ability.showdown_cloud)
							end
						end
					end
				end
				debugplusHandleKeysRef(controller, key, dt)
			end
		end
	end,
	post_exec = function()
		for _, v in ipairs(SMODS.Sticker.obj_buffer) do
			local sticker = SMODS.Stickers[v]
			if sticker.casino then
				table.insert(Showdown.casino, sticker)
			end
		end
	end
}