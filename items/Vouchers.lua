SMODS.Atlas({key = 'showdown_vouchers', path = 'Consumables/Vouchers.png', px = 71, py = 95})

SMODS.Voucher({ -- Number Theory
	key = 'number',
	atlas = 'showdown_vouchers',
    unlocked = true,
	pos = coordinate(2),
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.mathematic_rate = (G.GAME.mathematic_rate or 0) + 4
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.mathematic_rate = math.max(0, G.GAME.mathematic_rate - 4)
				return true
			end,
		}))
	end,
})

SMODS.Voucher({ -- Axiom of Infinity
	key = 'axiom',
	atlas = 'showdown_vouchers',
    --unlocked = false,
    unlocked = true,
    requires = {'v_showdown_number'},
	pos = coordinate(4, 2),
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.draw_hand_math = true
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.draw_hand_math = false
				return true
			end,
		}))
	end,
})

SMODS.Voucher({ -- L U I
	key = 'lui',
	atlas = 'showdown_vouchers',
    unlocked = true,
	pos = coordinate(1),
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_cloud'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_mushroom'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_flower'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_luigi'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_mario'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_star'}
	end,
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.casino_rate = (G.GAME.casino_rate or 0) + 0.25
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.casino_rate = math.max(0, G.GAME.casino_rate - 0.25)
				return true
			end,
		}))
	end,
})

SMODS.Voucher({ -- G I
	key = 'gi',
	atlas = 'showdown_vouchers',
    --unlocked = false,
    unlocked = true,
    requires = {'v_showdown_lui'},
	pos = coordinate(3, 2),
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_cloud'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_mushroom'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_flower'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_luigi'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_mario'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_star'}
	end,
	check_for_unlock = function()
        --
    end,
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.casino_rate = (G.GAME.casino_rate or 0) + 0.75
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.casino_rate = math.max(0, G.GAME.casino_rate - 0.75)
				return true
			end,
		}))
	end,
})