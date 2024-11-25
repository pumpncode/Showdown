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

SMODS.Voucher({ -- Complex Numbers
	key = 'Complex',
	atlas = 'showdown_vouchers',
	loc_txt = loc.complex,
    unlocked = true,
    requires = {'showdown_Transcendant'},
	pos = coordinate(3, 1),
})