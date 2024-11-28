local showdown = SMODS.current_mod
local filesystem = NFS or love.filesystem
local loc = filesystem.load(showdown.path..'localization.lua')()

---- Functions

local function get_coordinates(position, width)
    if width == nil then width = 10 end
    return {x = (position) % width, y = math.floor((position) / width)}
end

local function coordinate(position, width)
    return get_coordinates(position - 1, width)
end

local function modCompatibility(modName, filePath)
	print("Showdown compatibility: "..modName.." is loaded!")
	filesystem.load(showdown.path..filePath)()
end

local function event(config)
    local e = Event(config)
    G.E_MANAGER:add_event(e)
    return e
end

local function getEnhancements()
	local cen_pool = {}
	for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
		if v.key ~= 'm_stone' then 
			cen_pool[#cen_pool+1] = v
		end
	end
	return cen_pool
end

local function findInTable(e, t)
	for k, v in pairs(t) do
		if v == e then return k end
	end
end

---- Mod Icon

SMODS.Atlas({key = "showdown_modicon", path = "Mod_icon.png", px = 36, py = 36})

---- Decks

SMODS.Atlas({key = "showdown_decks", path = "Decks.png", px = 71, py = 95})

SMODS.Back{ -- Counterpart Deck
	name = "Counterpart Deck",
	key = "counterpart",
	atlas = "showdown_decks",
	pos = coordinate(1),
	loc_txt = loc.counterpart,
	config = {counterpart_replacing = true},
	loc_vars = function(self) return {vars = {self.config.counterpart_replacing}} end
}

---- Counterpart Cards

SMODS.Atlas({key = "showdown_cards", path = "Ranks/Cards.png", px = 71, py = 95})
SMODS.Atlas({key = "showdown_cardsHC", path = "Ranks/CardsHC.png", px = 71, py = 95})

SMODS.Rank({ -- 2.5 Card
	key = '2.5',
	card_key = 'W',
	shorthand = '2.5',
	pos = { x = 0 },
	nominal = 2.5,
	next = { '3' },
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.two_half, 'name')
	end,
	decimal = true,
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards'
})

SMODS.Rank({ -- 5.5 Card
	key = '5.5',
	card_key = 'F',
	shorthand = '5.5',
	pos = { x = 1 },
	nominal = 5.5,
	next = { '6' },
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.five_half, 'name')
	end,
	decimal = true,
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards'
})

SMODS.Rank({ -- 8.5 Card
	key = '8.5',
	card_key = 'E',
	shorthand = '8.5',
	pos = { x = 2 },
	nominal = 8.5,
	next = { '9' },
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.eight_half, 'name')
	end,
	decimal = true,
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards'
})

SMODS.Rank({ -- Butler Card
	key = 'Butler',
	card_key = 'B',
	shorthand = 'B',
	pos = { x = 3 },
	nominal = 10.5,
	next = { 'Princess' },
	face = true,
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.butler, 'name')
	end,
	decimal = true,
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards'
})

SMODS.Rank({ -- Princess Card
	key = 'Princess',
	card_key = 'P',
	shorthand = 'P',
	pos = { x = 4 },
	nominal = 10.5,
	next = { 'Lord' },
	face = true,
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.princess, 'name')
	end,
	decimal = true,
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards'
})

SMODS.Rank({ -- Lord Card
	key = 'Lord',
	card_key = 'L',
	shorthand = 'L',
	pos = { x = 5 },
	nominal = 10.5,
	next = { 'Ace' },
	face = true,
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.lord, 'name')
	end,
	decimal = true,
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards'
})

SMODS.Rank({ -- 0 Card (counts as any suit and can't be converted to a wild card)
	key = 'Zero',
	card_key = 'Z',
	shorthand = '0',
	pos = { x = 6 },
	nominal = 0,
	next = { 'Ace' },
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.zero, 'name')
	end,
	suit_map = {
		Hearts = 0,
		Clubs = 0,
		Diamonds = 0,
		Spades = 0,
		Halberds = 0,
		Fleurons = 0,
	},
	straight_edge = true,
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards'
})

---- Consumables

-- Tarot

SMODS.Atlas({key = "showdown_tarots", path = "Consumables/Tarots.png", px = 71, py = 95})

SMODS.Consumable({ -- The Reflection
	key = 'Reflection',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	loc_txt = loc.reflection,
	config = {max_highlighted = 2},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
    pos = coordinate(1),
	can_use = function()
		-- if up to 2 cards are selected and have counterparts
        return true
    end,
    use = function()
		print("The Reflection card is used")
        -- convert selected cards into their counterparts
    end
})

SMODS.Consumable({ -- The Vessel
	key = 'Vessel',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	loc_txt = loc.vessel,
	config = {max_highlighted = 1},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
    pos = coordinate(2),
	can_use = function()
		if G.hand and #G.hand.highlighted == 1 then
            return true
        end
        return false
    end,
    use = function()
		print("The Vessel card is used")
        -- convert selected card to a 0 with a random enhancement or seal
    end
})

SMODS.Consumable({ -- The Genie
	key = 'Genie',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	loc_txt = loc.genie,
	config = { create = 1 },
    loc_vars = function(self) return {vars = {self.config.create}} end,
    pos = coordinate(3),
	can_use = function(self, card)
		return #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables
    end,
    use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.consumeable.create, G.consumeables.config.card_limit - #G.consumeables.cards) do
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						play_sound("timpani")
						local _card = create_card("Mathematic", G.consumeables, nil, nil, nil, nil, nil, "showdown_genie")
						_card:add_to_deck()
						G.consumeables:emplace(_card)
						card:juice_up(0.3, 0.5)
					end
					return true
				end,
			}))
		end
		delay(0.6)
    end
})

-- Spectral

SMODS.Atlas({key = "showdown_spectrals", path = "Consumables/Spectrals.png", px = 71, py = 95})

SMODS.Consumable({ -- Mist
	key = 'Mist',
	set = 'Spectral',
	atlas = 'showdown_spectrals',
	loc_txt = loc.mist,
	config = {max_highlighted = 6},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
    pos = coordinate(1),
	can_use = function()
		-- if hand has at least 6 cards
        return true
    end,
    use = function()
		print("Mist card is used")
        -- select 6 random cards and converts them into either an ace or a 0
    end
})

SMODS.Consumable({ -- Vision
	key = 'Vision',
	set = 'Spectral',
	atlas = 'showdown_spectrals',
	loc_txt = loc.vision,
    pos = coordinate(2),
	can_use = function()
		-- if hand contains card
        return true
    end,
    use = function()
		print("Vision card is used")
        -- convert all cards in hand into their higher/equal counterpart and removes their enhancement, edition or seal
    end
})

-- Mathematic (gives bonuses by sacrificing cards)

SMODS.Atlas({key = 'showdown_mathematic_undiscovered', path = 'Consumables/MathematicsUndiscovered.png', px = 71, py = 95})
SMODS.Atlas({key = 'showdown_mathematic', path = 'Consumables/Mathematics.png', px = 71, py = 95})

SMODS.ConsumableType{
    key = 'Mathematic',
    primary_colour = G.C.SHOWDOWN_MATHEMATIC,
    secondary_colour = G.C.SHOWDOWN_MATHEMATIC_DARK,
    loc_txt = loc.mathematic,
    collection_rows = {4, 4}
}

SMODS.UndiscoveredSprite{
    key = 'Mathematic',
    atlas = 'showdown_mathematic_undiscovered',
    pos = coordinate(1)
}

SMODS.Consumable({ -- Constant
	key = 'Constant',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.constant,
    pos = coordinate(1),
	can_use = function()
        -- idk
        return true
    end,
    use = function()
		print("Constant card is used")
        -- idk
    end
})

SMODS.Consumable({ -- Variable
	key = 'Variable',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.variable,
    pos = coordinate(2),
	can_use = function()
        -- idk
        return true
    end,
    use = function()
		print("Variable card is used")
        -- idk
    end
})

SMODS.Consumable({ -- Function
	key = 'Function',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.functio, -- no n because it fucks with lua
    pos = coordinate(3),
	config = {max_highlighted = 4, toDestroy = 1},
    loc_vars = function(self) return {vars = {self.config.max_highlighted, self.config.toDestroy}} end,
	can_use = function(self)
        if G.hand and #G.hand.highlighted == self.config.max_highlighted then
            return true
        end
        return false
    end,
    use = function(self)
		for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            event({trigger = 'after', delay = 0.15, func = function()
                G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3, 0.3);
            return true end })
        end
		local cen_pool = getEnhancements()
		for i=1, #G.hand.highlighted do
            event({trigger = 'after', delay = 0.1, func = function()
                G.hand.highlighted[i]:set_ability(pseudorandom_element(cen_pool, pseudoseed('spe_card')), true);
            return true end })
        end
        delay(0.2)
		for i=self.config.toDestroy, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function()
				local card = pseudorandom_element(G.hand.highlighted, pseudoseed('seed')); card:start_dissolve();
				table.remove(G.hand.highlighted, findInTable(card, G.hand.highlighted))
            return true end })
        end
		for i=1, #G.hand.highlighted do
            local percent = 0.85 + ( i - 0.999 ) / ( #G.hand.highlighted - 0.998 ) * 0.3
            event({trigger = 'after', delay = 0.15, func = function()
                if G.hand.highlighted[i] ~= nil then G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3); end
            return true end })
		end
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
})

SMODS.Consumable({ -- Shape
	key = 'Shape',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.shape,
    pos = coordinate(4),
	config = {max_highlighted = 4, toDestroy = 2},
    loc_vars = function(self) return {vars = {self.config.max_highlighted, self.config.toDestroy}} end,
	can_use = function(self)
        if G.hand and #G.hand.highlighted == self.config.max_highlighted then
            return true
        end
        return false
    end,
    use = function(self)
		for i=1, #G.hand.highlighted do
            event({trigger = 'after', delay = 0.1, func = function()
				local edition = poll_edition(nil, nil, nil, true); G.hand.highlighted[i]:set_edition(edition, true);
            return true end })
        end
        delay(0.2)
		for i=self.config.toDestroy, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function()
				local card = pseudorandom_element(G.hand.highlighted, pseudoseed('seed')); card:start_dissolve(nil, i == 1);
				table.remove(G.hand.highlighted, findInTable(card, G.hand.highlighted))
            return true end })
        end
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
})

SMODS.Consumable({ -- Vector
	key = 'Vector',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.vector,
    pos = coordinate(5),
	config = {max_highlighted = 5},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        if G.hand and #G.hand.highlighted <= self.config.max_highlighted then
            return true
        end
        return false
    end,
    use = function()
		print("Vector card is used")
        -- idk
    end
})

SMODS.Consumable({ -- Probability
	key = 'Probability',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.probability,
    pos = coordinate(6),
	config = {max_highlighted = 3, mult_joker = 1.25},
    loc_vars = function(self) return {vars = {self.config.max_highlighted, self.config.mult_joker}} end,
	can_use = function(self)
        if G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1 then
            return true
        end
        return false
    end,
    use = function()
		print("Probability card is used")
        -- idk
    end
})

SMODS.Consumable({ -- Sequence
	key = 'Sequence',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.sequence,
    pos = coordinate(7),
	config = {max_highlighted = 3},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
	can_use = function()
        if G.hand and #G.hand.highlighted <= 5 and #G.hand.highlighted >= 1 then
            return true
        end
        return false
    end,
    use = function(self, card, area, copier)
		local text, disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
		local used_consumable = copier or card
		update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
		level_up_hand(used_consumable, text, nil, 3)
		update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
		for i=#G.hand.highlighted, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function()
                if G.hand.highlighted ~= nil then G.hand.highlighted[i]:start_dissolve(nil, i == 1); end
            return true end })
        end
		
    end
})

SMODS.Consumable({ -- Operation
	key = 'Operation',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.operation,
    pos = coordinate(8),
	config = {max_highlighted = 2},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
	can_use = function()
        if G.hand and #G.hand.highlighted == 2 then
            return true
        end
        return false
    end,
    use = function()
		print("Operation card is used")
        -- idk
    end
})
--[[
SMODS.Consumable({ -- I HAVE TO DELETE THIS (this is for undiscovered sprite)
	key = 'test2',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.a,
    pos = coordinate(9),
})
]]--
---- Vouchers

SMODS.Atlas({key = 'showdown_vouchers', path = 'Consumables/Vouchers.png', px = 71, py = 95})

SMODS.Voucher({ -- Irrational Numbers
	key = 'Irrational',
	atlas = 'showdown_vouchers',
	loc_txt = loc.irrational,
    unlocked = false,
	pos = coordinate(1),
	check_for_unlock = function()
        -- if 20 counterpart cards in deck
    end,
})

SMODS.Voucher({ -- Transcendant Numbers
	key = 'Transcendant',
	atlas = 'showdown_vouchers',
	loc_txt = loc.transcendant,
    unlocked = false,
    requires = {'showdown_Irrational'},
	pos = coordinate(3, 2),
	check_for_unlock = function()
        -- if 10 counterpart cards in deck with one or more modifiers
    end,
})

SMODS.Voucher({ -- Number Theory
	key = 'Number',
	atlas = 'showdown_vouchers',
	loc_txt = loc.numberTheory,
    unlocked = true,
	pos = coordinate(2),
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.math_rate = (G.GAME.math_rate or 0) + 4
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.math_rate = math.max(0, G.GAME.math_rate - 4)
				return true
			end,
		}))
	end,
})

SMODS.Voucher({ -- Axiom of Infinity
	key = 'Axiom',
	atlas = 'showdown_vouchers',
	loc_txt = loc.axiomInfinity,
    unlocked = true,
    requires = {'showdown_Number'},
	pos = coordinate(4, 2),
})

---- Booster Packs

SMODS.Atlas({key = 'showdown_booster_packs_mathematic', path = 'BoostersMathematic.png', px = 71, py = 95})

for i = 1, 4 do
    SMODS.Booster{
        key = 'calculus_'..(i <= 2 and i or i == 3 and 'jumbo' or 'mega'), loc_txt = loc.calculus,

        config = {extra = i <= 2 and 2 or 4, choose =  i <= 3 and 1 or 2},
        draw_hand = true,

        create_card = function(self, card)
            return create_card('Mathematic', G.pack_cards, nil, nil, true, true, nil, 'showdown_calculus')
        end,
		--[[
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_CALCULUS)
            ease_background_colour{new_colour = G.C.RED, special_colour = G.C.BLACK, contrast = 2}
        end,
		]]--
        pos = coordinate(i),
        atlas = 'showdown_booster_packs_mathematic',

        in_pool = function() return (pseudorandom('calculus'..G.SEED) < 0.5) end
    }
end

---- Jokers

--SMODS.Atlas({key = "showdown_jokers", path = "Ranks/Cards.png", px = 71, py = 95})

SMODS.Joker({
	key = 'Pinpoint',
	rarity = 2,
	--atlas = 'showdown_jokers',
	loc_txt = loc.pinpoint,
})

if (SMODS.Mods["Bunco"] or {}).can_load then
	modCompatibility("Bunco", "compat/buncoCompat.lua")
end
if (SMODS.Mods["Cryptid"] or {}).can_load then
	modCompatibility("Cryptid", "compat/cryptidCompat.lua")
end