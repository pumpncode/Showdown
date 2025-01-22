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

SMODS.Voucher({ -- Complex Numbers
	key = 'complex',
	atlas = 'showdown_cryptidVouchers',
    unlocked = true,
    requires = {'v_showdown_transcendant'},
	pos = coordinate(1),
})

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

--SMODS.Atlas({key = "showdown_cryptidJokers", path = "CrossMod/Cryptid/Jokers.png", px = 71, py = 95})

create_joker({ -- Infection
    name = 'infection',
    --atlas = "showdown_cryptidJokers",
    pos = coordinate(10, 5),
    vars = {{mult = 1}},
    custom_vars = function(self, info_queue, card)
        return { vars = { card.config.mult } }
	end,
    rarity = 'cry_cursed', --cost = 4,
    blueprint = true, perishable = false, eternal = false,
    calculate = function(self, card, context)
        --
    end,
    custom_in_pool = function()
        return false
    end,
})

-- Food

if Cryptid and Cryptid.food then
	table.insert(Cryptid.food, 'j_showdown_gruyere')
end

-- Versatile Joker

Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(23), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Equilibrium'] = { desc = 'j_showdown_versatile_joker_equilibrium', pos = coordinate(24), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Misprint'] = { desc = 'j_showdown_versatile_joker_misprint', pos = coordinate(25), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Infinite'] = { desc = 'j_showdown_versatile_joker_infinite', pos = coordinate(26), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Conveyor'] = { desc = 'j_showdown_versatile_joker_conveyor', pos = coordinate(27), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-CCD'] = { desc = 'j_showdown_versatile_joker_ccd', pos = coordinate(28), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Wormhole'] = { desc = 'j_showdown_versatile_joker_wormhole', pos = coordinate(29), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Redeemed'] = { desc = 'j_showdown_versatile_joker_redeemed', pos = coordinate(30), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Legendary'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(30), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Critical'] = { desc = 'j_showdown_versatile_joker_critical', pos = coordinate(31), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Glowing'] = { desc = 'j_showdown_versatile_joker_glowing', pos = coordinate(32), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Beta'] = { desc = 'j_showdown_versatile_joker_beta', pos = coordinate(33), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['cry-Bountiful'] = { desc = 'j_showdown_versatile_joker_bountiful', pos = coordinate(34), blueprint = false, effect = function(self, card, context)
    --
end }

--

--[[ Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(35), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(36), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(37), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(38), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(39), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(40), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(41), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(42), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(43), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(44), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(45), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(46), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(47), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(48), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(49), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(50), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(51), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(52), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(53), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(54), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(55), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(56), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(57), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(58), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(59), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(60), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(61), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(62), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(63), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(64), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(65), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(66), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(67), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(68), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(69), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(70), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(71), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(72), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(73), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Legendary Deck'] = { desc = 'j_showdown_versatile_joker_legendary', pos = coordinate(74), blueprint = false, effect = function(self, card, context)
    --
end }
Showdown.versatile['Very Fair Deck'] = { desc = 'j_showdown_versatile_joker_very_fair', pos = coordinate(75), blueprint = false, effect = function(self, card, context)
    --
end } ]]