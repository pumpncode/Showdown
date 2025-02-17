---- Consumables

-- Unique

SMODS.Atlas({key = "showdown_cryptidUnique", path = "CrossMod/Cryptid/Unique.png", px = 71, py = 95})

SMODS.Consumable({ -- Strange Thing
	key = 'strange_thing',
	set = 'Unique',
	atlas = 'showdown_cryptidUnique',
    pos = coordinate(1),
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
--[[ 
SMODS.Voucher({ -- Complex Numbers
	key = 'complex',
	atlas = 'showdown_cryptidVouchers',
    unlocked = true,
    requires = {'v_showdown_transcendant'},
	pos = coordinate(1),
})
 ]]
SMODS.Voucher({ -- Collatz Conjecture
	key = 'collatz',
	atlas = 'showdown_cryptidVouchers',
    unlocked = true,
    requires = {'v_showdown_axiom'},
	pos = coordinate(2, 1),
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.mathematic_no_destroy_chance = true
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.mathematic_no_destroy_chance = false
				return true
			end,
		}))
	end,
})

---- Jokers

SMODS.Atlas({key = "showdown_cryptidJokers", path = "CrossMod/Cryptid/Jokers.png", px = 71, py = 95})

local infection = { -- Infection
	type = 'Joker',
    name = 'infection',
    atlas = "showdown_cryptidJokers",
    pos = coordinate(1),
    config = {extra = {mult = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.mult } }
	end,
    rarity = 'cry_cursed', --cost = 4,
    blueprint = true, perishable = false, eternal = false,
    calculate = function(self, card, context)
        --
    end,
    in_pool = function()
        return false
    end,
}

-- Food

if Cryptid and Cryptid.food then
	table.insert(Cryptid.food, 'j_showdown_gruyere')
end