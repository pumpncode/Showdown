local mirror = {
	type = 'Sleeve',
	order = 1,
	key = "Mirror",
	atlas = "showdown_sleeves",
	pos = coordinate(1),
	unlocked = false,
	unlock_condition = {deck = "b_showdown_Mirror", stake = "stake_green"},
	loc_vars = function(self)
		return { key = self.key..(self.get_current_deck_key() == "b_showdown_Mirror" and "_alt" or "") }
	end,
	apply = function(self, sleeve)
        CardSleeves.Sleeve.apply(self)
		if self.get_current_deck_key() ~= "b_showdown_Mirror" then
            SMODS.Back.obj_table["b_showdown_Mirror"].apply(self, sleeve)
        else
			--
        end
	end,
}

local calculus = {
	type = 'Sleeve',
	order = 2,
	key = "Calculus",
	atlas = "showdown_sleeves",
	pos = coordinate(2),
	unlocked = false,
	unlock_condition = {deck = "b_showdown_Calculus", stake = "stake_black"},
	loc_vars = function(self)
		local key, vars
        if self.get_current_deck_key() ~= "b_showdown_Calculus" then
            key = self.key
			self.config = { vouchers = { "v_showdown_number" }, consumables = { 'c_showdown_genie' } }
        else
            key = self.key .. "_alt"
			self.config = { vouchers = { "v_showdown_axiom" }, consumables = { 'c_showdown_genie' } }
        end
		return { key = key, vars = vars }
	end,
}

local starter = {
	type = 'Sleeve',
	order = 3,
	key = "Starter",
	atlas = "showdown_sleeves",
	pos = coordinate(3),
	config = { showdown_starter = true },
	unlocked = false,
	unlock_condition = {deck = "b_showdown_Starter", stake = "stake_black"},
	loc_vars = function(self)
		return { key = self.key..(self.get_current_deck_key() == "b_showdown_Starter" and "_alt" or "") }
	end,
	apply = function(self, sleeve)
        CardSleeves.Sleeve.apply(self)
		if self.get_current_deck_key() ~= "b_showdown_Starter" then
            G.GAME.starting_params.dollars = -5
			give_starter()
        else
            G.GAME.starting_params.dollars = 0
			give_starter(true)
        end
	end
}

local cheater = {
	type = 'Sleeve',
	order = 4,
	key = "Cheater",
	atlas = "showdown_sleeves",
	pos = coordinate(4),
	config = { showdown_cheater = true },
	unlocked = false,
	unlock_condition = {deck = "b_showdown_Cheater", stake = "stake_blue"},
	loc_vars = function(self)
		return { key = self.key..(self.get_current_deck_key() == "b_showdown_Cheater" and "_alt" or ""), vars = { (G.GAME and G.GAME.probabilities.normal) or 1 } }
	end,
	apply = function(self, sleeve)
        CardSleeves.Sleeve.apply(self)
		if self.get_current_deck_key() ~= "b_showdown_Cheater" then
			SMODS.Back.obj_table["b_showdown_Cheater"].apply(self, sleeve)
		else
            G.GAME.cheater_seal = true
        end
	end,
}

local engineer = { -- Not done at all
	type = 'Sleeve',
	order = 5,
	key = "Engineer",
	atlas = "showdown_sleeves",
	pos = coordinate(5),
	unlocked = false,
	unlock_condition = {deck = "b_showdown_Engineer", stake = "stake_purple"},
	loc_vars = function(self)
		return { key = self.key..(self.get_current_deck_key() == "b_showdown_Engineer" and "_alt" or "") }
	end,
	apply = function(self, sleeve)
        CardSleeves.Sleeve.apply(self)
		if self.get_current_deck_key() ~= "b_showdown_Engineer" then
            SMODS.Back.obj_table["b_showdown_Engineer"].apply(self, sleeve)
        else
            --
        end
	end
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
		{key = "showdown_sleeves", path = "CrossMod/CardSleeves/sleeves.png", px = 73, py = 94},
	},
	order = 2,
    class = CardSleeves,
}