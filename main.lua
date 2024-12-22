showdown = SMODS.current_mod
filesystem = NFS or love.filesystem
loc = filesystem.load(showdown.path..'localization.lua')()

---- Functions

function get_coordinates(position, width)
    if width == nil then width = 10 end
    return {x = (position) % width, y = math.floor((position) / width)}
end

---Get card texture coordinates on the atlas
---@param position integer
---@param width integer|nil
---@return table
function coordinate(position, width)
    return get_coordinates(position - 1, width)
end

function modCompatibility(modName, filePath)
	sendInfoMessage("Mod Compatibility: "..modName.." is loaded!", "Showdown")
	filesystem.load(showdown.path..filePath)()
end

function event(config)
    local e = Event(config)
    G.E_MANAGER:add_event(e)
    return e
end

---Finds the index of a value in a table
---@param e any
---@param t table
---@return integer|nil
function findInTable(e, t)
	for k, v in pairs(t) do
		if v == e then return k end
	end
end

---Gives the list of all enhancements
---@param blacklist table|nil Enhancements that cannot be selected
---@return table
function getEnhancements(blacklist)
	if not blacklist then blacklist = {} end
	local cen_pool = {}
	for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
		if not findInTable(v.key, blacklist) then
			cen_pool[#cen_pool+1] = v
		end
	end
	return cen_pool
end

---Gives the content of a table (if table is to big, Balatro can crash)
---@param tbl table
---@param indent integer|nil
function tprint(tbl, indent)
	if not indent then indent = 0 end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if (type(k) == "number") then
			toprint = toprint .. "[" .. k .. "] = "
		elseif (type(k) == "string") then
			toprint = toprint  .. k ..  "= "   
		end
		if (type(v) == "number") then
			toprint = toprint .. v .. ",\r\n"
		elseif (type(v) == "string") then
			toprint = toprint .. "\"" .. v .. "\",\r\n"
		elseif (type(v) == "table") then
			toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
		end
	end
	toprint = toprint .. string.rep(" ", indent-2) .. "}"
	return toprint
end

function flipCard(card, i, setSize)
	if not card then return end
	if not i then i = 1 end
	local percent = 1.15 - (i-0.999)/(setSize-0.998)*0.3
	event({trigger = 'after', delay = 0.15, func = function()
		card:flip(); play_sound('card1', percent); card:juice_up(0.3, 0.3);
	return true end })
end

function unflipCard(card, i, setSize)
	if not card then return end
	if not i then i = 1 end
	local percent = 0.85 + ( i - 0.999 ) / ( setSize - 0.998 ) * 0.3
	event({trigger = 'after', delay = 0.15, func = function()
		card:flip(); play_sound('tarot2', percent, 0.6); card:juice_up(0.3, 0.3);
	return true end })
end

function create_joker(joker) -- Thanks Bunco
	-- Sprite atlas
    local atlas
	if not joker.atlas then 
		atlas = "showdown_placeholders"
	end

    -- Key generation from name
    local key = string.gsub(string.lower(joker.name), '%s', '_') -- Removes spaces and uppercase letters

    -- Rarity conversion
    if joker.rarity == 'Common' then
        joker.rarity = 1
    elseif joker.rarity == 'Uncommon' then
        joker.rarity = 2
    elseif joker.rarity == 'Rare' then
        joker.rarity = 3
    elseif joker.rarity == 'Legendary' then
        joker.rarity = 4
    end

    -- Soul sprite
	if joker.rarity == 'Legendary' then
		joker.soul = joker.pos -- Calculates coordinates based on the position variable
	end

    -- Config values
    if not joker.vars then joker.vars = {} end
    joker.config = {extra = {}}
    for _, kv_pair in ipairs(joker.vars) do
        -- kv_pair is {a = 1}
        local k, v = next(kv_pair)
        joker.config.extra[k] = v
    end

    -- Joker creation
    SMODS.Joker{
        name = joker.name,
        key = key,

        atlas = joker.atlas or atlas,
        pos = joker.pos,
        soul_pos = joker.soul,

        rarity = joker.rarity,
        cost = joker.cost,

        unlocked = joker.unlocked,
        check_for_unlock = joker.check_for_unlock,
        unlock_condition = joker.unlock_condition,
        discovered = false,

        blueprint_compat = joker.blueprint,
        eternal_compat = joker.eternal,
        perishable_compat = joker.perishable,

        loc_txt = joker.loc_txt,
        process_loc_text = joker.process_loc_text,

        config = joker.custom_config or joker.config,
        loc_vars = joker.custom_vars or function(self, info_queue, card)

            -- Localization values
            local vars = {}

            for _, kv_pair in ipairs(joker.vars) do
                -- kv_pair is {a = 1}
                local k, v = next(kv_pair)
                -- k is `a`, v is `1`
                table.insert(vars, card.ability.extra[k])
            end

            return {vars = vars}
        end,

        calculate = joker.calculate,
        update = joker.update,
        remove_from_deck = joker.remove,
        add_to_deck = joker.add,
        set_ability = joker.set_ability,
        set_sprites = joker.set_sprites,
        load = joker.load,
        in_pool = joker.custom_in_pool or pool,

        effect = joker.effect
	}
end

function forced_message(message, card, color, delay, juice) -- Thanks Bunco
    if delay == true then
        delay = 0.7 * 1.25
    elseif delay == nil then
        delay = 0
    end

    event({trigger = 'before', delay = delay, func = function()

        if juice then juice:juice_up(0.7) end

        card_eval_status_text(
            card,
            'extra',
            nil, nil, nil,
            {message = message, colour = color, instant = true}
        )
        return true
    end})
end

if not (SMODS.Mods["Paperback"] or {}).can_load then
	local start_dissolve_ref = Card.start_dissolve
	function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice) -- Thanks Paperback
		if self.getting_sliced then
			for i = 1, #G.jokers.cards do
				G.jokers.cards[i]:calculate_joker({ destroying_cards = true, destroyed_card = self })
			end
		end

		start_dissolve_ref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
	end
end

-- Dictionary wrapper

function showdown.process_loc_text()
    SMODS.process_loc_text(G.localization.descriptions.Other, 'counterpart_ranks', loc.counterpart_ranks)
    G.P_CENTERS['counterpart_ranks'] = {key = 'counterpart_ranks', set = 'Other'}
end

---- Mod Icon

SMODS.Atlas({key = "showdown_modicon", path = "ModIcon.png", px = 36, py = 36})

---- Deck Skin

SMODS.Atlas({key = "showdown_jean_paul", path = "DeckSkins/jean_paul.png", px = 71, py = 95})
SMODS.Atlas({key = "showdown_jean_paul_hc", path = "DeckSkins/jean_paul_hc.png", px = 71, py = 95})

SMODS.DeckSkin({
	key = "JeanPaul",
	suit = "Clubs",
	ranks = {
		"Jack", "Queen", "King"
	},
	lc_atlas = "showdown_jean_paul",
	hc_atlas = "showdown_jean_paul_hc",
	loc_txt = loc.jean_paul,
	posStyle = 'collab'
})

---- Decks

SMODS.Atlas({key = "showdown_decks", path = "Decks.png", px = 71, py = 95})

SMODS.Back{ -- Mirror Deck
	name = "Mirror Deck",
	key = "Mirror",
	--atlas = "showdown_decks",
	atlas = "showdown_placeholders",
	--pos = coordinate(1),
	pos = coordinate(15, 5),
	loc_txt = loc.mirror_deck,
	config = {counterpart_replacing = true},
	loc_vars = function(self)
		return {vars = {self.config.counterpart_replacing, localize{type = 'name_text', set = 'Other', key = 'counterpart_ranks'}}}
	end
}

---- Counterpart Cards

SMODS.Atlas({key = "showdown_cards", path = "Ranks/Cards.png", px = 71, py = 95})
SMODS.Atlas({key = "showdown_cardsHC", path = "Ranks/CardsHC.png", px = 71, py = 95})
SMODS.Atlas({key = "showdown_unknownSuit", path = "Ranks/Unknown.png", px = 71, py = 95})

baseSuits = {'Diamonds', 'Clubs', 'Hearts', 'Spades'}
extraSuits = {}

local function inject_p_card_suit_compat(suit, rank)
	local card = {
		name = rank.key .. ' of ' .. suit.key,
		value = rank.key,
		suit = suit.key,
		pos = { x = rank.pos.x, y = rank.suit_map[suit.key] or suit.pos.y },
		lc_atlas = rank.suit_map[suit.key] and rank.lc_atlas or suit.lc_atlas,
		hc_atlas = rank.suit_map[suit.key] and rank.hc_atlas or suit.hc_atlas,
	}
	if not findInTable(card.suit, baseSuits) then
		if not extraSuits[card.suit] then
			sendWarnMessage("Unknown suit for "..card.name, "Showdown")
			card.lc_atlas = 'showdown_unknownSuit'
			card.hc_atlas = 'showdown_unknownSuit'
			card.pos = {x = 0, y = 0}
		else
			card.lc_atlas = extraSuits[card.suit].lc_atlas
			card.hc_atlas = extraSuits[card.suit].hc_atlas
		end
	end
	G.P_CARDS[suit.card_key .. '_' .. rank.card_key] = card
end

SMODS.Rank({ -- 2.5 Card
	key = '2.5',
	card_key = 'W',
	shorthand = '2.5',
	pos = { x = 0 },
	nominal = 2.5,
	next = { '3' },
	max_id = {
		value = -3,
	},
	loc_txt = loc.two_half,
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, self.loc_txt, 'name')
		--SMODS.process_loc_text(G.localization.descriptions.Other[self.set], self.key, self.loc_txt, 'label')
	end,
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards',
	inject = function(self)
		for _, suit in pairs(SMODS.Suits) do
			inject_p_card_suit_compat(suit, self)
		end
	end,
}) -- id: -2

SMODS.Rank({ -- 5.5 Card
	key = '5.5',
	card_key = 'F',
	shorthand = '5.5',
	pos = { x = 1 },
	nominal = 5.5,
	next = { '6' },
	loc_txt = loc.five_half,
	max_id = {
		value = -6,
	},
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards',
	inject = function(self)
		for _, suit in pairs(SMODS.Suits) do
			inject_p_card_suit_compat(suit, self)
		end
	end,
}) -- id: -5

SMODS.Rank({ -- 8.5 Card
	key = '8.5',
	card_key = 'E',
	shorthand = '8.5',
	pos = { x = 2 },
	nominal = 8.5,
	next = { '9' },
	loc_txt = loc.eight_half,
	max_id = {
		value = -9,
	},
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards',
	inject = function(self)
		for _, suit in pairs(SMODS.Suits) do
			inject_p_card_suit_compat(suit, self)
		end
	end,
}) -- id: -8

SMODS.Rank({ -- Butler Card
	key = 'Butler',
	card_key = 'B',
	shorthand = 'B',
	pos = { x = 3 },
	nominal = 10.5,
	face_nominal = 0.1,
	next = { 'showdown_Princess', 'Queen' },
	face = true,
	loc_txt = loc.butler,
	max_id = {
		value = -12,
	},
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards',
	inject = function(self)
		for _, suit in pairs(SMODS.Suits) do
			inject_p_card_suit_compat(suit, self)
		end
	end,
}) -- id: -11

SMODS.Rank({ -- Princess Card
	key = 'Princess',
	card_key = 'P',
	shorthand = 'P',
	pos = { x = 4 },
	nominal = 10.5,
	face_nominal = 0.2,
	next = { 'showdown_Lord', 'King' },
	face = true,
	loc_txt = loc.princess,
	max_id = {
		value = -13,
	},
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards',
	inject = function(self)
		for _, suit in pairs(SMODS.Suits) do
			inject_p_card_suit_compat(suit, self)
		end
	end,
}) -- id: -12

SMODS.Rank({ -- Lord Card
	key = 'Lord',
	card_key = 'L',
	shorthand = 'L',
	pos = { x = 5 },
	nominal = 10.5,
	face_nominal = 0.3,
	next = { 'Ace' },
	face = true,
	loc_txt = loc.lord,
	max_id = {
		value = -14,
	},
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards',
	inject = function(self)
		for _, suit in pairs(SMODS.Suits) do
			inject_p_card_suit_compat(suit, self)
		end
	end,
}) -- id: -13

SMODS.Rank({ -- 0 Card (counts as any suit and can't be converted to a wild card)
	key = 'Zero',
	card_key = 'Z',
	shorthand = '0',
	pos = { x = 6 },
	nominal = 0,
	next = { 'Ace' },
	loc_txt = loc.zero,
	suit_map = {
		Hearts = 0,
		Clubs = 0,
		Diamonds = 0,
		Spades = 0,
	},
	max_id = {
		value = 0,
	},
	straight_edge = true,
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards',
	inject = function(self)
		for _, suit in pairs(SMODS.Suits) do
			inject_p_card_suit_compat(suit, self)
		end
	end,
}) -- id: 1

-- These are for making straights with counterparts and normal cards
table.insert(SMODS.Ranks["Ace"].next, "showdown_2.5")
table.insert(SMODS.Ranks["4"].next, "showdown_5.5")
table.insert(SMODS.Ranks["7"].next, "showdown_8.5")
table.insert(SMODS.Ranks["10"].next, "showdown_Butler")
table.insert(SMODS.Ranks["Jack"].next, "showdown_Princess")
table.insert(SMODS.Ranks["Queen"].next, "showdown_Lord")
--

function SMODS.is_counterpart(card)
	return card.base.id < 0
end

SMODS.Consumable:take_ownership('lovers', {
	can_use = function(self, card, area, copier)
		if G.hand and G.hand.highlighted and #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted then
			for j=1, #G.hand.highlighted do
				if G.hand.highlighted[j]:get_id() == 1 then return false end
			end
			return true
		end
		return false
	end,
})

local suit_tarot = {'star', 'moon', 'sun', 'world'}

for i=1, #suit_tarot do
	SMODS.Consumable:take_ownership(suit_tarot[i], {
		can_use = function(self, card, area, copier)
			if G.hand and G.hand.highlighted and #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.max_highlighted then
				for j=1, #G.hand.highlighted do
					if G.hand.highlighted[j]:get_id() == 1 then return false end
				end
				return true
			end
			return false
		end,
	})
end

---- Consumables

-- Tarot

SMODS.Atlas({key = "showdown_tarots", path = "Consumables/Tarots.png", px = 71, py = 95})

local counterparts = {
	["showdown_2.5"] = "2", ["2"] = "showdown_2.5",
	["showdown_5.5"] = "5", ["5"] = "showdown_5.5",
	["showdown_8.5"] = "8", ["8"] = "showdown_8.5",
	["showdown_Butler"] = "Jack", ["Jack"] = "showdown_Butler",
	["showdown_Princess"] = "Queen", ["Queen"] = "showdown_Princess",
	["showdown_Lord"] = "King", ["King"] = "showdown_Lord",
}

SMODS.Consumable({ -- The Reflection
	key = 'reflection',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	loc_txt = loc.reflection,
	config = {max_highlighted = 2},
	loc_vars = function(self, info_queue)
		info_queue[#info_queue+1] = { key = 'counterpart_ranks', set = 'Other' }
		return {vars = {self.config.max_highlighted}}
	end,
    pos = coordinate(1),
	can_use = function(self)
		if G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1 then
            for i=1, #G.hand.highlighted do
				if not counterparts[G.hand.highlighted[i].base.value] then return false end
			end
			return true
        end
        return false
    end,
    use = function()
		for i=1, #G.hand.highlighted do flipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
        delay(0.2)
		for i=1, #G.hand.highlighted do
            event({trigger = 'after', delay = 0.1, func = function()
				assert(SMODS.change_base(G.hand.highlighted[i], nil, counterparts[G.hand.highlighted[i].base.value]))
            return true end })
        end
		for i=1, #G.hand.highlighted do unflipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
})

SMODS.Consumable({ -- The Vessel
	key = 'vessel',
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
		flipCard(G.hand.highlighted[1], nil, #G.hand.highlighted)
        delay(0.2)
		event({trigger = 'after', delay = 0.1, func = function()
			assert(SMODS.change_base(G.hand.highlighted[1], nil, "showdown_Zero"))
		return true end })
		if pseudorandom("showdown_Probability") < G.GAME.probabilities.normal / 2 then
			local cen_pool = getEnhancements({"m_wild"})
			event({trigger = 'after', delay = 0.1, func = function()
				G.hand.highlighted[1]:set_ability(pseudorandom_element(cen_pool, pseudoseed('spe_card')), true);
			return true end })
		else
			event({trigger = 'after', delay = 0.1, func = function()
				G.hand.highlighted[1]:set_seal(SMODS.poll_seal({guaranteed = true}))
			return true end })
		end
		unflipCard(G.hand.highlighted[1], nil, #G.hand.highlighted)
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
})

SMODS.Consumable({ -- The Genie
	key = 'genie',
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

SMODS.Consumable({ -- The Lost
	key = 'lost',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	loc_txt = loc.lost,
	config = { max_highlighted = 2, mod_conv = "m_showdown_ghost" },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_showdown_ghost
		return {vars = {self.config.max_highlighted}}
	end,
    pos = coordinate(4),
})

SMODS.Consumable({ -- The Angel
	key = 'angel',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	loc_txt = loc.angel,
	config = { max_highlighted = 2, mod_conv = "m_showdown_holy" },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_showdown_holy
		return {vars = {self.config.max_highlighted}}
	end,
    pos = coordinate(5),
	can_use = function(self)
		return G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1
    end
})

-- Spectral

SMODS.Atlas({key = "showdown_spectrals", path = "Consumables/Spectrals.png", px = 71, py = 95})

SMODS.Consumable({ -- Mist
	key = 'mist',
	set = 'Spectral',
	atlas = 'showdown_spectrals',
	loc_txt = loc.mist,
	config = { change = 6 },
    loc_vars = function(self) return {vars = {self.config.change}} end,
    pos = coordinate(1),
	can_use = function()
		return #G.hand.cards >= 6
    end,
    use = function(self)
		local temp_hand = {}
		for k, v in ipairs(G.hand.cards) do temp_hand[#temp_hand+1] = v end
		table.sort(temp_hand, function (a, b) return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card end)
		pseudoshuffle(temp_hand, pseudoseed('immolate'))
		for i=1, self.config.change do flipCard(temp_hand[i], i, self.config.change) end
		for i=1, self.config.change do
			local rank = "Ace"
			if pseudorandom("showdown_Probability") < G.GAME.probabilities.normal / 2 then
				rank = "showdown_Zero"
			end
			event({trigger = 'after', delay = 0.1, func = function()
				assert(SMODS.change_base(temp_hand[i], nil, rank))
			return true end })
		end
		for i=1, self.config.change do unflipCard(temp_hand[i], i, self.config.change) end
    end
})

SMODS.Consumable({ -- Vision
	key = 'vision',
	set = 'Spectral',
	atlas = 'showdown_spectrals',
	loc_txt = loc.vision,
    pos = coordinate(2),
	can_use = function()
		return #G.hand.cards and #G.hand.cards >= 1
    end,
    use = function(self)
		for _, v in ipairs(SMODS.Rank.obj_buffer) do
			print(v)
			--local r = SMODS.Ranks[v]
			--if r.face then table.insert(faces, r) end
		end
		local temp_hand = {}
		for k, v in ipairs(G.hand.cards) do temp_hand[#temp_hand+1] = v end
		for i=1, #G.hand.cards do flipCard(temp_hand[i], i, #G.hand.cards) end--[[
		for i=1, #G.hand.cards do
			local inte, fract = 0, 0
			local rank = SMODS.Ranks[temp_hand[i].base.nominal]
			while fract == 0 do
				rank = SMODS.Ranks[findInTable(e, SMODS.Ranks) + 1]
				nominal = rank.nominal
				inte, fract = math.modf(nominal)
			end
			event({trigger = 'after', delay = 0.1, func = function()
				assert(SMODS.change_base(temp_hand[i], nil, rank))
			return true end })
		end]]--
		delay(0.2)
		for i=1, #G.hand.cards do unflipCard(temp_hand[i], i, #G.hand.cards) end
    end
})

-- Mathematic (gives bonuses by sacrificing cards)

SMODS.Atlas({key = 'showdown_mathematic_undiscovered', path = 'Consumables/MathematicsUndiscovered.png', px = 71, py = 95})
SMODS.Atlas({key = 'showdown_mathematic', path = 'Consumables/Mathematics.png', px = 71, py = 95})

SMODS.ConsumableType{
    key = 'Mathematic',
    primary_colour = G.C.SHOWDOWN_CALCULUS,
    secondary_colour = G.C.SHOWDOWN_CALCULUS_DARK,
    loc_txt = loc.mathematic,
    collection_rows = {4, 4}
}

SMODS.UndiscoveredSprite{
    key = 'Mathematic',
    atlas = 'showdown_mathematic_undiscovered',
    pos = coordinate(1)
}

SMODS.Consumable({ -- Constant
	key = 'constant',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.constant,
    pos = coordinate(1),
	config = {max_highlighted = 1},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        return G.hand and #G.hand.highlighted == self.config.max_highlighted and #G.hand.cards >= 2
    end,
    use = function()
		local card = G.hand.highlighted[1]
		local rank = card:get_id()
		local toEnhance = {}
		for i=1, #G.hand.cards do
			local _card = G.hand.cards[i]
			if
				_card ~= card
				and _card:get_id() == rank
				--and _card.ability.effect == "Base"
			then
				toEnhance[#toEnhance+1] = _card
			end
		end
		event({trigger = 'after', delay = 0.1, func = function() card:start_dissolve() return true end })
        delay(0.2)
		for i=1, #toEnhance do flipCard(toEnhance[i], i, #toEnhance) end
        delay(0.2)
		local cen_pool = getEnhancements(rank == 1 and {"m_wild"} or {})
		for i=1, #toEnhance do
            event({trigger = 'after', delay = 0.1, func = function()
				toEnhance[i]:set_ability(pseudorandom_element(cen_pool, pseudoseed('spe_card')), true)
            return true end })
        end
		for i=1, #toEnhance do unflipCard(toEnhance[i], i, #toEnhance) end
    end
})

SMODS.Consumable({ -- Variable
	key = 'variable',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.variable,
    pos = coordinate(2),
	config = {max_highlighted = 5},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        return #G.jokers.cards < G.jokers.config.card_limit and #G.hand.highlighted >= 1 and #G.hand.highlighted <= self.config.max_highlighted
    end,
    use = function()
		print("Variable card is used")
        -- idk
    end
})

SMODS.Consumable({ -- Function
	key = 'function',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.functio, -- no n because it fucks with lua
    pos = coordinate(3),
	config = {max_highlighted = 4, toDestroy = 1},
    loc_vars = function(self) return {vars = {self.config.max_highlighted, self.config.toDestroy}} end,
	can_use = function(self)
        return G.hand and #G.hand.highlighted == self.config.max_highlighted
    end,
    use = function(self)
		for i=1, #G.hand.highlighted do flipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
		local cen_pool = getEnhancements()
		local cen_pool_zero = getEnhancements({"m_wild"})
		for i=1, #G.hand.highlighted do
			local _card = G.hand.highlighted[i]
            event({trigger = 'after', delay = 0.1, func = function()
				_card:set_ability(pseudorandom_element(_card:get_id() == 1 and cen_pool_zero or cen_pool, pseudoseed('spe_card')), true);
            return true end })
        end
        delay(0.2)
		for i=self.config.toDestroy, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function()
				local card = pseudorandom_element(G.hand.highlighted, pseudoseed('seed')); card:start_dissolve();
				table.remove(G.hand.highlighted, findInTable(card, G.hand.highlighted))
            return true end })
        end
		for i=1, #G.hand.highlighted do unflipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
})

SMODS.Consumable({ -- Shape
	key = 'shape',
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
	key = 'vector',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.vector,
    pos = coordinate(5),
	config = {max_highlighted = 5},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
	can_use = function(self)
        if G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1 then
            return true
        end
        return false
    end,
    use = function()
		print("Vector card is used")
		for i=1, #G.hand.highlighted do
			print(G.hand.highlighted[i].base.value..": "..G.hand.highlighted[i].base.id.." | "..G.hand.highlighted[i]:get_id())
		end
		print(tprint(G.hand.highlighted[1].ability))
        -- idk
    end
})

SMODS.Consumable({ -- Probability
	key = 'probability',
	set = 'Mathematic',
	atlas = 'showdown_mathematic',
	loc_txt = loc.probability,
    pos = coordinate(6),
	config = {max_highlighted = 3, mult_joker = 1.25, extra = { odds = 3 }},
    loc_vars = function(self) return {vars = {self.config.max_highlighted, self.config.mult_joker}} end,
	can_use = function(self)
        if G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1 and #G.jokers.cards >= 1 then
            return true
        end
        return false
    end,
    use = function(self, card, area, copier)
		local first_dissolved = true
		local joker = G.jokers.cards[1]
		for i=#G.hand.highlighted, 1, -1 do
            event({trigger = 'after', delay = 0.1, func = function()
				if G.hand.highlighted ~= nil and (pseudorandom("showdown_probability") < G.GAME.probabilities.normal / card.ability.extra.odds) then
                	G.hand.highlighted[i]:start_dissolve(nil, first_dissolved)
					first_dissolved = false
					for k, v in pairs(joker.ability) do
						if
							(type(v) == "number" or type(v) == "table")
							and not (k == "id")
							and not (k == "colour")
							and not (k == "suit_nominal")
							and not (k == "base_nominal")
							and not (k == "face_nominal")
							and not (k == "qty")
							and not ((k == "x_mult" or k == "Xmult") and v == 1 and not joker.ability.override_x_mult_check)
							and not (k == "selected_d6_face")
						then
							if type(v) == "table" then
								print(tprint(v))
								for kk, vv in pairs(v) do
									if type(vv) == "number" then
										print(kk..": "..vv)
										v[kk] = vv * 1.25
									end
								end
							elseif not ((k == "x_mult" or k == "Xmult") and v == 1) then joker.ability[k] = v * 1.25 end
						end
					end
				end
            return true end })
        end
    end
})

SMODS.Consumable({ -- Sequence
	key = 'sequence',
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
	key = 'operation',
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
    use = function(self)
		local card1 = G.hand.highlighted[1]
		local card2 = G.hand.highlighted[2]
		event({trigger = 'after', delay = 0.1, func = function()
			card1:start_dissolve(nil, true); card2:start_dissolve();
		return true end })
		delay(0.2)
		event({trigger = 'after', delay = 0.7, func = function()
			local function randomValue(value1, value2)
				if not value1 then return value2
				elseif not value2 then return value1
				elseif pseudorandom("showdown_Probability") < G.GAME.probabilities.normal / 2 then
					return value1
				else
					return value2
				end
			end
			local cardValues1 = {
				ability = card1.ability,
				edition = card1.edition,
				seal = card1:get_seal()
			}
			local cardValues2 = {
				ability = card2.ability,
				edition = card2.edition, -- Done
				seal = card2:get_seal() -- Done
			}
			local _rank = pseudorandom_element({'0', '2', '2.5', '3', '4', '5', '5.5', '6', '7', '8', '8.5', '9', 'T', 'J', 'B', 'Q', 'P', 'K', 'L', 'A'}, pseudoseed('showdown_Probability'))
			local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('showdown_Probability'))
			local center = G.P_CENTERS.c_base
			---- This is horrendous
			local enhancements = {}
			for k, v in pairs(G.P_CENTERS) do if v.set == "Enhanced" then enhancements[v.name] = k end end
			enhancements["Default Base"] = "c_base"
			if enhancements[cardValues1.ability.name] == "Default Base" then center = G.P_CENTERS[enhancements[cardValues2.ability.name]]
			elseif enhancements[cardValues2.ability.name] == "Default Base" then center = G.P_CENTERS[enhancements[cardValues1.ability.name]]
			elseif pseudorandom("showdown_Probability") < G.GAME.probabilities.normal / 2 then
				center = G.P_CENTERS[enhancements[cardValues2.ability.name]]
			else
				center = G.P_CENTERS[enhancements[cardValues1.ability.name]]
			end
			----
			local edition = randomValue(cardValues1.edition, cardValues2.edition)
			local seal = randomValue(cardValues1.seal, cardValues2.seal)
			local card = create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = center}, G.hand, true)
			if edition then card:set_edition(edition) end
			if seal then card:set_seal(seal) end
			card:start_materialize()
			playing_card_joker_effects(card)
		return true end })
    end
})

---- Vouchers

SMODS.Atlas({key = 'showdown_vouchers', path = 'Consumables/Vouchers.png', px = 71, py = 95})

SMODS.Voucher({ -- Irrational Numbers
	key = 'irrational',
	atlas = 'showdown_vouchers',
	loc_txt = loc.irrational,
    unlocked = false,
	pos = coordinate(1),
	check_for_unlock = function()
        -- if 20 counterpart cards in deck
    end,
})

SMODS.Voucher({ -- Transcendant Numbers
	key = 'transcendant',
	atlas = 'showdown_vouchers',
	loc_txt = loc.transcendant,
    unlocked = false,
    requires = {'showdown_irrational'},
	pos = coordinate(3, 2),
	check_for_unlock = function()
        -- if 10 counterpart cards in deck with one or more modifiers
    end,
})

SMODS.Voucher({ -- Number Theory
	key = 'number',
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
	key = 'axiom',
	atlas = 'showdown_vouchers',
	loc_txt = loc.axiomInfinity,
    unlocked = true,
    requires = {'showdown_number'},
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
		
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_CALCULUS)
            ease_background_colour{new_colour = G.C.SHOWDOWN_CALCULUS, special_colour = G.C.BLACK, contrast = 2}
        end,
		
        pos = coordinate(i),
        atlas = 'showdown_booster_packs_mathematic',

        in_pool = function() return (pseudorandom('calculus'..G.SEED) < 0.5) end
    }
end

---- Enhancements

SMODS.Atlas({key = 'showdown_enhancements', path = 'Enhancements.png', px = 71, py = 95})

SMODS.Enhancement({
	key = 'ghost',
	atlas = 'showdown_enhancements',
	loc_txt = loc.ghost,
	pos = coordinate(1),
	--replace_base_card = true,
	config = {extra = {x_mult = 1.25, x_chips = 1.25, shatter_chance = 8}},
    loc_vars = function(self, info_queue, card)
		if card then
			return {vars = {card.ability.extra.x_mult, card.ability.extra.x_chips, card.ability.extra.shatter_chance}}
		end
		return {vars = {self.config.extra.x_mult, self.config.extra.x_chips, self.config.extra.shatter_chance}}
	end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and not context.repetition then
			effect.x_mult = card.ability.extra.x_mult
			effect.x_chips = card.ability.extra.x_chips
			if
				pseudorandom("showdown_ghost") > G.GAME.probabilities.normal * (card.ability.extra.shatter_chance - 1) / card.ability.extra.shatter_chance
				and not card.ability.eternal
			then
				card.will_shatter = true
				G.E_MANAGER:add_event(Event({
					trigger = "after", func = function()
						card:shatter(); return true
					end,
				}))
			end
		end
	end
})

SMODS.Enhancement({
	key = 'holy',
	atlas = 'showdown_enhancements',
	loc_txt = loc.holy,
	pos = coordinate(2, 7),
	--replace_base_card = true,
	config = {extra = {x_mult = 1, x_mult_gain = 0.05}},
    loc_vars = function(self, info_queue, card)
		if card then
			return {vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_gain}}
		end
		return {vars = {self.config.extra.x_mult, self.config.extra.x_mult_gain}}
	end,
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and not context.repetition then
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
			effect.x_mult = card.ability.extra.x_mult
		end
	end
})

---- Jokers

filesystem.load(showdown.path.."jokers.lua")()

---- Mod Compatibility

if (SMODS.Mods["Bunco"] or {}).can_load then
	modCompatibility("Bunco", "compat/buncoCompat.lua")
end
if (SMODS.Mods["Cryptid"] or {}).can_load then
	modCompatibility("Cryptid", "compat/cryptidCompat.lua")
end