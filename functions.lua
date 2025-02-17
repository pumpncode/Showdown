---Get card texture coordinates on the atlas
---@param position integer
---@param width integer|nil
---@return table
function coordinate(position, width)
    if width == nil then width = 10 end
    return {x = (position-1) % width, y = math.floor((position-1) / width)}
end

function modCompatibility(modName, filePath)
	sendInfoMessage("Mod Compatibility: "..modName.." is loaded!", "Showdown")
	filesystem.load(SMODS.current_mod.path..filePath)()
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
	for k, v in pairs(G.P_CENTER_POOLS.Enhanced) do
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
	if joker.config and not joker.config.extra then joker.config.extra = {} end
    joker.config = joker.config or {extra = {}}
    for _, kv_pair in ipairs(joker.vars) do
        -- kv_pair is {a = 1}
        local k, v = next(kv_pair)
		if k then joker.config.extra[k] = v end
    end

    -- Joker creation
    SMODS.Joker{
        name = joker.name,
        key = key,

        atlas = joker.atlas,
        pos = joker.pos,
        soul_pos = joker.soul,

		display_size = joker.display_size,
		pixel_size = joker.pixel_size,

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
        remove_from_deck = joker.remove_from_deck,
        add_to_deck = joker.add_to_deck,
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
--[[
if not (SMODS.Mods["Paperback"] or {}).can_load then
	local start_dissolve_ref = Card.start_dissolve
	function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice) -- Thanks Paperback
		if self.getting_sliced then
			for i = 1, #G.jokers.cards do
				G.jokers.cards[i]:calculate_joker({ removing_card = true, removed_card = self, area = self.area })
			end
		end

		start_dissolve_ref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
	end
end
]]--
baseSuits = {'Diamonds', 'Clubs', 'Hearts', 'Spades'}

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
				((suit.key == "bunc_Fleurons" or suit.key == "bunc_Halberds") and args.exotic)
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

function get_lowest_rank(hand)
	local lowestRank = 11
	for i=1, #hand do
		if hand[i].base.nominal < lowestRank then
			lowestRank = hand[i].base.nominal
		end
	end
	return lowestRank
end

local Cardchange_suitRef = Card.change_suit
function Card:change_suit(new_suit)
	if SMODS.is_zero(self) then G.GAME.blind:debuff_card(self)
	else Cardchange_suitRef(self, new_suit) end
end

function create_card_in_deck(rank, suit)
	local created_card, card = get_card_from_rank_suit(rank, suit), nil
	if created_card then
		G.E_MANAGER:add_event(Event({
			func = function()
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, created_card, G.P_CENTERS.c_base, {playing_card = G.playing_card})
				card:start_materialize({G.C.SECONDARY_SET.Enhanced})
				G.play:emplace(card)
				table.insert(G.playing_cards, card)
				return true
		end}))
		delay(0.6)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				return true
		end}))
		draw_card(G.play,G.deck, 90,'up', nil, card)
		playing_card_joker_effects({true})
		delay(0.2)
	end
	return card
end

function create_cards_in_deck(rank_list, suit_list, nb)
	local cards = {}
	for _=1, nb do
		local rank, suit = pseudorandom_element(rank_list, pseudoseed('create_card')), pseudorandom_element(suit_list, pseudoseed('create_card'))
		local created_card, card = get_card_from_rank_suit(rank, suit), nil
		if created_card then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.playing_card = (G.playing_card and G.playing_card + 1) or 1
					card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, created_card, G.P_CENTERS.c_base, {playing_card = G.playing_card})
					card:start_materialize({G.C.SECONDARY_SET.Enhanced})
					G.play:emplace(card)
					table.insert(G.playing_cards, card)
					cards[#cards+1] = card
					return true
			end}))
		end
		delay(0.2)
	end
	G.E_MANAGER:add_event(Event({
		func = function()
			G.deck.config.card_limit = G.deck.config.card_limit + nb
			return true
	end}))
	G.E_MANAGER:add_event(Event({
		func = function()
			for i=1, #cards do
				draw_card(G.play, G.deck, i*100/#cards,'up', nil ,cards[i])
			end
			return true
	end}))
	playing_card_joker_effects(cards)
	delay(0.2)
end

function prequire(m)
	local ok, err = pcall(require, m)
	if not ok then return nil, err end
	return err
end