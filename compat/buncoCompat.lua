local showdown = SMODS.current_mod
local filesystem = NFS or love.filesystem
local loc = filesystem.load(showdown.path..'localization.lua')()

---- Functions

local function get_coordinates(position, width)
    if width == nil then width = 10 end
    return {x = (position) % width, y = math.floor((position) / width)}
end

local function coordinate(position, width)
    return get_coordinates(position - 1, width)
end

local function enable_exotics()
    if G.GAME then G.GAME.Exotic = true end
	sendDebugMessage('[BUNCO] - Triggered Exotic System enabling.')
end

---- Exotic Cards

SMODS.Atlas({key = "showdown_exoticCards", path = "CrossMod/Bunco/Ranks/Cards.png", px = 71, py = 95})

SMODS.Atlas({key = "showdown_exoticCardsHC", path = "CrossMod/Bunco/Ranks/CardsHC.png", px = 71, py = 95})

---- Consumables

-- Tarot

SMODS.Atlas({key = "showdown_buncoTarots", path = "CrossMod/Bunco/Consumables/Tarots.png", px = 71, py = 95})

SMODS.Consumable({ -- The Beast
	key = 'Beast',
	set = 'Tarot',
	atlas = 'showdown_buncoTarots',
	loc_txt = loc.beast,
	config = {max_highlighted = 2},
    loc_vars = function(self) return {vars = {self.config.max_highlighted}} end,
    pos = coordinate(1),
	can_use = function()
		if G.hand and #G.hand.highlighted <= 2 then
            return true
        end
        return false
    end,
    use = function()
		enable_exotics()
		print("The Beast card is used")
        -- convert selected cards into random exotic counterparts
    end
})