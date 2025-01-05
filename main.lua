showdown = SMODS.current_mod
filesystem = NFS or love.filesystem
itemsPath = showdown.path.."items/"

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

---Flip a given card
---@param card table
---@param index number|nil
---@param setSize number 
function flipCard(card, index, setSize)
	if not card then printWarnMessage("No card can be flipped", "Showdown") return end
	if not setSize then printWarnMessage("No set given", "Showdown") return end
	if not index then index = 1 end
	local percent = 1.15 - (index-0.999)/(setSize-0.998)*0.3
	event({trigger = 'after', delay = 0.15, func = function()
		card:flip(); play_sound('card1', percent); card:juice_up(0.3, 0.3);
	return true end })
end

---Unflip a given card
---@param card table
---@param index number|nil
---@param setSize number
function unflipCard(card, index, setSize)
	if not card then printWarnMessage("No card can be unflipped", "Showdown") return end
	if not setSize then printWarnMessage("No set given", "Showdown") return end
	if not index then index = 1 end
	local percent = 0.85 - (index-0.999)/(setSize-0.998)*0.3
	event({trigger = 'after', delay = 0.15, func = function()
		card:flip(); play_sound('tarot2', percent, 0.6); card:juice_up(0.3, 0.3);
	return true end })
end

---Creates a joker given the passed arguments
---@param joker table
function create_joker(joker) -- (Thanks Bunco)
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
		if not joker.cost then joker.cost = 4 end
    elseif joker.rarity == 'Uncommon' then
        joker.rarity = 2
		if not joker.cost then joker.cost = 6 end
    elseif joker.rarity == 'Rare' then
        joker.rarity = 3
		if not joker.cost then joker.cost = 8 end
    elseif joker.rarity == 'Legendary' then
        joker.rarity = 4
		if not joker.cost then joker.cost = 20 end
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
		if k then joker.config.extra[k] = v end
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
		locked_loc_vars = joker.locked_vars or function(self, info_queue, card) end,
		
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

baseSuits = {'Diamonds', 'Clubs', 'Hearts', 'Spades'}
extraSuits = {}

---Returns all vanilla and modded suits. Args can be passed to have more control over the suits:
---- noModded: Exclude Modded suits
---- noVanilla: Exclude Vanilla suits
---- exotic: Include Halberds and Fleurons (Bunco)
---@param args table|nil
---@return table
function get_all_suits(args)
	if not args then args = { exotic = true } end
	local suits = {}
	for i=1, #SMODS.Suit.obj_buffer do
		local suit = SMODS.Suit.obj_table[SMODS.Suit.obj_buffer[i]]
		if (not args.noVanilla and findInTable(suit.key, baseSuits)) or
			(not args.noModded and
				((suit.key == "bunc_Fleurons"
					or suit.key == "bunc_Halberds"
				) and args.exotic)
			)
		then
			table.insert(suits, suit.key)
		end
	end
	return suits
end

local baseRanks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'}

---Returns all vanilla and modded ranks. Args can be passed to have more control over the ranks:
---- blacklist: 		Manually excluded ranks
---- whitelist: 		Manually included ranks
---- noModded: 			Exclude Modded ranks
---- noVanilla: 		Exclude Vanilla ranks
---- noFace:			Exclude face cards (incompatible with onlyFace)
---- onlyFace: 			Exclude all cards that aren't faces (incompatible with noFace)
---- noCounterpart: 	Exclude 2.5, 5.5, 8.5, Butler, Princess and Lord (Showdown, incompatible with onlyCounterpart)
---- onlyCounterpart: 	Exclude all cards that aren't counterparts (Showdown, incompatible with noCounterpart)
---- noZero: 			Exclude 0 (Showdown)
---@param args table|nil
---@return table
function get_all_ranks(args)
	if not args then args = {} end
	local ranks = {}
	local counterparts = {"showdown_2.5", "showdown_5.5", "showdown_8.5", "showdown_Butler", "showdown_Princess", "showdown_Lord", }
	for i=1, #SMODS.Rank.obj_buffer do
		local rank = SMODS.Rank.obj_table[SMODS.Rank.obj_buffer[i]]
		if not args.blacklist or (args.blacklist and not findInTable(rank.key, args.blacklist)) then
			if not args.noVanilla then -- Vanilla
				if
					findInTable(rank.key, baseRanks)
					and ((args.noFace and not rank.face) or (args.onlyFace and rank.face) or (not args.noFace and not args.onlyFace))
					and not args.onlyCounterpart
				then
					table.insert(ranks, rank.key)
				end
			end
			if not args.noModded then -- Modded
				if
					not findInTable(rank.key, baseRanks)
					and ((not findInTable(rank.key, counterparts) and not args.noCounterpart) or (findInTable(rank.key, counterparts) and args.onlyCounterpart) or (not args.noCounterpart and not args.onlyCounterpart))
					and ((args.noFace and not rank.face) or (args.onlyFace and rank.face) or (not args.noFace and not args.onlyFace))
				then
					table.insert(ranks, rank.key)
				end
			end
		end
	end
	if args.whitelist then
		for i=1, #args.whitelist do
			if not findInTable(args.whitelist[i], ranks) then
				table.insert(ranks, args.whitelist[i])
			end
		end
	end
	return ranks
end

---Returns the card table associated with given rank and suit, return nil if rank or suit is unknown
---@param rank string
---@param suit string
---@return table|nil
function get_card_from_rank_suit(rank, suit)
	if not rank or not suit then return end
	for _, v in pairs(G.P_CARDS) do
		if v.value == rank and v.suit == suit then return v end
	end
	print(rank.." of "..suit.." does not exist")
end

function get_counterpart(rank, onlyCounterpart)
	local counterparts
	if onlyCounterpart then
		counterparts = {
			["showdown_2.5"] = "2",
			["showdown_5.5"] = "5",
			["showdown_8.5"] = "8",
			["showdown_Butler"] = "Jack",
			["showdown_Princess"] = "Queen",
			["showdown_Lord"] = "King",
		}
	else
		counterparts = {
			["showdown_2.5"] = "2", ["2"] = "showdown_2.5",
			["showdown_5.5"] = "5", ["5"] = "showdown_5.5",
			["showdown_8.5"] = "8", ["8"] = "showdown_8.5",
			["showdown_Butler"] = "Jack", ["Jack"] = "showdown_Butler",
			["showdown_Princess"] = "Queen", ["Queen"] = "showdown_Princess",
			["showdown_Lord"] = "King", ["King"] = "showdown_Lord",
		}
	end
	return counterparts[rank]
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
	loc_txt = {
        ['en-us'] = 'Jean-Paul'
    },
	posStyle = 'collab'
})

---- Decks

SMODS.Atlas({key = "showdown_decks", path = "Decks.png", px = 71, py = 95})

SMODS.Back{ -- Mirror Deck
	name = "Mirror Deck",
	key = "Mirror",
	atlas = "showdown_decks",
	pos = coordinate(1),
	config = {counterpart_replacing = true},
	loc_vars = function(self)
		return {vars = {self.config.counterpart_replacing, localize{type = 'name_text', set = 'Other', key = 'counterpart_ranks'}}}
	end
}

SMODS.Back{ -- Calculus Deck
	name = "Calculus Deck",
	key = "Calculus",
	--atlas = "showdown_decks",
	atlas = "showdown_placeholders",
	--pos = coordinate(2),
	pos = coordinate(15, 5),
	config = { vouchers = { "v_showdown_number" }, consumables = {'c_showdown_genie'}, showdown_calculus = true }
}

local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(self)
	Backapply_to_runRef(self)
	if self.effect.config.showdown_calculus then G.GAME.first_booster_calculus = true end
end

---- Counterpart Cards

SMODS.Atlas({key = "showdown_cards", path = "Ranks/Cards.png", px = 71, py = 95})
SMODS.Atlas({key = "showdown_cardsHC", path = "Ranks/CardsHC.png", px = 71, py = 95})
SMODS.Atlas({key = "showdown_unknownSuit", path = "Ranks/Unknown.png", px = 71, py = 95})

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
	hc_atlas = 'showdown_cardsHC',
	lc_atlas = 'showdown_cards',
	loc_vars = function (self, info_queue, center)
		--info_queue[#info_queue+1] = {set = 'Other', key = 'counterpart_ranks'}
	end,
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
	return (next(find_joker("hiding_details")) and not find_joker("hiding_details").debuff) or card.base.id < 0
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

SMODS.Consumable({ -- The Reflection
	key = 'reflection',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	config = {max_highlighted = 2},
	loc_vars = function(self, info_queue)
		info_queue[#info_queue+1] = { key = 'counterpart_ranks', set = 'Other' }
		return {vars = {self.config.max_highlighted}}
	end,
    pos = coordinate(1),
	can_use = function(self)
		if G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1 then
            for i=1, #G.hand.highlighted do
				if not get_counterpart(G.hand.highlighted[i].base.value) then return false end
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
				assert(SMODS.change_base(G.hand.highlighted[i], nil, get_counterpart(G.hand.highlighted[i].base.value)))
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
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'counterpart_ranks'}
	end,
    pos = coordinate(2),
	can_use = function()
		return #G.hand.cards and #G.hand.cards >= 1
    end,
    use = function(self)
		for i=1, #G.hand.cards do flipCard(G.hand.cards[i], i, #G.hand.cards) end
		for i=1, #G.hand.cards do
			event({trigger = 'after', delay = 0.1, func = function()
				local _card = G.hand.cards[i]
				local changed = false
				while not changed do
					local rawRank = _card.base.value
					if get_counterpart(rawRank) then
						assert(SMODS.change_base(_card, nil, get_counterpart(rawRank)))
						local upgrades = {}
						if _card.config.center.name ~= "Default Base" then table.insert(upgrades, "enhancement") end
						if _card.edition then table.insert(upgrades, "edition") end
						if _card.seal then table.insert(upgrades, "seal") end
						if next(upgrades) then
							local toRemove = upgrades[math.random(#upgrades)]
							if toRemove == "enhancement" then
								_card:set_ability(G.P_CENTERS["c_base"])
							elseif toRemove == "edition" then
								_card.edition = nil
							elseif toRemove == "seal" then
								_card.seal = nil
							end
						end
						changed = true
					else
						local rank = SMODS.Rank.obj_table[rawRank]
						assert(SMODS.change_base(_card, nil, rank.next[1]))
					end
				end
			return true end })
		end
		delay(0.2)
		for i=1, #G.hand.cards do unflipCard(G.hand.cards[i], i, #G.hand.cards) end
    end
})

-- Mathematic (gives bonuses by sacrificing cards)

filesystem.load(itemsPath.."MathematicCards.lua")()

---- Vouchers

SMODS.Atlas({key = 'showdown_vouchers', path = 'Consumables/Vouchers.png', px = 71, py = 95})

SMODS.Voucher({ -- Irrational Numbers
	key = 'irrational',
	atlas = 'showdown_vouchers',
    unlocked = true,
	pos = coordinate(1),
	check_for_unlock = function()
        --
    end,
})

SMODS.Voucher({ -- Transcendant Numbers
	key = 'transcendant',
	atlas = 'showdown_vouchers',
    unlocked = false,
    requires = {'v_showdown_irrational'},
	pos = coordinate(3, 2),
	check_for_unlock = function()
        --
    end,
})

SMODS.Voucher({ -- Number Theory
	key = 'number',
	atlas = 'showdown_vouchers',
    unlocked = true,
	pos = coordinate(2),
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.mathematic_rate = (G.GAME.mathematic_rate or 0) + 4
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.mathematic_rate = math.max(0, G.GAME.mathematic_rate - 4)
				return true
			end,
		}))
	end,
})

SMODS.Voucher({ -- Axiom of Infinity
	key = 'axiom',
	atlas = 'showdown_vouchers',
    unlocked = false,
    requires = {'v_showdown_number'},
	pos = coordinate(4, 2),
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.draw_hand_math = true
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.draw_hand_math = false
				return true
			end,
		}))
	end,
})

---- Enhancements

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

SMODS.Atlas({key = 'showdown_enhancements', path = 'Enhancements.png', px = 71, py = 95})

SMODS.Enhancement({
	key = 'ghost',
	atlas = 'showdown_enhancements',
	pos = coordinate(1, 7),
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
		end
	end
})

SMODS.Enhancement({
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
	calculate = function(self, card, context, effect)
		if context.cardarea == G.play and not context.repetition then
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
			effect.x_mult = card.ability.extra.x_mult
		end
	end
})

---- Jokers

filesystem.load(itemsPath.."JokerJeanPaul.lua")()
filesystem.load(itemsPath.."Jokers.lua")()

---- Mod Compatibility

if (SMODS.Mods["Bunco"] or {}).can_load then
	modCompatibility("Bunco", "compat/buncoCompat.lua")
end
if (SMODS.Mods["Cryptid"] or {}).can_load then
	modCompatibility("Cryptid", "compat/cryptidCompat.lua")
end
if (SMODS.Mods["MusicalSuit"] or {}).can_load then
	modCompatibility("MusicalSuit", "compat/musicalSuitCompat.lua")
end
if (SMODS.Mods["InkAndColor"] or {}).can_load then
	modCompatibility("InkAndColor", "compat/inkAndColorCompat.lua")
end