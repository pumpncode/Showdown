local showdown = SMODS.current_mod
local filesystem = NFS or love.filesystem
local loc = filesystem.load(showdown.path..'localization.lua')()

---- Functions

local function get_coordinates(position, width)
    if width == nil then width = 10 end
    return {x = (position) % width, y = math.floor((position) / width)}
end

local function coordinate(position)
    return get_coordinates(position - 1)
end

local function coordinate(position, width)
    return get_coordinates(position - 1, width)
end

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end


---- Mod Icon

SMODS.Atlas({key = "modicon", path = "Mod_icon.png", px = 36, py = 36})

---- Decks

SMODS.Atlas({key = "decks", path = "Decks.png", px = 71, py = 95})

SMODS.Back{ -- Counterpart Deck
	name = "Counterpart Deck",
	key = "counterpart",
	atlas = "decks",
	pos = coordinate(1),
	loc_txt = loc.counterpart,
	loc_vars = function() return {vars = {}} end,
	apply = function()
		G.E_MANAGER:add_event(Event({
			func = function()
				local ranksToDelete = {"Ace", "King", "Queen", "Jack", "8", "5", "2"}
				for i = #G.playing_cards, 1, -1 do
					if has_value(ranksToDelete, G.playing_cards[i].base.value) then
						G.playing_cards[i]:remove()
					end
				end
				return true
			end
		}))
	end
}

---- Counterpart Cards

SMODS.Atlas({key = "cards", path = "Ranks/Cards.png", px = 71, py = 95})

SMODS.Atlas({key = "cardsHC", path = "Ranks/CardsHC.png", px = 71, py = 95})

SMODS.Rank({ -- 2.5 Card
	key = '2.5',
	card_key = 'W',
	shorthand = '2.5',
	pos = { x = 0 },
	nominal = 2.5,
	next = { '3' },
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.two_half, 'name')
	end,
	hc_atlas = 'cardsHC',
	lc_atlas = 'cards'
})

SMODS.Rank({ -- 5.5 Card
	key = '5.5',
	card_key = 'F',
	shorthand = '5.5',
	pos = { x = 1 },
	nominal = 5.5,
	next = { '6' },
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.five_half, 'name')
	end,
	hc_atlas = 'cardsHC',
	lc_atlas = 'cards'
})

SMODS.Rank({ -- 8.5 Card
	key = '8.5',
	card_key = 'E',
	shorthand = '8.5',
	pos = { x = 2 },
	nominal = 8.5,
	next = { '9' },
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.eight_half, 'name')
	end,
	hc_atlas = 'cardsHC',
	lc_atlas = 'cards'
})

SMODS.Rank({ -- Butler Card
	key = 'Butler',
	card_key = 'B',
	shorthand = 'B',
	pos = { x = 3 },
	nominal = 10.5,
	next = { 'Princess' },
	face = true,
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.butler, 'name')
	end,
	hc_atlas = 'cardsHC',
	lc_atlas = 'cards'
})

SMODS.Rank({ -- Princess Card
	key = 'Princess',
	card_key = 'P',
	shorthand = 'P',
	pos = { x = 4 },
	nominal = 10.5,
	next = { 'Lord' },
	face = true,
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.princess, 'name')
	end,
	hc_atlas = 'cardsHC',
	lc_atlas = 'cards'
})

SMODS.Rank({ -- Lord Card
	key = 'Lord',
	card_key = 'L',
	shorthand = 'L',
	pos = { x = 5 },
	nominal = 10.5,
	next = { 'Ace' },
	face = true,
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.lord, 'name')
	end,
	hc_atlas = 'cardsHC',
	lc_atlas = 'cards'
})

SMODS.Rank({ -- 0 Card
	key = 'Zero',
	card_key = 'Z',
	shorthand = '0',
	pos = { x = 6 },
	nominal = 0,
	next = { 'Ace' },
	process_loc_text = function(self)
		SMODS.process_loc_text(G.localization.misc.ranks, self.key, loc.zero, 'name')
	end,
	hc_atlas = 'cardsHC',
	lc_atlas = 'cards'
})

---- Consumables

-- Tarot

SMODS.Consumable({ -- The Reflection
	key = 'Reflection',
	set = 'Tarot',
	loc_txt = loc.reflection,
})

SMODS.Consumable({ -- The Vessel
	key = 'Vessel',
	set = 'Tarot',
	loc_txt = loc.vessel,
})

-- Spirit
--[[
SMODS.Consumable({ -- Mist
	key = 'Mist',
	set = 'Spirit',
	loc_txt = loc.mist,
})

SMODS.Consumable({ -- Vision
	key = 'Vision',
	set = 'Spirit',
	loc_txt = loc.vision,
})
]]--
---- Jokers

SMODS.Joker({
	key = 'Pinpoint',
	rarity = 2,
	loc_txt = loc.pinpoint,
})

if (SMODS.Mods["Bunco"] or {}).can_load then
    filesystem.load(showdown.path.."compat/buncoCompat.lua")()
end