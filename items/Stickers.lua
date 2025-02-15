SMODS.Atlas({key = "showdown_stickers", path = "Stickers.png", px = 71, py = 95})
--[[
SMODS.Sticker({
	key = 'static',
	atlas = 'showdown_stickers',
	pos = coordinate(1, 5),
	badge_colour = HEX("727272"),
	default_compat = true,
	apply = function(self, card, val)
		card.ability[self.key] = val
		card.states.drag.can = not val
	end,
})
]]
SMODS.Sticker({
	key = 'cloud',
	atlas = 'showdown_stickers',
	pos = coordinate(2, 5),
	badge_colour = HEX("D0B0B8"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	calculate = function(self, card, context)
		if
			not context.repetition
			and (
				(context.joker_main and context.cardarea == G.jokers)
				or (context.main_scoring and context.cardarea == G.play)
				--or ((card.ability.set == 'Default' or card.ability.set == 'Enhanced') and context.cardarea == G.hand)
			)
		then
			ease_dollars(2)
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 2
			G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
			return {
				dollars = 2,
				colour = G.C.MONEY
			}
		end
	end
})

SMODS.Sticker({
	key = 'mushroom',
	atlas = 'showdown_stickers',
	pos = coordinate(3, 5),
	badge_colour = HEX("F00808"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	apply = function(self, card, val, forced)
		card.ability[self.key] = val
		if forced then
			if G.hand then G.hand:change_size(forced[1] and 1 or -1) end
		end
	end,
})

SMODS.Sticker({
	key = 'flower',
	atlas = 'showdown_stickers',
	pos = coordinate(4, 5),
	badge_colour = HEX("F87800"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	apply = function(self, card, val, forced)
		card.ability[self.key] = val
		if forced then
			if G.hand then G.consumeables:change_size(forced[1] and 1 or -1) end
		end
	end,
})

SMODS.Sticker({
	key = 'luigi',
	atlas = 'showdown_stickers',
	pos = coordinate(5, 5),
	badge_colour = HEX("006800"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	calculate = function(self, card, context)
		if
			not context.repetition
			and (
				(context.joker_main and context.cardarea == G.jokers)
				or (context.main_scoring and context.cardarea == G.play)
				--or ((card.ability.set == 'Default' or card.ability.set == 'Enhanced') and context.cardarea == G.hand)
			)
		then
			return {
                message = localize{type='variable',key='a_xmult',vars={1.5}},
                x_mult = 1.5,
                colour = G.C.RED,
			}
		end
	end,
})

SMODS.Sticker({
	key = 'mario',
	atlas = 'showdown_stickers',
	pos = coordinate(6, 5),
	badge_colour = HEX("B00000"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	calculate = function(self, card, context)
		if
			-- Joker (doesn't work)
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
})

SMODS.Sticker({
	key = 'star',
	atlas = 'showdown_stickers',
	pos = coordinate(7, 5),
	badge_colour = HEX("F8B000"),
	sets = { Joker = true, Default = true, Enhanced = true },
	should_apply = false,
	apply = function(self, card, val)
		card.ability[self.key] = val
		card:set_debuff()
	end,
})

function have_casino_sticker(card)
	return card.ability.showdown_cloud
		or card.ability.showdown_mushroom
		or card.ability.showdown_flower
		or card.ability.showdown_luigi
		or card.ability.showdown_mario
		or card.ability.showdown_star
end

local cardAdd_to_deckRef = Card.add_to_deck
function Card:add_to_deck(from_debuff)
	cardAdd_to_deckRef(self, from_debuff)
	if self.ability.showdown_mushroom then if G.hand then G.hand:change_size(1) end
	elseif self.ability.showdown_flower then if G.consumeables then G.consumeables:change_size(1) end end
end

local cardRemoveRef = Card.remove
function Card:remove()
	if not (self.area == G.shop_jokers or self.area == G.pack_cards) then
		if self.ability.showdown_mushroom then if G.hand then G.hand:change_size(-1) end
		elseif self.ability.showdown_flower then if G.consumeables then G.consumeables:change_size(-1) end end
	end
	cardRemoveRef(self)
end

local cardSetDebuffRef = Card.set_debuff
function Card:set_debuff(should_debuff)
	if self.ability.showdown_star then self.debuff = false
	else cardSetDebuffRef(self, should_debuff) end
end

for _, v in ipairs(SMODS.Sticker.obj_buffer) do
    local sticker = SMODS.Stickers[v]
    if
		sticker.key == 'showdown_cloud'
		or sticker.key == 'showdown_mushroom'
		or sticker.key == 'showdown_flower'
		or sticker.key == 'showdown_luigi'
		or sticker.key == 'showdown_mario'
		or sticker.key == 'showdown_star'
	then
        table.insert(Showdown.casino, sticker)
    end
end

local debugplus = require("debugplus")
if debugplus then
	local debugplusHandleKeysRef = debugplus.handleKeys
	function debugplus.handleKeys(controller, key, dt)
		if controller.hovering.target and controller.hovering.target:is(Card) then
			local _card = controller.hovering.target
			if key == "t" then
				if _card.ability.set == 'Joker' or _card.ability.set == 'Default' or _card.ability.set == 'Enhanced' then
					--SMODS.Sticker.obj_table.showdown_static:apply(_card, not _card.ability.showdown_static)
					print('no static sticker for u :P')
				end
			elseif key == "y" then
				if _card.ability.set == 'Joker' or _card.ability.set == 'Default' or _card.ability.set == 'Enhanced' then
					if _card.ability.showdown_cloud then
						SMODS.Sticker.obj_table.showdown_cloud:apply(_card, not _card.ability.showdown_cloud)
						SMODS.Sticker.obj_table.showdown_mushroom:apply(_card, not _card.ability.showdown_mushroom, {true})
					elseif _card.ability.showdown_mushroom then
						SMODS.Sticker.obj_table.showdown_mushroom:apply(_card, not _card.ability.showdown_mushroom, {false})
						SMODS.Sticker.obj_table.showdown_flower:apply(_card, not _card.ability.showdown_flower, {true})
					elseif _card.ability.showdown_flower then
						SMODS.Sticker.obj_table.showdown_flower:apply(_card, not _card.ability.showdown_flower, {false})
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