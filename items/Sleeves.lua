local mirror = {
	type = 'Sleeve',
	key = "Mirror",
	atlas = "showdown_sleeves",
	pos = coordinate(1),
	config = {counterpart_replacing = true},
	unlocked = false,
	unlock_condition = {deck = "b_showdown_Mirror", stake = "stake_green"},
	loc_vars = function(self)
		return { key = self.key..(self.get_current_deck_key() == "b_showdown_Mirror" and "_alt" or "") }
	end,
}

local calculus = {
	type = 'Sleeve',
	key = "Calculus",
	atlas = "showdown_sleeves",
	pos = coordinate(2),
	config = { vouchers = { "v_showdown_number" }, consumables = {'c_showdown_genie'}, showdown_calculus = true },
	unlocked = false,
	unlock_condition = {deck = "b_showdown_Calculus", stake = "stake_black"},
	loc_vars = function(self)
		return { key = self.key..(self.get_current_deck_key() == "b_showdown_Calculus" and "_alt" or "") }
	end,
}

local starter = {
	type = 'Sleeve',
	key = "Starter",
	atlas = "showdown_sleeves",
	pos = coordinate(3),
	config = { showdown_starter = true },
	unlocked = false,
	unlock_condition = {deck = "b_showdown_Starter", stake = "stake_black"},
	loc_vars = function(self)
		return { key = self.key..(self.get_current_deck_key() == "b_showdown_Starter" and "_alt" or "") }
	end,
}

local cheater = {
	type = 'Sleeve',
	key = "Cheater",
	atlas = "showdown_sleeves",
	pos = coordinate(4),
	config = { showdown_cheater = true },
	unlocked = false,
	unlock_condition = {deck = "b_showdown_Cheater", stake = "stake_blue"},
	loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() ~= "b_showdown_Mirror" then
            key = self.key
            vars = { (G.GAME and G.GAME.probabilities.normal) or 1 }
        else
            key = self.key .. "_alt"
        end
		return { key = key, vars = vars }
	end,
	calculate = function(self, card, context)
        if self.get_current_deck_key() ~= "b_showdown_Cheater" then
            if context.post_hand then
                local cards = 1
                for _, joker in pairs(find_joker('versatile_joker')) do
                    cards = cards + joker.ability.extra.extra_card
                end
                local ranks = get_all_ranks({onlyFace = true, whitelist = {"showdown_Zero"}})
                local suits = get_all_suits({exotic = G.GAME and G.GAME.Exotic})
                create_cards_in_deck(ranks, suits, cards)
            end
        else
            --
        end
	end
}

local engineer = { -- Not done at all
	type = 'Sleeve',
	key = "Engineer",
	atlas = "showdown_sleeves",
	pos = coordinate(5),
	config = { showdown_engineer = true },
	unlocked = false,
	unlock_condition = {deck = "b_showdown_Engineer", stake = "stake_purple"},
	loc_vars = function(self)
		return { key = self.key..(self.get_current_deck_key() == "b_showdown_Engineer" and "_alt" or "") }
	end,
}

return {
	enabled = (SMODS.Mods["CardSleeves"] or {}).can_load and Showdown.config["CrossMod"]["CardSleeves"],
	list = function()
		local list = {
			starter,
		}
		if Showdown.config["Ranks"] then
			table.insert(list, mirror)
			table.insert(list, cheater)
		end
		if Showdown.config["Consumeables"]["Mathematics"] then
			table.insert(list, calculus)
		end
		if Showdown.config["Tags"]["Switches"] then
			table.insert(list, engineer)
		end
		return list
	end,
	atlases = {
		{key = "showdown_sleeves", path = "CrossMod/CardSleeves/sleeves.png", px = 73, py = 95},
	},
    class = CardSleeves,
}