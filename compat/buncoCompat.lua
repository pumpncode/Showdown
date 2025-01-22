---- Functions

local function enable_exotics()
    if G.GAME then G.GAME.Exotic = true end
	sendDebugMessage('[SHOWDOWN] - Triggered Exotic System enabling.')
end

---- Exotic Suit

SMODS.Atlas({key = "showdown_exoticCards", path = "CrossMod/Bunco/Ranks/Cards.png", px = 71, py = 95})
SMODS.Atlas({key = "showdown_exoticCardsHC", path = "CrossMod/Bunco/Ranks/CardsHC.png", px = 71, py = 95})

Showdown.extraSuits['bunc_Fleurons'] = {lc_atlas = 'showdown_exoticCards', hc_atlas = 'showdown_exoticCardsHC'}
Showdown.extraSuits['bunc_Halberds'] = {lc_atlas = 'showdown_exoticCards', hc_atlas = 'showdown_exoticCardsHC'}

--[[
SMODS.DeckSkin({
	key = "test_skin",
	suit = "bunc_Fleurons",
	ranks = {
		"2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"
	},
	lc_atlas = "showdown_deck_skin",
	hc_atlas = "showdown_deck_skinhc",
	loc_txt = { ['en-us'] = "test" }
})

SMODS.DeckSkin({
	key = "test_skin",
	suit = "bunc_Halberds",
	ranks = {
		"2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"
	},
	lc_atlas = "showdown_deck_skin",
	hc_atlas = "showdown_deck_skinhc",
	loc_txt = { ['en-us'] = "test" }
})
]]--

---- Consumables

-- Tarot

SMODS.Atlas({key = "showdown_buncoTarots", path = "CrossMod/Bunco/Consumables/Tarots.png", px = 71, py = 95})

local randomCounterparts = {"showdown_2.5", "showdown_5.5", "showdown_8.5", "showdown_Butler", "showdown_Princess", "showdown_Lord"}
local randomExotics = {"bunc_Halberds", "bunc_Fleurons"}

SMODS.Consumable({ -- The Beast
	key = 'beast',
	set = 'Tarot',
	atlas = 'showdown_buncoTarots',
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize("k_showdown_mysterious_tarot"), get_type_colour(self or card.config, card), nil, 1.2)
    end,
	config = {max_highlighted = 2},
    loc_vars = function(self, info_queue)
		info_queue[#info_queue+1] = { key = 'exotic_cards', set = 'Other' }
		info_queue[#info_queue+1] = { key = 'counterpart_ranks', set = 'Other' }
        return {vars = {self.config.max_highlighted}}
    end,
    pos = coordinate(1),
	can_use = function(self)
		if G.hand and #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1 then
            return true
        end
        return false
    end,
    use = function()
		enable_exotics()
		for i=1, #G.hand.highlighted do flipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
        delay(0.2)
		for i=1, #G.hand.highlighted do
            event({trigger = 'after', delay = 0.1, func = function()
				assert(SMODS.change_base(G.hand.highlighted[i], randomExotics[math.random(#randomExotics)], randomCounterparts[math.random(#randomCounterparts)]))
            return true end })
        end
		for i=1, #G.hand.highlighted do unflipCard(G.hand.highlighted[i], i, #G.hand.highlighted) end
		event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end })
        delay(0.5)
    end
})

-- Versatile Joker

Showdown.versatile['Fairy Deck'] = { desc = 'j_showdown_versatile_joker_fairy', pos = coordinate(21), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Digital Deck'] = { desc = 'j_showdown_versatile_joker_digital', pos = coordinate(22), blueprint = false, effect = function(self, card, context)
    --
end }