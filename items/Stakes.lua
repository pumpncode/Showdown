local ruby = {
	type = 'StakeAlt',
	order = 1,
    key = 'ruby',
	atlas = "showdown_stakes", sticker_atlas = "showdown_stake_stickers",
	pos = coordinate(2), sticker_pos = coordinate(2),
    applied_stakes = { 'white' },
    --colour = '',
    above_stake = 'white',
    modifiers = function ()
        --
    end
}

return {
	enabled = Showdown.config["Stakes"],
	list = function()
		local list = {
			ruby,
		}
		return list
	end,
	atlases = {
		{key = "showdown_stakes", path = "Stakes.png", px = 29, py = 29},
		{key = "showdown_stake_stickers", path = "StakeStickers.png", px = 71, py = 95},
	},
    exec = function ()
        Showdown.StakeAlt = SMODS.Stake:extend{
            --
        }
    end,
    class = Showdown,
}