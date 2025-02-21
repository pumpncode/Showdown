local mirror = {
	type = 'Sleeve',
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
			if self.allowed_card_centers == nil then
				self.allowed_card_centers = {}
				self.skip_trigger_effect = true
				G.E_MANAGER:add_event(Event({
					func = function()
						for i = #G.playing_cards, 1, -1 do
							local card = G.playing_cards[i]
							local count = SMODS.Ranks[card.base.value].counterpart
							if not (count and count.is) then
								card:remove()
							end
						end
						
						for _, card_center in pairs(G.P_CARDS) do
							local card_instance = Card(0, 0, 0, 0, card_center, G.P_CENTERS.c_base)
							if SMODS.Ranks[card_instance.base.value].counterpart then
								self.allowed_card_centers[#self.allowed_card_centers+1] = card_center
							end
							card_instance:remove()
						end
						return true
					end
				}))
				self.skip_trigger_effect = false
				self.get_next_counterpart = function(value)
					local count = {
						['showdown_2.5'] = 'showdown_5.5',
						['showdown_5.5'] = 'showdown_8.5',
						['showdown_8.5'] = 'showdown_Butler',
						['showdown_Butler'] = 'showdown_Princess',
						['showdown_Princess'] = 'showdown_Lord',
						['showdown_Lord'] = 'showdown_2.5',
					}
					return count[value]
				end
			end
			--[[
			G.E_MANAGER:add_event(Event({
				func = function()
					local checked = {}
					for i = #G.playing_cards, 1, -1 do
						local card = G.playing_cards[i]
						local playing_card = card.base.suit..'_'..card.base.value
						local has_been_checked = findInTable(playing_card, checked)
						if not has_been_checked then
							table.insert(checked, playing_card)
						else
							card:remove()
						end
					end
					return true
				end
			}))
			]]
        end
	end,
    calculate = function(self, sleeve, context)
        if self.get_current_deck_key() ~= "b_showdown_Mirror" then
            return
        end
        if sleeve.skip_trigger_effect then
            return
        end
        if sleeve.allowed_card_centers == nil then
            sleeve:apply()
        end

        local card = context.card
        local is_playing_card = card and (card.ability.set == "Default" or card.ability.set == "Enhanced") and card.config.card_key
        if context.before_use_consumable and card then
            if card.ability.name == 'Strength' then
                sleeve.in_strength = true
            elseif card.ability.name == "Ouija" then
                sleeve.in_ouija = true
            end
        elseif context.after_use_consumable then
            sleeve.in_strength = nil
            sleeve.in_ouija = nil
            sleeve.ouija_rank = nil
        elseif (context.create_card or context.modify_playing_card) and card and is_playing_card then
			local initial = G.GAME.blind == nil or context.create_card
            if SMODS.Ranks[card.base.value].counterpart and SMODS.Ranks[card.base.value].counterpart.is then -- ?????
				if sleeve.in_strength then
                    local base_key = SMODS.Suits[card.base.suit].card_key .. "_" .. sleeve.get_next_counterpart(card.base.value)
                    card:set_base(G.P_CARDS[base_key], initial)
				end
			else
                if sleeve.in_strength then
                    local base_key = SMODS.Suits[card.base.suit].card_key .. "_showdown_2.5"
                    card:set_base(G.P_CARDS[base_key], initial)
                elseif sleeve.in_ouija then
                    if sleeve.ouija_rank == nil then
                        local random_base = pseudorandom_element(sleeve.allowed_card_centers, pseudoseed("slv"))
                        local card_instance = Card(0, 0, 0, 0, random_base, G.P_CENTERS.c_base)
                        sleeve.ouija_rank = SMODS.Ranks[card_instance.base.value]
                        card_instance:remove()
                    end
                    local base_key = SMODS.Suits[card.base.suit].card_key .. "_" .. sleeve.ouija_rank.card_key
                    card:set_base(G.P_CARDS[base_key], initial)
                else
                    local random_base = pseudorandom_element(sleeve.allowed_card_centers, pseudoseed("slv"))
                    card:set_base(random_base, initial)
                end
            end
        end
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
	apply = function(self, sleeve)
        CardSleeves.Sleeve.apply(self)
		if self.get_current_deck_key() ~= "b_showdown_Calculus" then
            SMODS.Back.obj_table["b_showdown_Calculus"].apply(self, sleeve)
        else
            --
        end
	end
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
	apply = function(self, sleeve)
        CardSleeves.Sleeve.apply(self)
		if self.get_current_deck_key() ~= "b_showdown_Starter" then
            SMODS.Back.obj_table["b_showdown_Starter"].apply(self, sleeve)
        else
            G.GAME.starting_params.dollars = 0
			give_starter(true)
        end
	end
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
        if self.get_current_deck_key() ~= "b_showdown_Cheater" then
            key = self.key
            vars = { (G.GAME and G.GAME.probabilities.normal) or 1 }
        else
            key = self.key .. "_alt"
        end
		return { key = key, vars = vars }
	end,
	calculate = function(self, card, context)
        if self.get_current_deck_key() ~= "b_showdown_Cheater" then
            SMODS.Back.obj_table["b_showdown_Cheater"].calculate(self, card, context)
        else
            --
        end
	end,
	apply = function(self, sleeve)
        CardSleeves.Sleeve.apply(self)
		if self.get_current_deck_key() ~= "b_showdown_Cheater" then
            SMODS.Back.obj_table["b_showdown_Cheater"].apply(self, sleeve)
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