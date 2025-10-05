local boosters = {
    mathematic = {},
    logic = {},
}

-- Mathematic

for i = 1, 4 do
    table.insert(boosters.mathematic, {
		type = 'Booster',
		order = i,
        key = 'calculus_'..(i <= 2 and i or i == 3 and 'jumbo' or 'mega'),
        config = {extra = i <= 2 and 2 or 4, choose =  i <= 3 and 1 or 2},
        create_card = function(self, card)
            return create_card('Mathematic', G.pack_cards, nil, nil, true, true, nil, 'showdown_calculus')
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_CALCULUS)
            ease_background_colour{new_colour = G.C.SHOWDOWN_CALCULUS, special_colour = G.C.BLACK, contrast = 2}
        end,
        cost = (i <= 2 and 4 or i == 3 and 6 or 8),
        pos = coordinate(i),
        atlas = 'showdown_booster_packs',
		kind = 'booster_calculus',
		group_key = "k_showdown_calculus_pack",
        in_pool = function() return (pseudorandom('calculus'..G.SEED) < 0.5) end,
		update_pack = function(self, dt)
            if G.buttons then G.buttons:remove(); G.buttons = nil end
            if G.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
            if not G.STATE_COMPLETE then
                G.STATE_COMPLETE = true
                G.CONTROLLER.interrupt.focus = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        if self.particles and type(self.particles) == "function" then self:particles() end
                        G.booster_pack = UIBox{
                            definition = self:create_UIBox(),
                            config = {align="tmi", offset = {x=0,y=G.ROOM.T.y + 9}, major = G.hand, bond = 'Weak'}
                        }
                        G.booster_pack.alignment.offset.y = -2.2
                        G.ROOM.jiggle = G.ROOM.jiggle + 3
                        self:ease_background_colour()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            func = function()
                                if G.GAME.draw_hand_math then G.FUNCS.draw_from_deck_to_hand() end
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.5,
                                    func = function()
                                        G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                        return true
                                    end}))
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
        end,
    })
end

-- Logic

for i = 1, 4 do
    table.insert(boosters.logic, {
		type = 'Booster',
		order = 4 + i,
        key = 'boolean_'..(i <= 2 and i or i == 3 and 'jumbo' or 'mega'),
        config = {extra = i <= 2 and 3 or 5, choose = i <= 3 and 1 or 2},
        create_card = function(self, card)
            return create_card('Logic', G.pack_cards, nil, nil, true, true, nil, 'showdown_boolean')
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SHOWDOWN_BOOLEAN)
            ease_background_colour{new_colour = G.C.SHOWDOWN_BOOLEAN, special_colour = G.C.BLACK, contrast = 2}
        end,
        cost = (i <= 2 and 4 or i == 3 and 6 or 8),
        pos = coordinate(4+i, 4),
        atlas = 'showdown_booster_packs',
		kind = 'booster_boolean',
		group_key = "k_showdown_boolean_pack",
        in_pool = function() return (pseudorandom('boolean'..G.SEED) < 0.4) end,
    })
end

return {
	enabled = true,
	list = function ()
        local list = {}
        if Showdown.config["Consumeables"]["Mathematics"] then
            for _, v in ipairs(boosters.mathematic) do
                table.insert(list, v)
            end
        end
        if Showdown.config["Consumeables"]["Logics"] then
            for _, v in ipairs(boosters.logic) do
                table.insert(list, v)
            end
        end
		return list
	end,
    order = 1,
	atlases = {
		{key = 'showdown_booster_packs', path = 'Boosters.png', px = 71, py = 95},
	},
}