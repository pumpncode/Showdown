local showdown = SMODS.current_mod
local loc = filesystem.load(showdown.path..'localization.lua')()

SMODS.Atlas({
	key = "modicon",
	path = "showdown_icon.png",
	px = 36,
	py = 36,
}):register()

SMODS.Back{ -- Counterpart Deck
	name = "Counterpart Deck",
	key = "counterpart",
	pos = {x = 0, y = 3},
	loc_txt = loc.counterpart
}

if (SMODS.Mods["Bunco"] or {}).can_load then
    filesystem.load(showdown.path..'compat/buncoCompat.lua')()
end