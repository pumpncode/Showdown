return {
    descriptions = {
        Back={
            b_showdown_Mirror = {
                name = 'Mirror Deck',
                text = {
                    'All faces, 8s, 5s and',
                    '2s are replaced',
                    'by their {C:counterpart_ranks,T:counterpart_ranks}counterpart{}',
                    'Aces are replaced by 0s',
                }
            },
            b_showdown_Calculus = {
                name = 'Calculus Deck',
                text = {
                    'First booster in the shop is',
                    'always a {C:showdown_calculus}Calculus Booster{}',
                    'You start with a {C:purple}Genie{} tarot',
                    'card and {C:attention}Number Theory{}',
                }
            },
            b_showdown_Starter = {
                name = 'Starter Deck',
                text = {
                    'Start with a {C:attention}random',
                    'joker, consumable,',
                    'voucher and {C:money}$-5',
                }
            },
            b_showdown_Cheater = {
                name = 'Cheater Deck',
                text = {
                    'idk',
                }
            },
        },
        Blind={
            bl_showdown_latch = {
                name = 'The Latch',
                text = {
                    'Unlocks the',
                    'Yellow Lock',
                }
            },
            bl_showdown_patient = {
                name = 'The Patient',
                text = {
                    'Blind requirement ',
                    'increases if played',
                    'hand isn\'t last',
                }
            },
            bl_showdown_shameful = {
                name = 'The Shameful',
                text = {
                    'Enhancements and',
                    'seals are inactive',
                }
            },
            bl_showdown_wasteful = {
                name = 'The Wasteful',
                text = {
                    'You cannot play',
                    'while having',
                    'discards',
                }
            },
        },
        Edition={},
        Enhanced={
            m_showdown_ghost = {
                name = 'Ghost Card',
                text = {
                    '{X:mult,C:white}X#1#{} Mult and {X:chips,C:white}X#2#{} Chips',
                    '{C:green}#4# in #3#{} chance to disappear',
                    'after all scoring is finished',
                }
            },
            m_showdown_holy = {
                name = 'Holy Card',
                text = {
                    '{X:mult,C:white}X#1#{} Mult',
                    'Gains {X:mult,C:white}X#2#{} Mult',
                    'when scored',
                }
            },
        },
        Joker={
            j_showdown_jean_paul = {
                name = 'Jean-Paul',
                text = {
                    'tehe :3',
                }
            },
            j_showdown_pinpoint = {
                name = 'Pinpoint',
                text = {
                    '{X:chips,C:white}X#1#{} Chips for each {C:attention}0{} in hand',
                },
                unlock = {
                    'Play a {C:attention}Five of a Kind{}',
                    'that contains only',
                    '{C:attention}0{} cards',
                }
            },
            j_showdown_mother_daughter = {
                name = 'Like Mother Like Daughter',
                text = {
                    '{X:mult,C:white}X#1#{} for each pair of',
                    'Princess scored and Queen in hand',
                },
                unlock = {
                    'Play a double pair hand',
                    'that contains {C:attention}Queens{}',
                    'and {C:attention}Princesses{}',
                }
            },
            j_showdown_crouton = {
                name = 'Crouton',
                text = {
                    '{X:mult,C:white}X#1#{} Mult for each',
                    'card held in hand',
                },
                unlock = {
                    '{E:1,s:1.3}?????'
                }
            },
            j_showdown_infection = {
                name = 'Infection',
                text = {
                    '{X:mult,C:white}X#1#{} Mult, {C:red}self-destruct{}',
                    'Cards in shop and boosters can',
                    'be {C:attention}replaced{} by {C:attention}Strange Thing{}',
                    'Future {C:attention}Strange Thing{} values are {C:attention}doubled{}',
                }
            },
            j_showdown_math_teacher = {
                name = 'Math Teacher',
                text = {
                    'This Joker gains {C:chips}+#2#{} Chips',
                    'for each {C:counterpart_ranks}counterpart{} card scored',
                    '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)',
                },
                unlock = {
                    'Play a {C:attention}Three of a Kind{}',
                    'with only {C:counterpart_ranks}counterpart{}',
                    'cards',
                }
            },
            j_showdown_gruyere = {
                name = 'Gruyère',
                text = {
                    'This Joker gains {C:mult}+#2#{} Mult',
                    'for each {C:attention}0{} scored',
                    '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)',
                }
            },
            j_showdown_mirror = {
                name = 'Mirror',
                text = {
                    'All {C:counterpart_ranks}counterpart{} and {C:attention}0{} card',
                    'are {C:attention}retriggered{}',
                }
            },
            j_showdown_crime_scene = {
                name = 'Crime Scene',
                text = {
                    'This Joker gains {X:mult,C:white}X#2#{} Mult',
                    'for each {C:attention}debuffed{} card scored',
                    '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
                },
                unlock = {
                    'Play a hand with',
                    '{C:attention}5{} debuffed card',
                }
            },
            j_showdown_ping_pong = {
                name = 'Ping Pong',
                text = {
                    'Scored {C:attention}Aces{} becomes {C:attention}7s{}',
                    'Scored {C:attention}7s{} becomes {C:attention}Aces{}',
                }
            },
            j_showdown_color_splash = {
                name = 'Color Splash',
                text = {
                    'Unscored card get',
                    'a {C:attention}random{} suit',
                },
                unlock = {
                    'Have 4 {C:attention}unscored{} card',
                    'of {C:attention}different{} suits',
                }
            },
            j_showdown_blue = {
                name = 'Blue',
                text = {
                    '{C:chips}+1{} Chip'
                },
                unlock = {
                    'Score less than {C:attention}10{}',
                    'chips in one hand',
                }
            },
            j_showdown_spotted_joker = {
                name = 'Spotted Joker',
                text = {
                    'Scored {C:attention}0{} cards gives {C:chips}+#1#{} Chips',
                    'This effect gains {C:chips}+#2#{} Chips for',
                    'each {C:attention}0{} card scored',
                }
            },
            j_showdown_golden_roulette = {
                name = 'Golden Roulette',
                text = {
                    'Has a {C:green}5 in 6{} chance to give',
                    '{C:money}#1#${} at the end of each',
                    'round, otherwise {C:red}self-destruct{}',
                }
            },
            j_showdown_bacteria = {
                name = 'Bacteria',
                text = {
                    'If hand contains a {C:attention}flush{} and',
                    '{C:attention}at least one 0{}, convert',
                    'a {C:attention}non 0{} card to a {C:attention}0{}',
                }
            },
            j_showdown_empty_joker = {
                name = 'Empty Joker',
                text = {
                    '{C:mult}+#1#{} Mult if played hand',
                    'contains a {C:attention}0{}',
                }
            },
            j_showdown_baby_jimbo = {
                name = 'Baby Jimbo',
                text = {
                    'Creates a {C:dark_edition}Negative{} {C:spectral}Spectral{} card',
                    'when a joker is {C:attention}destroyed{}',
                }
            },
            j_showdown_parmesan = {
                name = 'Parmesan',
                text = {
                    'Every played {C:attention}card{} permanently',
                    'gains {C:chips}chips{} equal to the {C:attention}lowest{}',
                    'played rank when scored',
                }
            },
            j_showdown_chaos_card = {
                name = 'Chaos Card',
                text = {
                    'After scoring, {C:attention}rank{} and {C:attention}suit{} of',
                    'every scored card is {C:attention}randomized{}',
                },
                unlock = {
                    'Play a {C:attention}Flush{}, a {C:attention}Straight{} and a',
                    '{C:attention}Five of a Kind{} in a single round',
                }
            },
            j_showdown_sim_card = {
                name = 'SIM Card',
                text = {
                    '{C:counterpart_ranks}Counterpart{} cards counts',
                    'as {C:attention}every{} suit',
                }
            },
            j_showdown_wall = {
                name = 'Wall',
                text = {
                    'Hello young man or woman. It seems that i was included into this wonderful and everlasting game called "Balatro" and made by indie',
                    'developper Localthunk. text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                    'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                },
                unlock = {
                    'Beat {C:attention}The Wall{} in {C:attention}one{} hand',
                }
            },
            j_showdown_one_doller = {
                name = 'one doller',
                text = {
                    'Buying something let you keep',
                    '{C:money}$1{} of the money you used',
                },
                unlock = {
                    'Buy something for {C:attention}free{}',
                }
            },
            j_showdown_revolution = {
                name = 'Revolution',
                text = {
                    'Scored {C:attention}face{} cards transforms',
                    'into {C:attention}non-face{} cards',
                    '{C:inactive}(No effect with Pareidolia)',
                }
            },
            j_showdown_fruit_sticker = {
                name = 'Fruit Sticker',
                text = {
                    '{X:mult,C:white}X#1#{} for each {C:attention}sticker{}',
                    '{C:inactive}(Stake stickers excluded)',
                },
                unlock = {
                    'Have {C:attention}at least one{} sticker on your',
                    '{C:attention}maximum{} amount of jokers',
                    '{C:inactive}(Stake stickers excluded)',
                }
            },
            j_showdown_sinful_joker = {
                name = 'Sinful Joker',
                text = {
                    '{C:mult}+#1#{} Mult to {C:attention}Greedy Joker{}, {C:attention}Lusty Joker{},',
                    '{C:attention}Wrathful Joker{} and {C:attention}Gluttonous Joker{}',
                    'every time a hand is played',
                },
                unlock = {
                    'Have {C:attention}Greedy Joker{}, {C:attention}Lusty Joker{},',
                    '{C:attention}Wrathful Joker{} and {C:attention}Gluttonous{}',
                    '{C:attention}Joker{} at the same time',
                }
            },
            j_showdown_egg_drawing = {
                name = 'Egg Drawing',
                text = {
                    'A random joker gains {C:money}$#1#{} of {C:attention}sell{}',
                    '{C:attention}value{} at the end of round',
                },
                unlock = {
                    'Sell a card for',
                    'more than {C:money}$10{}',
                }
            },
            j_showdown_jimbo_makeup = {
                name = "Jimbo's Makeup",
                text = {
                    'Get 5 {C:attention}specific jokers{} to...',
                },
            },
            j_showdown_jimbo_hat = {
                name = "Jimbo's Hat",
                text = {
                    'Get 5 {C:attention}specific jokers{} to...',
                },
            },
            j_showdown_jimbo_bells = {
                name = "Jimbo's Bells",
                text = {
                    'Get 5 {C:attention}specific jokers{} to...',
                },
            },
            j_showdown_jimbo_collar = {
                name = "Jimbo's Collar",
                text = {
                    'Get 5 {C:attention}specific jokers{} to...',
                },
            },
            j_showdown_gary_mccready = {
                name = 'Gary McCready',
                text = {
                    'Get 5 {C:attention}specific jokers{} to...',
                },
            },
            j_showdown_ultimate_joker = {
                name = 'Ultimate Joker',
                text = {
                    '{X:purple,C:white}X#1#{} Mult and Chips',
                    'Value equald to round',
                },
            },
            j_showdown_strainer = {
                name = 'Strainer',
                text = {
                    'For each {C:money}#1#${} spend in next {C:attention}boss shop{}',
                    'adds a {C:attention}non-face{} {C:counterpart_ranks}counterpart{} or',
                    '{C:attention}0{} card to your deck then {C:red}self-destruct{}',
                    '{C:inactive}(Inactive)',
                },
            },
            j_showdown_strainer_active = {
                name = 'Strainer',
                text = {
                    'For each {C:money}#1#${} spend in next {C:attention}boss shop{}',
                    'adds a {C:attention}non-face{} {C:counterpart_ranks}counterpart{} or',
                    '{C:attention}0{} card to your deck then {C:red}self-destruct{}',
                    '{C:inactive}(Currently {C:money}#2#${C:inactive})',
                },
            },
            j_showdown_billiard = {
                name = 'Billiard',
                text = {
                    '{C:attention}Retrigger{} cards',
                    'next to {C:attention}0{} cards',
                },
                unlock = {
                    'Trigger a {C:attention}0{}',
                    'card {C:attention}5{} times',
                }
            },
            j_showdown_hiding_details = {
                name = 'Hiding in the Details',
                text = {
                    'All cards are considered',
                    '{C:counterpart_ranks}counterpart{} cards',
                }
            },
            j_showdown_what_a_steel = {
                name = 'What a Steel!',
                text = {
                    'Each {C:attention}Steel Card{} in your {C:attention}full deck{}',
                    'add a {C:attention}1%{} reduction on shop items',
                    '{C:inactive}(Currently {C:attention}#1#%{}{C:inactive}, {C:attention}#2#%{}{C:inactive} with vouchers)',
                },
                unlock = {
                    'Buy a {C:attention}Steel Card{}',
                    'from the shop',
                }
            },
            j_showdown_diplomatic_immunity = {
                name = 'Diplomatic Immunity',
                text = {
                    'Last {C:attention}scored{} card',
                    '{C:attention}cannot{} be debuffed',
                }
            },
            j_showdown_nitroglycerin = {
                name = 'Nitroglycerin',
                text = {
                    'Held cards are {C:attention}destroyed{}',
                    'when this card is sold',
                    '{C:inactive}(Does not work in Booster Packs)',
                }
            },
            j_showdown_substitute_teacher = {
                name = 'Substitute Teacher',
                text = {
                    'This Joker gains {C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult',
                    'per {C:showdown_calculus}Mathematic{} card used',
                    '{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips and {C:mult}+#4#{C:inactive} Mult)',
                },
                unlock = {
                    'Use #1# {C:showdown_calculus}Mathematic{} cards',
                    '{C:inactive}(#2#/#1#)',
                }
            },
            j_showdown_world_map = {
                name = 'World Map',
                text = {
                    'Gains {C:chips}+#1#{} Chips if played',
                    'hand contains a {C:attention}Flush{} and a {C:attention}0{}',
                    '{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)',
                }
            },
            j_showdown_bugged_seed = {
                name = 'Bugged Seed',
                text = {
                    'idk',
                },
                unlock = {
                    'Win a run with {C:attention}Erratic Deck{}',
                    'on the {C:attention,E:1}7LB2WVPK{} seed',
                }
            },
            j_showdown_bugged_seed_unknown = {
                name = 'Bugged Seed',
                text = {
                    'idk',
                },
                unlock = {
                    'Win a run with {C:attention}??????{}',
                    'on the {C:attention,E:1}7LB2WVPK{} seed',
                }
            },
            j_showdown_sick_trick = {
                name = 'Sick Trick',
                text = {
                    'Copy the {C:attention}leftest lowest',
                    'rank card onto the card',
                    'on its {C:attention}left',
                }
            },
            j_showdown_jaws = {
                name = 'Jaws',
                text = {
                    'This Joker gains {C:chips}+#1#{} Chips when a',
                    'face card is {C:attention}discarded{}',
                    '{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)',
                },
                unlock = {
                    'Discard {C:attention}5 face cards{}',
                    'at the same time',
                }
            },
            j_showdown_4_locks = {
                name = '4 Locks',
                text = {
                    'The {C:red,E:1}Red{E:1} Lock{} is {C:attention}#1#',
                    'The {C:blue,E:1}Blue{E:1} Lock{} is {C:attention}#2#',
                    'The {C:green,E:1}Green{E:1} Lock{} is {C:attention}#3#',
                    'The {C:money,E:1}Yellow{E:1} Lock{} is {C:attention}#4#',
                    '{C:inactive}What lies beyond these locks?',
                },
                unlock = {
                    'Win the game in',
                    'a {C:attention}different{} way',
                }
            },
            j_showdown_unshackled_joker = {
                name = 'Unshackled Joker',
                text = {
                    'Multiplies {C:mult}Mult{} by',
                    '{C:attention}played{} hand {C:planet}level{}',
                }
            },
            j_showdown_red_coins = {
                name = 'Red Coins',
                text = {
                    'At end of each Round,',
                    '{C:money}$#1#{} per remaining {C:red}Discard',
                }
            },
            j_showdown_money_cutter = {
                name = 'Money Cutter',
                text = {
                    'At end of each Round,',
                    '{C:money}$#1#{} per remaining {C:blue}Hand',
                    'Earn no {C:attention}Interest',
                },
                unlock = {
                    'Win at least {C:money}$20{} of',
                    'interest in {C:attention}one round',
                }
            },
            j_showdown_passage_of_time = {
                name = 'Passage of Time',
                text = {
                    'This Joker gains {C:chips}+#1#{} Chips and',
                    '{C:mult}+#1#{} Mult at the end of round',
                    '{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips and {C:mult}+#2#{C:inactive} Mult)',
                }
            },
            j_showdown_colored_glasses = {
                name = 'Colored Glasses',
                text = {
                    'This Joker gains {C:mult}+#1#{} Mult if played',
                    'hand contains {C:attention}2{} different suits',
                    '{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)',
                }
            },
            j_showdown_2814 = {
                name = '2814',
                text = {
                    'idk',
                }
            },
            j_showdown_birth_of_a_new_day = {
                name = 'Birth of a New Day',
                text = {
                    'idk',
                }
            },
            j_showdown_rain_temple = {
                name = 'Rain Temple',
                text = {
                    'idk',
                }
            },
            j_showdown_lost_fragments = {
                name = 'Lost Fragments',
                text = {
                    'idk',
                }
            },
            j_showdown_pillar_new_sun = {
                name = 'Pillar / New Sun',
                text = {
                    'idk',
                }
            },
            j_showdown_voyage_embrace = {
                name = 'Voyage / Embrace',
                text = {
                    'idk',
                }
            },
            j_showdown_versatile_joker = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_unknown = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    '{C:red}Unknown deck, no effect',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_red = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'Discards give {C:money}$#1#',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_blue = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'Blue Deck',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_yellow = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'Gains {C:attention}sell value{} equal to {C:attention}interest',
                    'at end of round',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_green = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'You gain {C:attention}interest{} back',
                    'Earn an extra {C:money}$1{} of {C:attention}interest{} for',
                    'every {C:money}$5{} you have at end of round',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_black = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'Black Deck',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_magic = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    '{C:attention}+1{} Consumable slot',
                    '{C:purple}The Fool{} creates {C:attention}#1#{} additional card',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_nebula = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    '{C:planet}Planet{} cards give {C:attention}#1#{} additional level',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_ghost = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'All {C:spectral}Spectral{} cards and {C:spectral}Spectral',
                    '{C:spectral}Packs{} in the shop are {C:attention}free',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_abandoned = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    '{C:attention}Non-face{} cards are',
                    'retriggered {C:attention}#1#{} additional time',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_checkered = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'Played cards with {C:hearts}Heart{} suit give',
                    '{C:mult}+#1#{} Mult when scored',
                    '{C:green}#3# in #4#{} chance for played cards with',
                    '{C:spades}Spade{} suit to give {X:chips,C:white}X#2#{} Chips',
                    'when scored',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_zodiac = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'Using a {C:planet}Planet{} or {C:purple}Tarot{} card has',
                    'a {C:green}#1# in #2#{} chance to generate a',
                    'new {C:planet}Planet{} or {C:purple}Tarot{} card',
                    '{C:inactive}(Must have room)',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_painted = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    '{C:dark_edition}+2{C:attention} Joker{} slots',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_anaglyph = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'When getting a {C:attention}Double Tag{}, you',
                    'get {C:attention}#1#{} additional {C:attention}Double Tag',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_plasma = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'Instead of balancing {C:chips}Chips{} and',
                    '{C:mult}Mult{}, adds the {C:attention}quarter{} of both',
                    'to both',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_erratic = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'Erratic Deck',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_challenge = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    '{C:blue}+1{} hand and {C:red}+1{} discard',
                    'each round',
                    '{C:attention}This bonus can\'t be modified',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_mirror = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'Scored non-enhanced {C:counterpart_ranks}counterparts',
                    'gains a {C:attention}random{} enhancement from',
                    'your {C:attention}hand{} before scoring',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_calculus = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'When a {C:showdown_calculus}Mathematic{} card is used,',
                    '{C:attention}duplicate{} a random card in hand',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_versatile_joker_starter = {
                name = 'Versatile Joker',
                text = {
                    'Effect depends of {C:attention}played deck',
                    'You start your {C:attention}next run{} with a {C:attention}random',
                    'joker, consumable and voucher after',
                    '{C:attention}winning{} this run',
                },
                unlock = {
                    'Win a run with any',
                    'deck on at least',
                    '{C:attention}Black Stake{} difficulty',
                }
            },
            j_showdown_joker_variance_authorithy = {
                name = 'Joker Variance Authority',
                text = {
                    'idk',
                },
            },
            j_showdown_banana = {
                name = 'banana',
                text = {
                    '{C:green}#3# in 2{} chance to gain {C:mult}+#1#{} Mult at {C:attention}end of round',
                    'Otherwise, loses {C:mult}-#1#{} Mult',
                    '{C:attention}Destroyed{} when having {C:mult}0{} Mult',
                    '{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)',
                },
                unlock = {
                    'Make Cavendish {C:attention}expire',
                }
            },
            j_showdown_label = {
                name = 'Label',
                text = {
                    'Reroll tags when {C:attention}sold',
                },
                unlock = {
                    'Use {C:attention}12{} tags in one run',
                }
            },
        },
        Other={
            showdown_static = {
                name = "Static",
                text = {
                    "Can't be",
                    "moved",
                },
            },
            showdown_cloud = {
                name = "Cloud",
                text = {
                    "{C:money}$2{} when",
                    "scoring",
                },
            },
            showdown_mushroom = {
                name = "Mushroom",
                text = {
                    "{C:attention}+1{} hand size",
                },
            },
            showdown_flower = {
                name = "Flower",
                text = {
                    "{C:attention}+1{} consumeable",
                    "slot",
                },
            },
            showdown_luigi = {
                name = "Luigi",
                text = {
                    "{X:mult,C:white}X1.5{} Mult",
                },
            },
            showdown_mario = {
                name = "Mario",
                text = {
                    "Retrigger this",
                    "card {C:attention}1{}",
                    "additional time",
                },
            },
            showdown_star = {
                name = "Star",
                text = {
                    "This card",
                    "cannot be",
                    "debuffed",
                },
            },
            counterpart_ranks = {
                name = 'Counterparts',
                text = {
                    'Cards with rank 2.5,',
                    '5.5, 8.5, Butler,',
                    'Princess and Lord',
                }
            },
            undiscovered_mathematic = {
                name = "Not Discovered",
                text = {
                    "Purchase or use",
                    "this card in an",
                    "unseeded run to",
                    "learn what it does"
                }
            },
            p_showdown_calculus_1 = {
                name = 'Calculus Pack',
                text = {
                    'Choose {C:attention}#1#{} of up to',
                    '{C:attention}#2#{C:showdown_calculus} Mathematic{} cards to',
                    'be used immediately'
                }
            },
            p_showdown_calculus_2 = {
                name = 'Calculus Pack',
                text = {
                    'Choose {C:attention}#1#{} of up to',
                    '{C:attention}#2#{C:showdown_calculus} Mathematic{} cards to',
                    'be used immediately'
                }
            },
            p_showdown_calculus_jumbo = {
                name = 'Jumbo Calculus Pack',
                text = {
                    'Choose {C:attention}#1#{} of up to',
                    '{C:attention}#2#{C:showdown_calculus} Mathematic{} cards to',
                    'be used immediately'
                }
            },
            p_showdown_calculus_mega = {
                name = 'Mega Calculus Pack',
                text = {
                    'Choose {C:attention}#1#{} of up to',
                    '{C:attention}#2# {C:showdown_calculus}Mathematic{} cards to',
                    'be used immediately'
                }
            },
            playing_card_zero={
                text={
                    " {C:light_black}#1# of {C:black}Nothing ",
                },
            },
            act_as={
                text={
                    'Act as a #1#',
                },
            },
            default_wild={
                text={
                    'Can be used',
                    'as any suit',
                },
            },
            ['2814_2814'] = {
                name = '2814 - 2 8 1 4',
                text = {
                    'Studio Album',
                    'Released October 15, 2014',
                }
            },
            ['2814_birth_of_a_new_day'] = {
                name = '2814 - Birth of a New Day',
                text = {
                    'Studio Album',
                    'Released January 21, 2015',
                }
            },
            ['2814_rain_temple'] = {
                name = '2814 - Rain Temple',
                text = {
                    'Studio Album',
                    'Released July 26, 2016',
                }
            },
            ['2814_lost_fragments'] = {
                name = '2814 - Lost Fragments',
                text = {
                    'Compilation',
                    'Released July 5, 2019',
                }
            },
            ['2814_pillar_new_sun'] = {
                name = '2814 - Pillar / New Sun',
                text = {
                    'Extended Plays',
                    'Released February 1, 2018',
                }
            },
            ['2814_voyage_embrace'] = {
                name = '2814 - Voyage / Embrace',
                text = {
                    'Extended Plays',
                    'Released September 9, 2020',
                }
            },
        },
        Planet={},
        Spectral={
            c_showdown_mist = {
                name = 'Mist',
                text = {
                    'Converts {C:attention}#1#{} random cards',
                    'into either an {C:attention}Ace{} or a {C:attention}0{}',
                }
            },
            c_showdown_vision = {
                name = 'Vision',
                text = {
                    'All cards held in hand {C:attention}converts{} into',
                    'their higher or equal decimal {C:counterpart_ranks}counterpart{}',
                    'but loses their {C:attention}enhancement{}, {C:attention}edition{}',
                    'or {C:attention}seal{}',
                }
            },
            c_showdown_blue_key = {
                name = 'Blue Key',
                text = {
                    '{C:attention}Unlocks{} the {C:blue,E:1}Blue{E:1} Lock',
                }
            },
        },
        Stake={},
        Tag={
            tag_showdown_green_key = {
                name = "Key Tag",
                text = {
                    '{C:attention}Unlocks{} the {C:green,E:1}Green{E:1} Lock',
                },
            },
            tag_showdown_jean_paul = {
                name = "J-P Tag",
                text = {
                    'hiiiiiii :P',
                },
            },
        },
        Tarot={
            c_showdown_reflection = {
                name = 'The Reflection',
                text = {
                    'Converts up to',
                    '{C:attention}#1#{} selected cards',
                    'to their {C:counterpart_ranks}counterpart{}',
                }
            },
            c_showdown_vessel = {
                name = 'The Vessel',
                text = {
                    'Converts {C:attention}#1#{} selected card',
                    'to a {C:attention}0{} with a random',
                    '{C:attention}enhancement{} or {C:attention}seal{}',
                }
            },
            c_showdown_genie = {
                name = 'The Genie',
                text = {
                    "Creates up to {C:attention}#1#",
                    "random {C:showdown_calculus}Mathematic{} card",
                    "{C:inactive}(Must have room){}",
                }
            },
            c_showdown_lost = {
                name = 'The Lost',
                text = {
                    "Enhances {C:attention}#1#{} selected card",
                    "into a {C:attention}Ghost Card{}"
                }
            },
            c_showdown_angel = {
                name = 'The Angel',
                text = {
                    "Enhances {C:attention}#1#{} selected card",
                    "into a {C:attention}Holy Card{}"
                }
            },
            c_showdown_beast = {
                name = 'The Beast',
                text = {
                    'Converts up to {C:attention}#1#{}',
                    'selected cards to a',
                    'random {C:bunc_fleurons}exotic{}',
                    '{C:counterpart_ranks}counterpart{}',
                }
            },
            c_showdown_red_key_piece_1 = {
                name = 'Red Key Piece',
                text = {
                    '{C:attention}Unlocks{} the...',
                }
            },
            c_showdown_red_key_piece_2 = {
                name = 'Red Key Piece',
                text = {
                    '...{C:red,E:1}Red{E:1} Lock',
                }
            },
        },
        Voucher={
            v_showdown_number = {
                name = 'Number Theory',
                text = {
                    '{C:showdown_calculus}Mathematic{} cards can',
                    'appear in the shop'
                }
            },
            v_showdown_axiom = {
                name = 'Axiom of Infinity',
                text = {
                    '{C:showdown_calculus}Mathematic{} cards can',
                    'be used in boosters'
                },
                unlock = {
                    'Open {C:attention}10{} {C:showdown_calculus}Calculus',
                    '{C:showdown_calculus}Pack{} in one run',
                }
            },
            v_showdown_collatz = {
                name = 'Collatz Conjecture',
                text = {
                    'Cards destroyed by {C:showdown_calculus}mathematic{}',
                    'cards have a {C:green}1 in 3{} chance of',
                    '{C:attention}not{} getting destroyed',
                }
            },
            v_showdown_lui = {
                name = 'L U I',
                text = {
                    'Joker have a {C:green}1 in 4{} chance to',
                    'spawn with a {C:attention}Casino Sticker',
                }
            },
            v_showdown_gi = {
                name = 'G I',
                text = {
                    'Joker {C:attention}always{} spawn',
                    'with a {C:attention}Casino Sticker',
                },
                unlock = {
                    'idk',
                }
            },
        },
        Mathematic = {
            c_showdown_constant = {
                name = 'Constant',
                text = {
                    'Destroy {C:attention}#1#{} selected card',
                    'All cards with {C:attention}equal{} rank will get',
                    'random {C:attention}enhancements{}',
                }
            },
            c_showdown_variable = {
                name = 'Variable',
                text = {
                    'Destroy {C:attention}#1#{} selected cards',
                    'Each card gives between',
                    '{C:money}$#2#{} and {C:money}$#3#',
                }
            },
            c_showdown_function = {
                name = 'Function',
                text = {
                    'Select {C:attention}#1#{} card that will get',
                    'random {C:attention}enhancements{}, then {C:attention}#2#{} random',
                    'cards will be {C:attention}destroyed{}',
                }
            },
            c_showdown_shape = {
                name = 'Shape',
                text = {
                    'Select {C:attention}#1#{} cards that will get',
                    'random {C:attention}editions{}, then {C:attention}#2#{} random',
                    'cards will be {C:attention}destroyed{}',
                }
            },
            c_showdown_vector = {
                name = 'Vector',
                text = {
                    'Destroy {C:attention}#1#{} selected cards',
                    'For each destroyed card, {C:attention}one{} future',
                    'booster will have an {C:attention}additional choice{}',
                    '{C:inactive}(Currently {C:attention}#2#{C:inactive} Boosters){}',
                }
            },
            c_showdown_probability = {
                name = 'Probability',
                text = {
                    'Select up to {C:attention}#1#{} cards, each card has',
                    'a {C:green}#3# in #4#{} chance to be {C:attention}destroyed{}',
                    'Each destroyed card {C:attention}multiply{} the values of',
                    'the leftest joker by {X:attention,C:white}X#2#{}',
                }
            },
            c_showdown_sequence = {
                name = 'Sequence',
                text = {
                    '{C:attention}Destroy{} selected cards and',
                    'upgrade poker hand by {C:attention}#1#{}',
                    'levels',
                }
            },
            c_showdown_operation = {
                name = 'Operation',
                text = {
                    'Destroy {C:attention}#1#{} selected cards',
                    'Creates a card that {C:attention}inherit',
                    'modifiers of the destroyed cards',
                    '{C:attention}Rank{} and {C:attention}Suit{} is {C:attention}randomized',
                }
            },
        },
        Unique = {
            c_showdown_strange_thing = {
                name = 'Strange Thing',
                text = {
                    'Creates a {C:attention}special joker{}',
                    'with a random value',
                    'from {C:attention}#1#{} to {C:attention}#2#{}',
                }
            }
        }
    },
    misc = {
        achievement_descriptions={
            ach_showdown_get_jean_paul = 'Get Jean-Paul',
            ach_showdown_sell_jean_paul = 'Sell Jean-Paul',
            ach_showdown_jean_paul_tag = 'Get Jean-Paul with the J-P Tag',
            ach_showdown_jimbodia = 'Get Ultimate Joker',
            ach_showdown_chains = 'Get Unshackled Joker',
            ach_showdown_versatility = 'Get Versatile Joker on every deck at least once',
            ach_showdown_blued = 'Get Blue',
            ach_showdown_metal_cap = 'Get the maximum discount with What a Steel!',
            ach_showdown_cronch = 'eat the banana',
            ach_showdown_green_deck_home = 'Have Red Coins and Money Cutter at the same time',
        },
        achievement_names={
            ach_showdown_get_jean_paul = ':3',
            ach_showdown_sell_jean_paul = ':(',
            ach_showdown_jean_paul_tag = ':D',
            ach_showdown_jimbodia = 'Jimbodia',
            ach_showdown_chains = 'Free from the chains',
            ach_showdown_versatility = 'Versatility',
            ach_showdown_blued = 'You\'ve been Blue\'d!',
            ach_showdown_metal_cap = 'Metal Cap',
            ach_showdown_cronch = 'cronch',
            ach_showdown_green_deck_home = 'We have Green Deck at home',
        },
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={
            k_showdown_calculus_pack = 'Calculus Pack',
            k_showdown_final = 'Final',
            k_BAM = "BAM!",
            k_strainer_broke = "Broken!",
            k_showdown_mysterious_tarot = 'Tarot?',
            k_unlocked = 'Unlocked!',
            k_mathematic = "Mathematic",
            k_plus_math="+1 Mathematic",
            k_downgrade_ex="Downgrade!",
            k_can_reroll="Can reroll",
            k_cannot_reroll="Cannnot reroll",
            b_mathematic_cards = "Mathematic Cards",
            b_pull = "PULL",
        },
        high_scores={},
        labels={
            showdown_static = "Static",
            showdown_cloud = "Cloud",
            showdown_mushroom = "Mushroom",
            showdown_flower = "Flower",
            showdown_luigi = "Luigi",
            showdown_mario = "Mario",
            showdown_star = "Star",
        },
        poker_hand_descriptions={},
        poker_hands={},
        quips={
            end_of_round_1 = {
                'You did it!',
            },
            end_of_round_2 = {
                'Congrats!',
            },
            end_of_round_3 = {
                'You won\'t fail',
                'next time, I\'m',
                'sure.',
            },
            end_of_round_4 = {
                'Aaaaaand you',
                'won again!',
            },
            end_of_round_5 = {
                'You did it',
                'again!',
            },
            end_of_round_6 = {
                'It amaze me',
                'every time.',
            },
            end_of_round_7 = {
                'You were too',
                'strong for',
                'this blind!',
            },
            end_of_round_8 = {
                'And one more!',
            },
            end_of_round_9 = {
                'gg',
            },
            end_of_round_10 = {
                'ez',
            },
            open_booster_1 = {
                'What will there',
                'be in this one?',
            },
            open_booster_2 = {
                'What are you going',
                'to choose?',
            },
            open_booster_3 = {
                'So much',
                'possibilities!',
            },
            open_booster_4 = {
                'Awwww, look at',
                'the mess you made.',
            },
            open_booster_5 = {
                'Which card are',
                'you going to choose?',
            },
            open_booster_6 = {
                'Wowie! Cards!',
            },
            open_booster_7 = {
                'So this is where',
                'cards come from...',
            },
            open_booster_8 = {
                'Tear that',
                'booster up!',
            },
            open_booster_9 = {
                'kards',
            },
            open_booster_10 = {
                'What kind of',
                'booster did',
                'you open?',
            },
            buying_card_1 = {
                'One more card.',
            },
            buying_card_2 = {
                'Welcome to',
                'the deck.',
            },
            buying_card_3 = {
                'Was this card',
                'expensive?',
            },
            buying_card_4 = {
                'I hope it has',
                'an edition.',
            },
            buying_card_5 = {
                'I hope it has',
                'an enhancement.',
            },
            buying_card_6 = {
                'May this one and',
                'only card save',
                'your entire run.',
            },
            buying_card_7 = {
                'You like to',
                'buy things',
                'don\'t you?',
            },
            buying_card_8 = {
                'Less money,',
                'more cards.',
            },
            buying_card_9 = {
                'You\'re giving',
                'it a home! How',
                'nice of you!',
            },
            buying_card_10 = {
                'Is it a joker?',
            },
            selling_card_1 = {
                'Byyyyyyye!',
            },
            selling_card_2 = {
                'I hope i\'ll',
                'see you again!',
            },
            selling_card_3 = {
                'This card was',
                'useful, right?',
            },
            selling_card_4 = {
                'Less cards,',
                'more money.',
            },
            selling_card_5 = {
                'I hope you',
                'won\'t sell',
                'me...',
            },
            selling_card_6 = {
                'Do you believe in',
                'card afterlife?',
            },
            selling_card_7 = {
                'mmhhmhmhhmhmmh',
                'money',
            },
            selling_card_8 = {
                'Goodbye!',
            },
            selling_card_9 = {
                'See ya later!',
            },
            selling_card_10 = {
                'I miss him',
                'already...',
            },
            reroll_shop_1 = {
                'Is it better',
                'this time?',
            },
            reroll_shop_2 = {
                'Did you find',
                'what you\'re',
                'looking for?',
            },
            reroll_shop_3 = {
                'Did you got a',
                'tarot card?',
            },
            reroll_shop_4 = {
                'You don\'t spend',
                'all your money',
                'on these rolls,',
                'right?',
            },
            reroll_shop_5 = {
                'LET\'S GO',
                'GAMBLING!',
            },
            reroll_shop_6 = {
                'May luck be on',
                'your side.',
            },
            reroll_shop_7 = {
                'What did you',
                'got this time?',
            },
            reroll_shop_8 = {
                'RE-ROLL!',
                'RE-ROLL!',
                'RE-ROLL!',
            },
            reroll_shop_9 = {
                'There are so',
                'much cards here!',
            },
            reroll_shop_10 = {
                'This shop must be',
                'enormous for it to',
                'have this much cards!',
            },
            shop_jokers_1 = {
                'Hello!',
            },
            shop_jokers_2 = {
                'Ooooooooo',
                'You can buy',
                'me for 2$!',
            },
            shop_jokers_3 = {
                'Did your mama told',
                'you that it\'s',
                'rude to stare?',
            },
            shop_jokers_4 = {
                'buy me buy me buy me',
                'buy me buy me buy me',
                'buy me buy me buy me',
                'buy me buy me buy me',
            },
            shop_jokers_5 = {
                'Oh wow, so much',
                'stuff here!',
            },
            shop_jokers_6 = {
                'This spot is',
                'quite comfortable.',
            },
            shop_jokers_7 = {
                'Do you want',
                'to buy me?',
            },
            shop_jokers_8 = {
                'You can speak',
                'too???',
            },
            shop_jokers_9 = {
                'How did I',
                'got here?',
            },
            shop_jokers_10 = {
                'Did you know that',
                'peas are primarily',
                'composed of peas?',
            },
            buying_self_1 = {
                'Thank you',
                'so much.',
            },
            buying_self_2 = {
                'We\'re gonna be',
                'best friend!',
            },
            buying_self_3 = {
                'Is it weird to',
                'say that I love',
                'you already?',
            },
            buying_self_4 = {
                '^^',
            },
            buying_self_5 = {
                'You\'re my',
                'bff now.',
            },
            buying_self_6 = {
                'Ooooooh, I',
                'always wanted',
                'to be up here!',
            },
            buying_self_7 = {
                'I promess, I\'m',
                'no scam!',
            },
            buying_self_8 = {
                'Where did your',
                'money go? :(',
            },
            buying_self_9 = {
                'Was I',
                'in sale?',
            },
            buying_self_10 = {
                'Me?',
            },
            buying_other_self_1 = {
                'ANOTHER ME?',
            },
            buying_other_self_2 = {
                'I guess we makin',
                'Jean-Pauls now.',
            },
            buying_other_self_3 = {
                'So this is what',
                'they call the',
                'multiverse.',
            },
            buying_other_self_4 = {
                '^^',
            },
            buying_other_self_5 = {
                'Hey, I recognize',
                'that face!',
            },
            buying_other_self_6 = {
                '',
            },
            buying_other_self_7 = {
                '',
            },
            buying_other_self_8 = {
                '',
            },
            buying_other_self_9 = {
                '',
            },
            buying_other_self_10 = {
                '',
            },
            selling_other_self_1 = {
                'Did you just...',
            },
            selling_other_self_2 = {
                'You could have done',
                'that while i weren\'t',
                'looking!',
            },
            selling_other_self_3 = {
                'Goodbye me...',
            },
            selling_other_self_4 = {
                '',
            },
            selling_other_self_5 = {
                '',
            },
            selling_other_self_6 = {
                '',
            },
            selling_other_self_7 = {
                '',
            },
            selling_other_self_8 = {
                '',
            },
            selling_other_self_9 = {
                '',
            },
            selling_other_self_10 = {
                '',
            },
            ending_shop_1 = {
                'Did your build',
                'got stronger?',
            },
            ending_shop_2 = {
                'Do you have any',
                'ibuprofene? I got',
                'a headache.',
            },
            ending_shop_3 = {
                'Oh man, I sure hope',
                'these blinds won\'t',
                'kill your run.',
            },
            ending_shop_4 = {
                'Will you take',
                'some tags?',
            },
            ending_shop_5 = {
                'Ending the',
                'shop already?',
            },
            ending_shop_6 = {
                '',
            },
            ending_shop_7 = {
                '',
            },
            ending_shop_8 = {
                '',
            },
            ending_shop_9 = {
                '',
            },
            ending_shop_10 = {
                '',
            },
            skip_blind_1 = {
                'I FUCKING LOVE',
                'TAGS!!!!!!!!',
            },
            skip_blind_2 = {
                'So you like',
                'pulling off some',
                'risky moves...',
            },
            skip_blind_3 = {
                'I hope it was',
                'worth it!',
            },
            skip_blind_4 = {
                'A tag? In',
                'this economy?',
            },
            skip_blind_5 = {
                '',
            },
            skip_blind_6 = {
                '',
            },
            skip_blind_7 = {
                '',
            },
            skip_blind_8 = {
                '',
            },
            skip_blind_9 = {
                '',
            },
            skip_blind_10 = {
                '',
            },
            skipping_booster_1 = {
                'I hope you have',
                'a red card.',
            },
            skipping_booster_2 = {
                'You\'re skipping',
                'a booster?.',
            },
            skipping_booster_3 = {
                'Was it',
                'disappointing?',
            },
            skipping_booster_4 = {
                '',
            },
            skipping_booster_5 = {
                '',
            },
            skipping_booster_6 = {
                '',
            },
            skipping_booster_7 = {
                '',
            },
            skipping_booster_8 = {
                '',
            },
            skipping_booster_9 = {
                '',
            },
            skipping_booster_10 = {
                '',
            },
            setting_blind_1 = {
                'Good luck!',
            },
            setting_blind_2 = {
                'You\'ll beat',
                'this blind!',
            },
            setting_blind_3 = {
                'Have fun!',
            },
            setting_blind_4 = {
                'Is your build is',
                'still building?',
            },
            setting_blind_5 = {
                '',
            },
            setting_blind_6 = {
                '',
            },
            setting_blind_7 = {
                '',
            },
            setting_blind_8 = {
                '',
            },
            setting_blind_9 = {
                '',
            },
            setting_blind_10 = {
                '',
            },
            using_tarot_1 = {
                'Ooooooh tarot',
                'card!',
            },
            using_tarot_2 = {
                'Are you shaping',
                'your deck?',
            },
            using_tarot_3 = {
                'Did it gave',
                'you money?',
            },
            using_tarot_4 = {
                'I love tarot',
                'cards :O',
            },
            using_tarot_5 = {
                'Again! Do',
                'it again!',
            },
            using_tarot_6 = {
                'Sometime I',
                'dream about',
                'these...',
            },
            using_tarot_7 = {
                'Are there reverse',
                'tarot cards?',
            },
            using_tarot_8 = {
                'Did you know?',
                'tarot card pretty',
            },
            using_tarot_9 = {
                'I wonder what',
                'these taste like...',
            },
            using_tarot_10 = {
                'Can you tell me',
                'my future please?',
            },
            using_tarot_11 = {
                'ZA WARUDO',
            },
            using_planet_1 = {
                'Hand upgrade!',
            },
            using_planet_2 = {
                'I love space!',
            },
            using_planet_3 = {
                'Yeah planets are',
                'cool, but did you',
                'know about quasars?',
            },
            using_planet_4 = {
                'Did you know Black',
                'Hole upgrades your',
                'secrets hands, even',
                'if not unlocked?',
            },
            using_planet_5 = {
                'I hope you have',
                'Constellation.',
            },
            using_planet_6 = {
                'We are mere specks',
                'of dust in an',
                'infinite void',
                'deprived of feelings...',
                
            },
            using_planet_7 = {
                'fking {C:blue}BLUE{}',
            },
            using_planet_8 = {
                '',
            },
            using_planet_9 = {
                '',
            },
            using_planet_10 = {
                '',
            },
            using_spectral_1 = {
                'Oh, those are',
                'powerful!',
            },
            using_spectral_2 = {
                'Do you believe',
                'in ghosts and',
                'other spirits?',
            },
            using_spectral_3 = {
                'Ooooooh, the',
                'surnatural.',
            },
            using_spectral_4 = {
                'No I don\'t play',
                'Ouija, it\'s not',
                'even a game!',
            },
            using_spectral_5 = {
                'Are you doing',
                'exorcism?',
            },
            using_spectral_6 = {
                'Jimbo\'s ghost',
                'will haunt you.',
            },
            using_spectral_7 = {
                'BOO',
            },
            using_spectral_8 = {
                'Would you like',
                'to see a magic',
                'trick?',
            },
            using_spectral_9 = {
                '',
            },
            using_spectral_10 = {
                '',
            },
            using_mathematic_1 = {
                'All alone doing',
                'math by yourself?',
                'God, me too.',
            },
            using_mathematic_2 = {
                'y = ax + b',
            },
            using_mathematic_3 = {
                'Did you know about',
                'DeMoivre\'s Theorem?',
                'Yeah me neither.',
            },
            using_mathematic_4 = {
                'Do you have a',
                'favourite number?',
            },
            using_mathematic_5 = {
                '',
            },
            using_mathematic_6 = {
                '',
            },
            using_mathematic_7 = {
                '',
            },
            using_mathematic_8 = {
                '',
            },
            using_mathematic_9 = {
                '',
            },
            using_mathematic_10 = {
                '',
            },
            using_code_1 = {
                'Beep boop',
            },
            using_code_2 = {
                'Do you know about',
                'machine learning?',
            },
            using_code_3 = {
                '01001000',
                '01000101',
                '01001100',
                '01001100',
                '01001111',
            },
            using_code_4 = {
                'We\'re in the',
                'Matrix now??',
            },
            using_code_5 = {
                'local function hi()',
                '   print(\'hello!\')',
                'end',
            },
            using_code_6 = {
                'Did you know?',
                'Code cards are',
                'made with code.',
            },
            using_code_7 = {
                '',
            },
            using_code_8 = {
                '',
            },
            using_code_9 = {
                '',
            },
            using_code_10 = {
                '',
            },
            using_unknown_1 = {
                'What is this?',
            },
            using_unknown_2 = {
                'I\'ve never',
                'seen this kind',
                'of card...',
            },
            using_unknown_3 = {
                'What are',
                'you using?',
            },
            using_unknown_4 = {
                'What is',
                'that thing?',
            },
            using_unknown_5 = {
                'Do you know',
                'what this does?',
            },
            using_unknown_6 = {
                'Tell me more about',
                'this card...',
            },
            using_unknown_7 = {
                'What are',
                'these for?',
            },
            using_unknown_8 = {
                '?????',
            },
            using_unknown_9 = {
                'No, that\'s not',
                'a tarot card...',
            },
            using_unknown_10 = {
                'Huh???',
            },
            in_blind_1 = {
                'Are you waiting',
                'for something?',
            },
            in_blind_2 = {
                'What are you',
                'doing with',
                'your cards?',
            },
            in_blind_3 = {
                '',
            },
            in_blind_4 = {
                '',
            },
            in_blind_5 = {
                '',
            },
            in_blind_6 = {
                '',
            },
            in_blind_7 = {
                '',
            },
            in_blind_8 = {
                '',
            },
            in_blind_9 = {
                '',
            },
            in_blind_10 = {
                '',
            },
            in_booster_1 = {
                'Are you looking',
                'at the cards?',
            },
            in_booster_2 = {
                '',
            },
            in_booster_3 = {
                '',
            },
            in_booster_4 = {
                '',
            },
            in_booster_5 = {
                '',
            },
            in_booster_6 = {
                '',
            },
            in_booster_7 = {
                '',
            },
            in_booster_8 = {
                '',
            },
            in_booster_9 = {
                '',
            },
            in_booster_10 = {
                '',
            },
            random_1 = {
                ':3',
            },
            random_2 = {
                'Sometimes, I',
                'dream about',
                'cheese...',
            },
            random_3 = {
                'Why did the',
                'chicken crossed',
                'the road?',
            },
            random_4 = {
                'Smells like',
                'bread in here.',
            },
            random_5 = {
                '*does a cool',
                'backflip*',
            },
            random_6 = {
                'I could put the',
                'entire script of',
                'the bee movie here.',
            },
            random_7 = {
                'I love',
                'Balatro',
            },
            random_8 = {
                'fish',
            },
            random_9 = {
                'I have a',
                'feeling of',
                'déjà vu...',
            },
            random_10 = {
                '{E:1}This text',
                '{E:1}is moving.',
            },
            random_11 = {
                'cocainer',
            },
            random_12 = {
                'am hungy',
            },
            random_13 = {
                'Why did the',
                'chicken crossed',
                'the road?',
            },
            random_14 = {
                'text',
            },
            random_15 = {
                'Imagine 2 onions.',
                'Heck, imagine 3.',
                'onions.',
            },
            random_16 = {
                'YOU SHOULD',
                'LOVE YOURSELF',
                'NOW!',
            },
            random_17 = {
                'Do you think?',
                'I don\'t.',
            },
            random_18 = {
                'blleblbelblebllebe :Þ',
            },
            random_19 = {
                'cheddar',
            },
            random_20 = {
                'I love',
                'cheese.',
            },
            --[[
            _1 = {
                '',
            },
            _2 = {
                '',
            },
            _3 = {
                '',
            },
            _4 = {
                '',
            },
            _5 = {
                '',
            },
            _6 = {
                '',
            },
            _7 = {
                '',
            },
            _8 = {
                '',
            },
            _9 = {
                '',
            },
            _10 = {
                '',
            },
            ]]--
        },
        ranks={
            ['showdown_2.5'] = '2.5',
            ['showdown_5.5'] = '5.5',
            ['showdown_8.5'] = '8.5',
            showdown_Butler = 'Butler',
            showdown_Princess = 'Princess',
            showdown_Lord = 'Lord',
            showdown_Zero = '0',
        },
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={
            a_chips_mult = '+#1# Chips, +#2# Mult',
            a_xchips="X#1# Chips",
        },
        v_text={},
    },
}