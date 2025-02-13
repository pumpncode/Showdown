SMODS.Atlas({key = "showdown_jean_paul", path = "DeckSkins/jean_paul.png", px = 71, py = 95})
SMODS.Atlas({key = "showdown_jean_paul_hc", path = "DeckSkins/jean_paul_hc.png", px = 71, py = 95})

SMODS.DeckSkin({
	key = "JeanPaul",
	suit = "Clubs",
	loc_txt = {
		['en-us'] = 'Jean-Paul'
	},
	palettes = {
		{
			key = 'lc',
			ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace",},
			display_ranks = {"King", "Queen", "Jack"},
			atlas = 'showdown_jean_paul',
			pos_style = 'suit',
		},
		{
			key = 'hc',
			ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace",},
			display_ranks = {"King", "Queen", "Jack"},
			atlas = 'showdown_jean_paul_hc',
			pos_style = 'suit',
		},
	}
})