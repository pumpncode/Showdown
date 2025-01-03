function say(card, args)
    if not card.hasSpeech then print(card.ability.name.." tried to speak. But sadly, he remembers that he does not have any mouth...") return end
    if not args.prob and not args.guaranteed then print(card.ability.name.." tried to speak. But sadly, he doesn't know how to count...") return end
    if not args then args = {} end
    if args.guaranteed or math.random(args.prob) == 1 then
        card.add_speech_bubble(args.blabla or '', args.align, {quip = true}, args.direction or 'down')
        card.say_stuff(5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = args.delay or G.SETTINGS.GAMESPEED * 2,
            func = function()
                card:remove_speech_bubble()
              return true
            end
        }), 'other')
        card.ability.extra.talk = math.random(500, 2500)
    end
end

function speech_bubble(text_key, loc_vars, card)
    local text = {}
    if loc_vars and loc_vars.quip then
      localize{type = 'quips', key = text_key or 'lq_1', vars = loc_vars or {}, nodes = text}
    else
      localize{type = 'tutorial', key = text_key or 'sb_1', vars = loc_vars or {}, nodes = text}
    end
    local row = {}
    for k, v in ipairs(text) do
      row[#row+1] =  {n=G.UIT.R, config={align = "cl"}, nodes=v}
    end
    local t = {n = G.UIT.ROOT, config = {align = "cm", minh = 0, r = 0.3, padding = 0.07, minw = 1, colour = G.C.JOKER_GREY, shadow = true}, nodes={
                  {n = G.UIT.C, config = {align = "cm", minh = 0, r = 0.2, padding = 0.1, minw = 1, colour = G.C.WHITE}, nodes = {
                    {n = G.UIT.C, config = {align = "cm", minh = 0, r = 0.2, padding = 0.03, minw = 1, colour = G.C.WHITE}, nodes = row}}
                  }
                }}
    return t
end

local dir = {
    ['down'] = "bm",
    ['up'] = "tm",
}

-- Taken from card_character
-- I originally used card_character to make Jean-Paul speak, but on top of being annoying to use here, I couldn't load it when reloading a game
-- So I decided to give speech directly to the card :3
-- If i did things right, giveSpeech and say are public functions which means that is you want to, you can give speech to any joker you want
-- (If you do this, think about updating your lovely patches like I did for Jean-Paul (lines 290 to 300))
function giveSpeech(card)
    card.hasSpeech = true

    card.add_speech_bubble = function(text_key, align, loc_vars)
        if card.children.speech_bubble then card.children.speech_bubble:remove() end
        card.config.speech_bubble_align = {align=dir[align] or 'bm', offset = {x=0,y=0},parent = card}
        card.children.speech_bubble = UIBox{
            definition = speech_bubble(text_key, loc_vars, card),
            config = card.config.speech_bubble_align
        }
        card.children.speech_bubble:set_role{
            role_type = 'Major',
            xy_bond = 'Strong',
            r_bond = 'Strong',
            major = card,
        }
        card.children.speech_bubble.states.visible = false
    end

    card.remove_speech_bubble = function()
        if card.children.speech_bubble then card.children.speech_bubble:remove(); card.children.speech_bubble = nil end
    end

    card.say_stuff = function(n, not_first)
        if not not_first then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if card.children.speech_bubble then card.children.speech_bubble.states.visible = true end
                    card.say_stuff(n, true)
                  return true
                end
            }))
        else
            if n <= 0 then return end
            play_sound('voice'..math.random(1, 11), G.SPEEDFACTOR*(math.random()*0.2+1), 0.5)
            card:juice_up(nil, 0.05)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blockable = false, blocking = false,
                delay = 0.13,
                func = function()
                    card.say_stuff(n-1, true)
                return true
                end
            }), 'other')
        end
    end

    local drawRef = card.draw
    card.draw = function(layer)
        if card.children.speech_bubble then
            card.children.speech_bubble:draw()
        end
        drawRef(layer)
    end
end

local create_cardRef = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local _card = create_cardRef(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if _card.ability.name == 'jean_paul' then
        giveSpeech(_card)
        --_card.ability.extra.character = Card_Character({card = _card})
    end
    return _card
end

SMODS.Atlas({key = "showdown_jean_paul_joker", path = "Jokers/JeanPaul.png", px = 71, py = 95})

create_joker({ -- Jean-Paul
    name = 'jean_paul', loc_txt = loc.jean_paul_joker,
    atlas = "showdown_jean_paul_joker",
    pos = coordinate(1),
    vars = {{talk = 0}},
    rarity = 'Common', cost = 2,
    blueprint = false, perishable = false, eternal = true,
    calculate = function(self, card, context)
        if not context.blueprint and not context.repetition then
            if context.end_of_round and not context.individual then
                say(card, {blabla = ('end_of_round_'..math.random(4)), prob = 2})
            elseif context.open_booster then
                say(card, {blabla = ('open_booster_'..math.random(3)), prob = 3})
            elseif context.buying_card then
                say(card, {blabla = ('buying_card_'..math.random(5)), prob = 2})
            elseif context.selling_card then
                say(card, {blabla = ('selling_card_'..math.random(3)), prob = 3})
            elseif context.reroll_shop then
                say(card, {blabla = ('reroll_shop_'..math.random(4)), prob = 3})
            end
        end
    end,
    update = function(self, card, dt)
        if card.ability.extra.talk <= 0 then
            if card.area == G.shop_jokers then
                say(card, {blabla = ('shop_jokers_'..math.random(3)), prob = 250, align = 'up'})
            end
        else
            card.ability.extra.talk = card.ability.extra.talk - 1
        end
    end
})