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
		if not Showdown.extraSuits[card.suit] then
			sendWarnMessage("Unknown suit for "..card.name, "Showdown")
			card.lc_atlas = 'showdown_unknownSuit'
			card.hc_atlas = 'showdown_unknownSuit'
			card.pos = {x = 0, y = 0}
		else
			card.lc_atlas = Showdown.extraSuits[card.suit].lc_atlas
			card.hc_atlas = Showdown.extraSuits[card.suit].hc_atlas
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
	counterpart = true,
	max_id = {
		value = -3,
	},
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
	counterpart = true,
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
	counterpart = true,
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
	counterpart = true,
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
	counterpart = true,
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
	counterpart = true,
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

local SMODShas_any_suitRef = SMODS.has_any_suit
function SMODS.has_any_suit(card)
	SMODShas_any_suitRef(card)
	if SMODS.is_zero(card) then return true end
	if next(find_joker('sim_card')) and SMODS.is_counterpart(card) then return true end
end

function SMODS.is_counterpart(card)
	return next(find_joker("hiding_details")) or card.base.id < 0
end

function SMODS.is_zero(card)
	return card.base.id == 1 or card.base.value == 'showdown_Zero'
end

if (SMODS.Mods["Bunco"] or {}).can_load then
	SMODS.Atlas({key = "showdown_exoticCards", path = "CrossMod/Bunco/Ranks/Cards.png", px = 71, py = 95})
	SMODS.Atlas({key = "showdown_exoticCardsHC", path = "CrossMod/Bunco/Ranks/CardsHC.png", px = 71, py = 95})

	Showdown.extraSuits['bunc_Fleurons'] = {lc_atlas = 'showdown_exoticCards', hc_atlas = 'showdown_exoticCardsHC'}
	Showdown.extraSuits['bunc_Halberds'] = {lc_atlas = 'showdown_exoticCards', hc_atlas = 'showdown_exoticCardsHC'}
end
if (SMODS.Mods["MusicalSuit"] or {}).can_load then
	SMODS.Atlas({key = "showdown_musicalCards", path = "CrossMod/MusicalSuit/Ranks/Cards.png", px = 71, py = 95})
	SMODS.Atlas({key = "showdown_musicalCardsHC", path = "CrossMod/MusicalSuit/Ranks/CardsHC.png", px = 71, py = 95})

	Showdown.extraSuits['Notes'] = {lc_atlas = 'showdown_musicalCards', hc_atlas = 'showdown_musicalCardsHC'}
end
if (SMODS.Mods["InkAndColor"] or {}).can_load then
	SMODS.Atlas({key = "showdown_inkColorCards", path = "CrossMod/InkAndColor/Ranks/Cards.png", px = 71, py = 95})
	SMODS.Atlas({key = "showdown_inkColorCardsHC", path = "CrossMod/InkAndColor/Ranks/CardsHC.png", px = 71, py = 95})

	Showdown.extraSuits['ink_Inks'] = {lc_atlas = 'showdown_inkColorCards', hc_atlas = 'showdown_inkColorCardsHC'}
	Showdown.extraSuits['ink_Colors'] = {lc_atlas = 'showdown_inkColorCards', hc_atlas = 'showdown_inkColorCardsHC'}
end