local showdown = SMODS.current_mod
local filesystem = NFS or love.filesystem
local loc = filesystem.load(showdown.path..'localization.lua')()

SMODS.Atlas({key = "cardsExotic", path = "Ranks/Exotic/ExoticCards.png", px = 71, py = 95})

SMODS.Atlas({key = "cardsExoticHC", path = "Ranks/Exotic/ExoticCardsHC.png", px = 71, py = 95})