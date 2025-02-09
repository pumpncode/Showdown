SMODS.Achievement({ -- :3
    key = 'get_jean_paul',
    unlock_condition = function(self, args)
		if args.type == "get_jean_paul" then
			return true
		end
	end,
})

SMODS.Achievement({ -- :(
    key = 'sell_jean_paul',
    hidden_text = true,
    unlock_condition = function(self, args)
		if args.type == "sell_jean_paul" then
			return true
		end
	end,
})

SMODS.Achievement({ -- :D
    key = 'jean_paul_tag',
    hidden_text = true,
    unlock_condition = function(self, args)
		if args.type == "jean_paul_tag" then
			return true
		end
	end,
})

SMODS.Achievement({ -- Jimbodia
    key = 'jimbodia',
    hidden_text = true,
    unlock_condition = function(self, args)
		if args.type == "jimbodia" then
			return true
		end
	end,
})

SMODS.Achievement({ -- Free from the chains
    key = 'chains',
    hidden_text = true,
    unlock_condition = function(self, args)
		if args.type == "chains" then
			return true
		end
	end,
})

SMODS.Achievement({ -- Versatility
    key = 'versatility',
    unlock_condition = function(self, args)
		if args.type == "versatility" then
			return true
		end
	end,
})

SMODS.Achievement({ -- You've been Blue'd!
    key = 'blued',
    hidden_text = true,
    unlock_condition = function(self, args)
		if args.type == "blued" then
			return true
		end
	end,
})

SMODS.Achievement({ -- Metal Cap
    key = 'metal_cap',
    unlock_condition = function(self, args)
		if args.type == "metal_cap" then
			return true
		end
	end,
})

SMODS.Achievement({ -- cronch
    key = 'cronch',
    hidden_text = true,
    unlock_condition = function(self, args)
		if args.type == "cronch" then
			return true
		end
	end,
})

SMODS.Achievement({ -- We have Green Deck at home
    key = 'green_deck_home',
    unlock_condition = function(self, args)
		if args.type == "green_deck_home" then
			return true
		end
	end,
})