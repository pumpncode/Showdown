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

---- Consumables

-- Unique

--SMODS.Atlas({key = "showdown_cryptidUnique", path = "CrossMod/Cryptid/Unique.png", px = 71, py = 95})

SMODS.Consumable({ -- Strange Thing
	key = 'Strange',
	set = 'Unique',
	atlas = 'showdown_placeholders',
	loc_txt = loc.strange,
    pos = coordinate(14, 5),
	config = { extra = {multMin = nil, multMax = nil}},
	loc_vars = function(self) return {vars = {self.config.min_value, self.config.max_value}} end,
	can_use = function()
        return true
    end,
    use = function()
		print("Strange Thing is used")
        -- spawns a negative Infection
    end
})

---- Vouchers

SMODS.Atlas({key = "showdown_cryptidVouchers", path = "CrossMod/Cryptid/Vouchers.png", px = 71, py = 95})

SMODS.Voucher({ -- Complex Numbers
	key = 'Complex',
	atlas = 'showdown_cryptidVouchers',
	loc_txt = loc.complex,
    unlocked = true,
    requires = {'showdown_Transcendant'},
	pos = coordinate(1),
})

SMODS.Voucher({ -- Collatz Conjecture
	key = 'Collatz',
	atlas = 'showdown_cryptidVouchers',
	loc_txt = loc.collatz,
    unlocked = true,
    requires = {'showdown_Axiom'},
	pos = coordinate(2, 1),
})

---- Jokers

--SMODS.Atlas({key = "showdown_cryptidJokers", path = "CrossMod/Cryptid/Jokers.png", px = 71, py = 95})

SMODS.Joker({
	key = 'Infection',
	rarity = 'cry_cursed',
	atlas = 'showdown_placeholders',
	pos = coordinate(9, 5),
	loc_txt = loc.infection,
	config = {mult = 1},
	loc_vars = function(self) return {vars = {self.config.mult}} end,
    custom_in_pool = function()
        return false
    end,
})