local number_theory = {
	type = 'Voucher',
	order = 1,
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
}

local axiom_infinity = {
	type = 'Voucher',
	order = 2,
	key = 'axiom',
	atlas = 'showdown_vouchers',
    unlocked = false,
    requires = {'v_showdown_number'},
	pos = coordinate(4, 2),
	config = { calculus_packs = 6 },
	locked_loc_vars = function(self, info_queue, card)
        return { vars = { self.config.calculus_packs } }
	end,
	check_for_unlock = function(self, args)
        if args.type == 'open_booster' and args.card and args.card.ability.name:find('showdown_calculus') and (G.GAME.calculus_booster_opened or 0) < 10 then
			G.GAME.calculus_booster_opened = (G.GAME.calculus_booster_opened or 0) + 1
			print(G.GAME.calculus_booster_opened)
			if G.GAME.calculus_booster_opened == 10 then
				unlock_card(self)
			end
		end
    end,
	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.draw_hand_math = true
				return true
			end,
		}))
	end,
	unredeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.draw_hand_math = false
				return true
			end,
		}))
	end,
}

local poker_night = {
	type = 'Voucher',
	order = 3,
	key = 'poker_night',
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
}

local luigis_casino = {
	type = 'Voucher',
	order = 4,
	key = 'luigis_casino',
	atlas = 'showdown_vouchers',
    unlocked = false,
    requires = {'v_showdown_poker_night'},
	pos = coordinate(3, 2),
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_cloud'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_mushroom'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_flower'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_luigi'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_mario'}
        info_queue[#info_queue+1] = {set = 'Other', key = 'showdown_star'}
	end,
	check_for_unlock = function(self, args)
        if args.type == 'win_custom' and G.jokers then
			for _, joker in ipairs(G.jokers.cards) do
				if have_casino_sticker(joker) then
					unlock_card(self)
					break
				end
			end
		end
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
}

-- Cryptid

local collatz = {
	type = 'Voucher',
	order = 1000,
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
}

return {
	enabled = Showdown.config["Vouchers"],
	list = function()
		local list = {}
		if Showdown.config["Consumeables"]["Mathematics"] then
			table.insert(list, number_theory)
			table.insert(list, axiom_infinity)
		end
		if Showdown.config["Stickers"] then
			table.insert(list, poker_night)
			table.insert(list, luigis_casino)
		end
        if (SMODS.Mods["Cryptid"] or {}).can_load and Showdown.config["CrossMod"]["Cryptid"] then
			--table.insert(list, collatz)
        end
		return list
	end,
	atlases = {
		{key = "showdown_vouchers", path = "Consumables/Vouchers.png", px = 71, py = 95},
		{key = "showdown_cryptidVouchers", path = "CrossMod/Cryptid/Vouchers.png", px = 71, py = 95},
	},
}