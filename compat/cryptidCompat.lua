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