SMODS.Atlas({key = "cardsExotic", path = "Ranks/Exotic/ExoticCards.png", px = 71, py = 95})

SMODS.Atlas({key = "cardsExoticHC", path = "Ranks/Exotic/ExoticCardsHC.png", px = 71, py = 95})

SMODS.Consumable({ -- The Beast
	key = 'Beast',
	set = 'Tarot',
	atlas = 'showdown_tarots',
	loc_txt = loc.beast,
	config = {max_highlighted = 2},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
    pos = coordinate(4),
	can_use = function()
		-- if up to 2 cards are selected
        return true
    end,
    use = function()
		print("The Beast card is used")
        -- convert selected cards into random exotic counterparts
    end
})