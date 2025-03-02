local bugged = {
    type = 'Challenge',
    order = 1,
    key = '7LB2WVPK',
    deck = {
        type = 'Challenge Deck',
        cards = {},
    },
    rules = {
        custom = {
            { id = 'showdown_bugged_seed' },
        },
    },
}

for _=1, 52 do
    table.insert(bugged.deck.cards, { s = 'S', r = 'T' })
end

return {
	enabled = Showdown.config["Challenges"],
	list = function()
		local list = {
            bugged,
		}
		return list
	end,
}