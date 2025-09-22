-- Boss Blinds

local latch = {
	type = 'Blind',
	order = 1,
	key = "latch",
	name = "The Latch",
	atlas = "showdown_blinds",
	pos = { x = 0, y = 0 },
	no_collection = true,
	boss_colour = G.C.GREY,
	boss = { min = 1 },
	mult = 3,
	defeat = function(self)
		local lock = find_joker('4_locks')
		if next(lock) then
			local lockJ = lock[next(lock)]
			if not lockJ.ability.extra.locks[4] then
				lockJ.ability.extra.locks[4] = true
				forced_message(localize('k_unlocked'), lockJ, G.C.YELLOW, true)
			end
		end
	end,
	in_pool = function(self, args)
		local lock = find_joker('4_locks')
		return next(lock) and not lock[next(lock)].ability.extra.locks[4]
	end
}

local patient = {
	type = 'Blind',
	order = 2,
	key = "patient",
	name = "The Patient",
	atlas = "showdown_blinds",
	pos = { x = 0, y = 1 },
	boss_colour = G.C.BLUE,
	boss = { min = 2 },
	mult = 2,
}

local wasteful = {
	type = 'Blind',
	order = 3,
	key = "wasteful",
	name = "The Wasteful",
	atlas = "showdown_blinds",
	pos = { x = 0, y = 3 },
	boss_colour = G.C.RED,
	boss = { min = 2 },
	mult = 2,
	debuff_hand = function(self, cards, hand, handname, check)
		return G.GAME.current_round.discards_left > 0
	end
}

local shameful = {
	type = 'Blind',
	order = 4,
	key = "shameful",
	name = "The Shameful",
	atlas = "showdown_blinds",
	pos = { x = 0, y = 2 },
	boss_colour = G.C.YELLOW,
	boss = { min = 1 },
	mult = 2,
}

-- Chess Blinds

function chess_blind(obj)
	local white_piece = {
		type = 'Blind',
		order = obj.order,
		key = 'white_'..obj.key,
		name = 'White '..obj.name,
		atlas = "showdown_blinds",
		pos = { x = 0, y = obj.order + 1 },
		boss_colour = {0.8, 0.8, 0.8, 1},
		chess_boss = { min = obj.chess_boss.min, max = obj.chess_boss.max },
		dollars = 4,
		mult = 1.5,
		modify_hand = obj.modify_hand,
		set_blind = function() end
	}
	local black_piece = {
		type = 'Blind',
		order = obj.order + 1,
		key = 'black_'..obj.key,
		name = 'Black '..obj.name,
		atlas = "showdown_blinds",
		pos = { x = 0, y = obj.order + 2 },
		boss_colour = G.C.BLACK,
		chess_boss = { min = obj.chess_boss.min, max = obj.chess_boss.max },
		dollars = 4,
		mult = 1.5,
	}
	return white_piece, black_piece
end

local white_pawn, black_pawn = chess_blind{
	order = 5,
	key = "pawn",
	name = "Pawn",
	chess_boss = { min = 1 },
}
white_pawn.modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
	local eval = evaluate_poker_hand(cards)
	if G.GAME.chess_blinds_hand and next(eval[G.GAME.chess_blinds_hand]) then
		return G.GAME.showdown_chess_boosted and mult * 0.25 or mult * 0.5, hand_chips, true
	end
	return mult, hand_chips, false
end
white_pawn.loc_vars = function(self, cards, poker_hands, text, mult, hand_chips) return { vars = {G.GAME.showdown_chess_boosted and 0.25 or 0.5, G.GAME.chess_blinds_hand or '[poker hand]'} } end
white_pawn.collection_loc_vars = function(self, cards, poker_hands, text, mult, hand_chips) return { vars = {G.GAME.showdown_chess_boosted and 0.25 or 0.5, G.GAME.chess_blinds_hand or 'Flush'} } end
black_pawn.modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
	local eval = evaluate_poker_hand(cards)
	if G.GAME.chess_blinds_hand and next(eval[G.GAME.chess_blinds_hand]) then
		return G.GAME.showdown_chess_boosted and mult * 4 or mult * 2, hand_chips, true
	end
	return mult, hand_chips, false
end
black_pawn.loc_vars = function(self, cards, poker_hands, text, mult, hand_chips) return { vars = {G.GAME.showdown_chess_boosted and 4 or 2, G.GAME.chess_blinds_hand or '[poker hand]'} } end
black_pawn.collection_loc_vars = function(self, cards, poker_hands, text, mult, hand_chips) return { vars = {G.GAME.showdown_chess_boosted and 4 or 2, G.GAME.chess_blinds_hand or 'Flush'} } end

local white_rook, black_rook = chess_blind{
	order = 7,
	key = "rook",
	name = "Rook",
	chess_boss = { min = 1 },
}
white_rook.modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
	local hasSuit = false
	for _, card in ipairs(cards) do
		if not hasSuit then
			hasSuit = card:is_suit(G.GAME.chess_blinds_suit)
		end
	end
	if hasSuit then
		return G.GAME.showdown_chess_boosted and mult * 0.25 or mult * 0.5, hand_chips, true
	end
	return mult, hand_chips, false
end
white_rook.loc_vars = function(self, cards, poker_hands, text, mult, hand_chips) return { vars = {G.GAME.showdown_chess_boosted and 0.25 or 0.5, G.GAME.chess_blinds_suit or '[suit]'} } end
white_rook.collection_loc_vars = function(self, cards, poker_hands, text, mult, hand_chips) return { vars = {G.GAME.showdown_chess_boosted and 0.25 or 0.5, G.GAME.chess_blinds_suit or 'Spades'} } end
black_rook.modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
	local hasSuit = false
	for _, card in ipairs(cards) do
		if not hasSuit then
			hasSuit = card:is_suit(G.GAME.chess_blinds_suit)
		end
	end
	if hasSuit then
		return G.GAME.showdown_chess_boosted and mult * 4 or mult * 2, hand_chips, true
	end
	return mult, hand_chips, false
end
black_rook.loc_vars = function(self, cards, poker_hands, text, mult, hand_chips) return { vars = {G.GAME.showdown_chess_boosted and 4 or 2, G.GAME.chess_blinds_suit or '[suit]'} } end
black_rook.collection_loc_vars = function(self, cards, poker_hands, text, mult, hand_chips) return { vars = {G.GAME.showdown_chess_boosted and 4 or 2, G.GAME.chess_blinds_suit or 'Spades'} } end

local white_knight, black_knight = chess_blind{
	order = 9,
	key = "knight",
	name = "Knight",
	chess_boss = { min = 1 },
}

local white_bishop, black_bishop = chess_blind{
	order = 11,
	key = "bishop",
	name = "Bishop",
	chess_boss = { min = 1 },
}

local white_queen, black_queen = chess_blind{
	order = 13,
	key = "queen",
	name = "Queen",
	chess_boss = { min = 4 },
}

local white_king, black_king = chess_blind{
	order = 15,
	key = "king",
	name = "King",
	chess_boss = { min = 4 },
}

local white_unicorn, black_unicorn = chess_blind{
	order = 17,
	key = "unicorn",
	name = "Unicorn",
	chess_boss = { min = 2 },
}

local white_dragon, black_dragon = chess_blind{
	order = 19,
	key = "dragon",
	name = "Dragon",
	chess_boss = { min = 2 },
}

local white_princess, black_princess = chess_blind{
	order = 21,
	key = "princess",
	name = "Princess",
	chess_boss = { min = 4 },
}

return {
	enabled = Showdown.config["Blinds"],
	list = function()
		local list = {
			patient,
			wasteful,
			--shameful,
		}
		if Showdown.config["Jokers"]["Final"] then
			table.insert(list, latch)
		end
		if Showdown.config["Decks"] or ((SMODS.Mods["CardSleeves"] or {}).can_load and Showdown.config["CrossMod"]["CardSleeves"]) then
			table.insert(list, white_pawn)
			table.insert(list, black_pawn)
			table.insert(list, white_rook)
			table.insert(list, black_rook)
			table.insert(list, white_knight)
			table.insert(list, black_knight)
			table.insert(list, white_bishop)
			table.insert(list, black_bishop)
			table.insert(list, white_queen)
			table.insert(list, black_queen)
			table.insert(list, white_king)
			table.insert(list, black_king)
			table.insert(list, white_unicorn)
			table.insert(list, black_unicorn)
			table.insert(list, white_dragon)
			table.insert(list, black_dragon)
			table.insert(list, white_princess)
			table.insert(list, black_princess)
		end
		return list
	end,
	atlases = {
		{key = "showdown_blinds", path = "Blinds.png", px = 34, py = 34, atlas_table = "ANIMATION_ATLAS", frames = 21},
	},
	exec = function()
		function SMODS.patient_gain_score(blind) -- Thanks Bunco
			if not G.GAME.patient_scoring then G.GAME.patient_scoring = { score = blind.chips, triggers = 0 } end
			G.GAME.patient_scoring.triggers = G.GAME.patient_scoring.triggers + 1
			local final_chips = (G.GAME.patient_scoring.score / 100) * (100 + 50 * G.GAME.patient_scoring.triggers)
			local chip_mod -- iterate over ~120 ticks
			if type(blind.chips) ~= 'table' then
				chip_mod = math.ceil((G.GAME.blind.chips + final_chips) / 120)
			else
				chip_mod = ((G.GAME.blind.chips + final_chips) / 120):ceil()
			end
			local step = 0
			G.E_MANAGER:add_event(Event({trigger = 'after', blocking = true, func = function()
				blind.chips = blind.chips + G.SETTINGS.GAMESPEED * chip_mod
				if blind.chips < final_chips then
					blind.chip_text = number_format(blind.chips)
					if step % 5 == 0 then
						play_sound('chips1', 1.0 + (step * 0.005))
					end
					step = step + 1
				else
					blind.chips = final_chips
					blind.chip_text = number_format(blind.chips)
					return true
				end
			end}))
		end

		function Showdown.get_new_chess_blind()
			--[[G.GAME.perscribed_chess_bosses = G.GAME.perscribed_chess_bosses or {}
			if G.GAME.perscribed_chess_bosses and G.GAME.perscribed_chess_bosses[G.GAME.round_resets.ante] then
				local ret_boss = G.GAME.perscribed_chess_bosses[G.GAME.round_resets.ante]
				G.GAME.perscribed_chess_bosses[G.GAME.round_resets.ante] = nil
				G.GAME.bosses_used[ret_boss] = G.GAME.bosses_used[ret_boss] + 1
				return ret_boss
			end
			if G.FORCE_CHESS then return G.FORCE_CHESS end]]--
			
			local eligible_bosses = {}
			for k, v in pairs(G.P_BLINDS) do
				if not v.chess_boss then
				elseif v.in_pool and type(v.in_pool) == 'function' then
					local res, options = v:in_pool()
					if
						(((G.GAME.round_resets.ante)%G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2) == false)
						or (options or {}).ignore_chess_check
					then
						eligible_bosses[k] = res and true or nil
					end
				elseif v.chess_boss.min <= math.max(1, G.GAME.round_resets.ante) and ((math.max(1, G.GAME.round_resets.ante))%G.GAME.win_ante ~= 0 or G.GAME.round_resets.ante < 2) then
					eligible_bosses[k] = true
				end
			end
			for k, _ in pairs(G.GAME.banned_keys) do
				if eligible_bosses[k] then eligible_bosses[k] = nil end
			end

			local min_use = 100
			for k, v in pairs(G.GAME.bosses_used) do
				if eligible_bosses[k] then
					eligible_bosses[k] = v
					if eligible_bosses[k] <= min_use then
						min_use = eligible_bosses[k]
					end
				end
			end
			for k, _ in pairs(eligible_bosses) do
				if eligible_bosses[k] then
					if eligible_bosses[k] > min_use then
						eligible_bosses[k] = nil
					end
				end
			end
			local _, boss = pseudorandom_element(eligible_bosses, pseudoseed('chess_boss'))
			G.GAME.bosses_used[boss] = G.GAME.bosses_used[boss] + 1

			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible then _poker_hands[#_poker_hands+1] = k end
			end
			G.GAME.chess_blinds_hand = pseudorandom_element(_poker_hands, pseudoseed('chess_boss_hand'))
			G.GAME.chess_blinds_suit = pseudorandom_element(get_all_suits(), pseudoseed('chess_boss_hand'))
			
			return boss
		end

		if not (SMODS.Mods["Cryptid"] or {}).can_load then
			local gnb = get_new_boss
			function get_new_boss()
				for k, _ in pairs(G.P_BLINDS) do -- this is for adding bosses mid-run
					if not G.GAME.bosses_used[k] then
						G.GAME.bosses_used[k] = 0
					end
				end
				return gnb()
			end
		end
	end
}