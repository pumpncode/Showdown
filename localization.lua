return  {
    dictionary = {
        ['en-us'] = {
            mysterious_tarot = 'Tarot?',
        }
    },

    counterpart_ranks = {
        ['en-us'] = {
            ['name'] = 'Counterparts',
            ['text'] = {
                [1] = 'Cards with rank 2.5,',
                [2] = '5.5, 8.5, Butler,',
                [3] = 'Princess and Lord',
            }
        }
    },

    ---- Decks Skins
    
    jean_paul = {
        ['en-us'] = 'Jean-Paul'
    },

    ---- Decks
    
    mirror_deck = {
        ['en-us'] = {
            ['name'] = 'Mirror Deck',
            ['text'] = {
                [1] = 'All faces, 8s, 5s and',
                [2] = '2s are replaced',
                [3] = 'by their {C:counterpart_ranks,T:counterpart_ranks}counterpart{}',
                [4] = 'Aces are replaced by 0s',
            }
        }
    },
    calculus_deck = {
        ['en-us'] = {
            ['name'] = 'Calculus Deck',
            ['text'] = {
                [1] = 'First booster in the shop is',
                [2] = 'always a {C:showdown_mathematic}Calculus Booster{}',
                [3] = 'You start with a {C:attention}Genie{} tarot',
                [4] = 'card and with {C:attention}Number Theory{}',
            }
        }
    },

    ---- Ranks
    
    two_half = {
        ['en-us'] = {
            ['name'] = '2.5',
            ['label'] = {
                [1] = 'Counts as',
                [2] = 'a 2',
            }
        }
    },
    five_half = {
        ['en-us'] = {
            ['name'] = '5.5',
            ['label'] = {
                [1] = 'Counts as',
                [2] = 'a 5',
            }
        }
    },
    eight_half = {
        ['en-us'] = {
            ['name'] = '8.5',
            ['label'] = {
                [1] = 'Counts as',
                [2] = 'a 8',
            }
        }
    },
    butler = {
        ['en-us'] = {
            ['name'] = 'Butler',
            ['label'] = {
                [1] = 'Counts as',
                [2] = 'a Jack',
            }
        }
    },
    princess = {
        ['en-us'] = {
            ['name'] = 'Princess',
            ['label'] = {
                [1] = 'Counts as',
                [2] = 'a Queen',
            }
        }
    },
    lord = {
        ['en-us'] = {
            ['name'] = 'Lord',
            ['label'] = {
                [1] = 'Counts as',
                [2] = 'a King',
            }
        }
    },
    zero = {
        ['en-us'] = {
            ['name'] = '0',
            ['text'] = {
                [1] = 'Counts as',
                [2] = 'any suit',
            }
        }
    },

    ---- Consumables

    -- Consumable Types

    mathematic = {
        ['en-us'] = {
            ['name'] = 'Mathematic',
            ['collection'] = 'Mathematic Cards',
            ['undiscovered'] = {
                ['name'] = 'Not Discovered',
                ['text'] = {
                    [1] = 'Purchase or use',
                    [2] = 'this card in an',
                    [3] = 'unseeded run to',
                    [4] = 'learn what it does',
                }
            }
        }
    },

    test = {
        ['en-us'] = {
            ['name'] = 'test',
            ['collection'] = 'test Cards',
            ['undiscovered'] = {
                ['name'] = 'Not Discovered',
                ['text'] = {
                    [1] = 'Purchase or use',
                    [2] = 'this card in an',
                    [3] = 'unseeded run to',
                    [4] = 'learn what it does',
                }
            }
        }
    },

    -- Tarots

    reflection = {
        ['en-us'] = {
            ['name'] = 'The Reflection',
            ['text'] = {
                [1] = 'Converts up to',
                [2] = '{C:attention}#1#{} selected cards',
                [3] = 'to their {C:counterpart_ranks}counterpart{}',
            }
        }
    },
    vessel = {
        ['en-us'] = {
            ['name'] = 'The Vessel',
            ['text'] = {
                [1] = 'Converts {C:attention}#1#{} selected card',
                [2] = 'to a {C:attention}0{} with a random',
                [3] = '{C:attention}enhancement{} or {C:attention}seal{}',
            }
        }
    },
    genie = {
        ['en-us'] = {
            ['name'] = 'The Genie',
            ['text'] = {
                [1] = "Creates up to {C:attention}#1#",
                [2] = "random {C:showdown_mathematic}Mathematic{} card",
                [3] = "{C:inactive}(Must have room){}",
            }
        }
    },
    lost = {
        ['en-us'] = {
            ['name'] = 'The Lost',
            ['text'] = {
                [1] = "Enhances {C:attention}#1#{} selected card",
                [2] = "into {C:attention}Ghost Cards{}"
            }
        }
    },
    angel = {
        ['en-us'] = {
            ['name'] = 'The Angel',
            ['text'] = {
                [1] = "Enhances {C:attention}#1#{} selected card",
                [2] = "into {C:attention}Holy Cards{}"
            }
        }
    },
    beast = { -- Requires Bunco
        ['en-us'] = {
            ['name'] = 'The Beast',
            ['text'] = {
                [1] = 'Converts up to {C:attention}#1#{}',
                [2] = 'selected cards to a',
                [3] = 'random {C:bunc_fleurons}exotic{}',
                [4] = '{C:counterpart_ranks}counterpart{}',
            }
        }
    },

    -- Spectrals

    mist = {
        ['en-us'] = {
            ['name'] = 'Mist',
            ['text'] = {
                [1] = 'Converts {C:attention}#1#{} random cards',
                [2] = 'into either an {C:attention}Ace{} or a {C:attention}0{}',
            }
        }
    },
    vision = {
        ['en-us'] = {
            ['name'] = 'Vision',
            ['text'] = {
                [1] = 'All cards held in hand {C:attention}converts{} into',
                [2] = 'their higher or equal decimal {C:counterpart_ranks}counterpart{}',
                [3] = 'but loses their {C:attention}enhancement{}, {C:attention}edition{}',
                [4] = 'or {C:attention}seal{}',
            }
        }
    },

    -- Mathematics

    constant = {
        ['en-us'] = {
            ['name'] = 'Constant',
            ['text'] = {
                [1] = 'Select {C:attention}#1#{} card that will get {C:attention}destroyed{}',
                [2] = 'All cards with {C:attention}equal{} rank will get',
                [3] = 'random {C:attention}enhancements{}',
            }
        }
    },
    variable = {
        ['en-us'] = {
            ['name'] = 'Variable',
            ['text'] = {
                [1] = 'Select up to {C:attention}#1#{} cards that will get {C:attention}destroyed{}',
                [2] = 'and creates a {C:attention}joker{} based on {C:attention}ranks{} and',
                [3] = '{C:attention}amount{} of cards destroyed',
            }
        }
    },
    functio = {
        ['en-us'] = {
            ['name'] = 'Function',
            ['text'] = {
                [1] = 'Select {C:attention}#1#{} cards that will get',
                [2] = 'random {C:attention}enhancements{}, then {C:attention}1{} random',
                [3] = 'cards will be {C:attention}destroyed{}',
            }
        }
    },
    shape = {
        ['en-us'] = {
            ['name'] = 'Shape',
            ['text'] = {
                [1] = 'Select {C:attention}#1#{} cards that will get',
                [2] = 'random {C:attention}editions{}, then {C:attention}2{} random',
                [3] = 'cards will be {C:attention}destroyed{}',
            }
        }
    },
    vector = {
        ['en-us'] = {
            ['name'] = 'Vector',
            ['text'] = {
                [1] = 'Select up to {C:attention}#1#{} cards that will get {C:attention}destroyed{}',
                [2] = 'For each destroyed card, {C:attention}one{} future booster',
                [3] = 'will have an {C:attention}additional choice{}',
                [4] = '{C:inactive}(currently {C:attention}#2#{C:inactive} boosters){}',
            }
        }
    },
    probability = {
        ['en-us'] = {
            ['name'] = 'Probability',
            ['text'] = {
                [1] = 'Select up to {C:attention}#1#{} cards, each card has',
                [2] = 'a {C:green}1 in 3{} chance to be {C:attention}destroyed{}',
                [3] = 'Each destroyed card {C:attention}multiply{} the values of',
                [4] = 'the leftest joker by {X:attention,C:white}X#2#{}',
            }
        }
    },
    sequence = {
        ['en-us'] = {
            ['name'] = 'Sequence',
            ['text'] = {
                [1] = '{C:attention}Destroy{} selected cards and',
                [2] = 'upgrade poker hand by {C:attention}#1#{}',
                [3] = 'levels',
            }
        }
    },
    operation = {
        ['en-us'] = {
            ['name'] = 'Operation',
            ['text'] = {
                [1] = 'Destroy {C:attention}#1#{} selected cards and create a card',
                [2] = 'that {C:attention}inherit{} the modifiers of the destroyed cards',
                [3] = 'The {C:attention}rank{} and {C:attention}suit{} of the card is {C:attention}randomized{}',
            }
        }
    },

    -- Unique (Requires Cryptid)

    strange = {
        ['en-us'] = {
            ['name'] = 'Strange Thing',
            ['text'] = {
                [1] = 'Creates a {C:attention}special joker{}',
                [2] = 'with a random value',
                [3] = 'from {C:attention}#1#{} to {C:attention}#2#{}',
            }
        }
    },

    ---- Booster Packs
    
    calculus = {
        ['en-us'] = {
            ['group_name'] = 'Calculus Pack',
            ['name'] = 'Calculus Pack',
            ['text'] = {
                [1] = 'Choose {C:attention}#1#{} of up to',
                [2] = '{C:attention}#2#{C:showdown_mathematic} Mathematic{} cards to',
                [3] = 'be used immediately'
            }
        }
    },
    calculus_jumbo = {
        ['en-us'] = {
            ['group_name'] = 'Calculus Pack',
            ['name'] = 'Jumbo Calculus Pack',
            ['text'] = {
                [1] = 'Choose {C:attention}#1#{} of up to',
                [2] = '{C:attention}#2#{C:showdown_mathematic} Mathematic{} cards to',
                [3] = 'be used immediately'
            }
        }
    },
    calculus_mega = {
        ['en-us'] = {
            ['group_name'] = 'Calculus Pack',
            ['name'] = 'Mega Calculus Pack',
            ['text'] = {
                [1] = 'Choose {C:attention}#1#{} of up to',
                [2] = '{C:attention}#2# {C:showdown_mathematic}Mathematic{} cards to',
                [3] = 'be used immediately'
            }
        }
    },

    ---- Vouchers

    irrational = {
        ['en-us'] = {
            ['name'] = 'Irrational Numbers',
            ['text'] = {
                [1] = 'idk',
            }
        }
    },
    transcendant = {
        ['en-us'] = {
            ['name'] = 'Transcendant Numbers',
            ['text'] = {
                [1] = 'idk',
            },
            ['unlock'] = {
                [1] = 'idk',
            }
        }
    },
    complex = {
        ['en-us'] = {
            ['name'] = 'Complex Numbers',
            ['text'] = {
                [1] = 'idk',
            }
        }
    },

    numberTheory = {
        ['en-us'] = {
            ['name'] = 'Number Theory',
            ['text'] = {
                [1] = '{C:showdown_mathematic}Mathematic{} cards can',
                [2] = 'appear in the shop'
            }
        }
    },
    axiomInfinity = {
        ['en-us'] = {
            ['name'] = 'Axiom of Infinity',
            ['text'] = {
                [1] = 'idk',
            },
            ['unlock'] = {
                [1] = 'idk',
            }
        }
    },
    collatz = {
        ['en-us'] = {
            ['name'] = 'Collatz Conjecture',
            ['text'] = {
                [1] = 'Cards destroyed by {C:showdown_mathematic}mathematic{}',
                [2] = 'cards have a {C:green}1 in 3{} chance of',
                [3] = '{C:attention}not{} getting destroyed',
            }
        }
    },

    ---- Enhancements
    
    ghost = {
        ['en-us'] = {
            ['name'] = 'Ghost Card',
            ['text'] = {
                [1] = '{X:mult,C:white}X#1#{} Mult and {X:chips,C:white}X#2#{} Chips',
                [2] = '{C:green}1 in #3#{} chance to disappear',
                [3] = 'after all scoring is finished',
            }
        }
    },
    holy = {
        ['en-us'] = {
            ['name'] = 'Holy Card',
            ['text'] = {
                [1] = '{X:mult,C:white}X#1#{} Mult',
                [2] = 'Gains {X:mult,C:white}X#2#{} Mult',
                [3] = 'when scored',
            }
        }
    },

    ---- Jokers

    pinpoint = {
        ['en-us'] = {
            ['name'] = 'Pinpoint',
            ['text'] = {
                [1] = '{X:chips,C:white}X#1#{} Chips for each {C:attention}0{} in hand',
            },
            ['unlock'] = {
                [1] = 'Play a {C:attention}Five of a Kind{}',
                [2] = 'that contains only',
                [3] = '{C:attention}0{} cards',
            }
        }
    },
    motherDaughter = {
        ['en-us'] = {
            ['name'] = 'Like Mother Like Daughter',
            ['text'] = {
                [1] = '{X:mult,C:white}X#1#{} for each pair of',
                [2] = 'Princess scored and Queen in hand',
            },
            ['unlock'] = {
                [1] = 'Play a double pair hand',
                [2] = 'that contains {C:attention}Queens{}',
                [3] = 'and {C:attention}Princesses{}',
            }
        }
    },
    crouton = {
        ['en-us'] = {
            ['name'] = 'Crouton',
            ['text'] = {
                [1] = '{X:mult,C:white}X#1#{} Mult for each',
                [2] = 'card held in hand',
            },
            ['unlock'] = {
                [1] = '{E:1,s:1.3}?????'
            }
        }
    },
    infection = { -- Requires Cryptid
        ['en-us'] = {
            ['name'] = 'Infection',
            ['text'] = {
                [1] = '{X:mult,C:white}X#1#{} Mult, {C:red}self-destruct{}',
                [2] = 'future cards in shop and boosters can be {C:attention}replaced{}',
                [3] = 'by {C:attention}Strange Thing{}',
                [4] = 'future {C:attention}Strange Thing{} values are {C:attention}doubled{}',
            }
        }
    },
    mathTeacher = {
        ['en-us'] = {
            ['name'] = 'Math Teacher',
            ['text'] = {
                [1] = 'This Joker gains {C:chips}+#2#{} Chips',
                [2] = 'for each {C:counterpart_ranks}counterpart{} card scored',
                [3] = '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)',
            },
            ['unlock'] = {
                [1] = 'Play a {C:attention}Three of a Kind{}',
                [2] = 'with only {C:counterpart_ranks}counterpart{}',
                [3] = 'cards',
            }
        }
    },
    gruyere = {
        ['en-us'] = {
            ['name'] = 'Gruyère',
            ['text'] = {
                [1] = 'This Joker gains {C:mult}+#2#{} Mult',
                [2] = 'for each {C:attention}0{} scored',
                [3] = '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)',
            }
        }
    },
    mirror = {
        ['en-us'] = {
            ['name'] = 'Mirror',
            ['text'] = {
                [1] = 'All {C:counterpart_ranks}counterpart{} and {C:attention}0{} card',
                [2] = 'are {C:attention}retriggered{}',
            }
        }
    },
    crime_scene = {
        ['en-us'] = {
            ['name'] = 'Crime Scene',
            ['text'] = {
                [1] = 'This Joker gains {X:mult,C:white}X#2#{} Mult',
                [2] = 'for each {C:attention}debuffed{} card scored',
                [3] = '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
            },
            ['unlock'] = {
                [1] = 'Play a hand with',
                [2] = '{C:attention}5{} debuffed card',
            }
        }
    },
    ping_pong = {
        ['en-us'] = {
            ['name'] = 'Ping Pong',
            ['text'] = {
                [1] = 'Scored {C:attention}Aces{} becomes {C:attention}7s{}',
                [2] = 'Scored {C:attention}7s{} becomes {C:attention}Aces{}',
            }
        }
    },
    color_splash = {
        ['en-us'] = {
            ['name'] = 'Color Splash',
            ['text'] = {
                [1] = 'Unscored card get',
                [2] = 'a {C:attention}random{} suit',
            },
            ['unlock'] = {
                [1] = 'Have 4 {C:attention}unscored{} card',
                [2] = 'of {C:attention}different{} suits',
            }
        }
    },
    blue = {
        ['en-us'] = {
            ['name'] = 'Blue',
            ['text'] = {
                [1] = '{C:chips}+1{} Chip'
            },
            ['unlock'] = {
                [1] = 'Score less than {C:attention}10{}',
                [2] = 'chips in one hand',
            }
        }
    },
    spotted_joker = {
        ['en-us'] = {
            ['name'] = 'Spotted Joker',
            ['text'] = {
                [1] = 'Played {C:attention}0{} card gives {C:chips}+#1#{} Chips',
                [2] = 'when scored and add',
                [3] = '{C:chips}+#2#{} Chips to this joker',
            }
        }
    },
    golden_roulette = {
        ['en-us'] = {
            ['name'] = 'Golden Roulette',
            ['text'] = {
                [1] = 'Has a {C:green}5 in 6{} chance to give',
                [2] = '{C:money}#1#${} at the end of each',
                [3] = 'round, otherwise {C:red}self-destruct{}',
            }
        }
    },
    bacteria = {
        ['en-us'] = {
            ['name'] = 'Bacteria',
            ['text'] = {
                [1] = 'If hand contains a {C:attention}flush{} and',
                [2] = '{C:attention}at least one 0{}, convert',
                [3] = 'a {C:attention}non 0{} card to a {C:attention}0{}',
            }
        }
    },
    empty_joker = {
        ['en-us'] = {
            ['name'] = 'Empty Joker',
            ['text'] = {
                [1] = '{C:mult}+#1#{} if hand contains a {C:attention}0{}',
            }
        }
    },
    baby_jimbo = {
        ['en-us'] = {
            ['name'] = 'Baby Jimbo',
            ['text'] = {
                [1] = 'Creates a {C:dark_edition}Negative{} {C:spectral}Spectral{} card',
                [2] = 'when a joker is {C:attention}destroyed{}',
            },
            ['unlock'] = {
                [1] = 'Have {C:attention}two times{} your maximum',
                [2] = 'amount of {C:attention}consumables{}',
            }
        }
    },
    parmesan = {
        ['en-us'] = {
            ['name'] = 'Parmesan',
            ['text'] = {
                [1] = 'Every played {C:attention}card{} permanently',
                [2] = 'gains {C:chips}chips{} equal to the {C:attention}lowest{}',
                [3] = 'played rank when scored',
            }
        }
    },
    chaos_card = {
        ['en-us'] = {
            ['name'] = 'Chaos Card',
            ['text'] = {
                [1] = 'After scoring, {C:attention}rank{} and {C:attention}suit{} of',
                [2] = 'every scored card is {C:attention}randomized{}',
            },
            ['unlock'] = {
                [1] = 'Play a {C:attention}Flush{}, a {C:attention}Straight{} and a',
                [2] = '{C:attention}Five of a Kind{} in a single round',
            }
        }
    },
    sim_card = {
        ['en-us'] = {
            ['name'] = 'SIM Card',
            ['text'] = {
                [1] = '{C:counterpart_ranks}Counterpart{} cards counts',
                [2] = 'as {C:attention}every{} suit',
            }
        }
    },
    wall = {
        ['en-us'] = {
            ['name'] = 'Wall',
            ['text'] = {
                [1] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [2] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [3] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [4] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [5] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [6] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [7] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [8] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [9] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [10] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [11] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [12] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [13] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [14] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [15] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [16] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [17] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [18] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [19] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [20] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [21] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [22] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
                [23] = 'text text text text text text text text text text text text text text text text text text text text text text text text text text text',
            },
            ['unlock'] = {
                [1] = 'Beat {C:attention}The Wall{} in {C:attention}one{} hand',
            }
        }
    },
    one_doller = {
        ['en-us'] = {
            ['name'] = 'one doller',
            ['text'] = {
                [1] = 'Buying something let you keep',
                [2] = '{C:money}1${} of the money you used',
            },
            ['unlock'] = {
                [1] = 'Buy something for {C:attention}free{}',
            }
        }
    },
    revolution = {
        ['en-us'] = {
            ['name'] = 'Revolution',
            ['text'] = {
                [1] = 'Scored {C:attention}face{} cards transforms',
                [2] = 'into {C:attention}non-face{} cards',
                [3] = '{C:inactive}(No effect with Pareidolia)',
            }
        }
    },
    fruit_sticker = {
        ['en-us'] = {
            ['name'] = 'Fruit Sticker',
            ['text'] = {
                [1] = '{X:mult,C:white}X#1#{} for each {C:attention}stickers{}',
                [2] = '{C:inactive}(Stake stickers excluded)',
            },
            ['unlock'] = {
                [1] = 'Have {C:attention}at least one{} sticker on your',
                [2] = '{C:attention}maximum{} amount of jokers (or higher)',
                [3] = '{C:inactive}(Stake stickers excluded)',
            }
        }
    },
    sinful_joker = {
        ['en-us'] = {
            ['name'] = 'Sinful Joker',
            ['text'] = {
                [1] = '{C:mult}+#1#{} Mult to {C:attention}Greedy Joker{}, {C:attention}Lusty Joker{}',
                [2] = '{C:attention}Wrathful Joker{} and {C:attention}Gluttonous Joker{}',
                [3] = 'every time a hand is played',
            },
            ['unlock'] = {
                [1] = 'Have {C:attention}Greedy Joker{}, {C:attention}Lusty Joker{},',
                [2] = '{C:attention}Wrathful Joker{} and {C:attention}Gluttonous{}',
                [3] = '{C:attention}Joker{} at the same time',
            }
        }
    },
    egg_drawing = {
        ['en-us'] = {
            ['name'] = 'Egg Drawing',
            ['text'] = {
                [1] = 'A random joker gains {C:money}4${} of {C:attention}sell{}',
                [2] = '{C:attention}value{} at the end of round',
            },
            ['unlock'] = {
                [1] = 'Sell a card for',
                [2] = 'more than {C:money}10${}',
            }
        }
    },
    jimbo_makeup = {
        ['en-us'] = {
            ['name'] = "Jimbo's Makeup",
            ['text'] = {
                [1] = 'insert text',
            },
        }
    },
    jimbo_hat = {
        ['en-us'] = {
            ['name'] = "Jimbo's Hat",
            ['text'] = {
                [1] = 'insert text',
            },
        }
    },
    jimbo_bells = {
        ['en-us'] = {
            ['name'] = "Jimbo's Bells",
            ['text'] = {
                [1] = 'insert text',
            },
        }
    },
    jimbo_collar = {
        ['en-us'] = {
            ['name'] = "Jimbo's Collar",
            ['text'] = {
                [1] = 'insert text',
            },
        }
    },
    gary_mccready = {
        ['en-us'] = {
            ['name'] = 'Gary McCready',
            ['text'] = {
                [1] = 'insert text',
            },
        }
    },
    ultimate_joker = {
        ['en-us'] = {
            ['name'] = 'Ultimate Joker',
            ['text'] = {
                [1] = '{X:purple,C:white}X#1#{} Mult and Chips',
                [2] = 'Value equald to round',
            },
        }
    },
    strainer = {
        ['en-us'] = {
            ['name'] = 'Strainer',
            ['inactive'] = {
                [1] = 'For each {C:money}5${} spend in next {C:attention}boss blind{}',
                [2] = 'creates a {C:attention}non-face{} {C:counterpart_ranks}counterpart{} or',
                [3] = '{C:attention}0{} card after the shop then {C:red}self-destruct{}',
                [4] = '{C:inactive}(Currently {C:money}#1#${C:inactive})',
            },
            ['active'] = {
                [1] = 'For each {C:money}5${} spend in next {C:attention}boss blind{}',
                [2] = 'creates a {C:attention}non-face{} {C:counterpart_ranks}counterpart{} or',
                [3] = '{C:attention}0{} card after the shop then {C:red}self-destruct{}',
                [4] = '{C:inactive}(Currently {C:money}#1#${C:inactive})',
            },
        }
    },
    billiard = {
        ['en-us'] = {
            ['name'] = 'Billiard',
            ['text'] = {
                [1] = '{C:attention}Retrigger{} cards',
                [2] = 'next to {C:attention}0{} cards',
            },
            ['unlock'] = {
                [1] = 'Trigger a {C:attention}0{}',
                [2] = 'card {C:attention}5{} times',
            }
        }
    },
    hiding_details = {
        ['en-us'] = {
            ['name'] = 'Hiding in the Details',
            ['text'] = {
                [1] = 'All cards are considered',
                [2] = '{C:counterpart_ranks}counterpart{} cards',
            }
        }
    },
    what_a_steel = {
        ['en-us'] = {
            ['name'] = 'What a Steel!',
            ['text'] = {
                [1] = 'Each {C:attention}Steel Card{} in your {C:attention}full deck{}',
                [2] = 'add a {C:attention}1%{} reduction on shop items',
                [3] = '{C:inactive}(Currently {C:attention}#1#%{}{C:inactive}, {C:attention}#2#%{}{C:inactive} with vouchers)',
            },
            ['unlock'] = {
                [1] = 'Buy a {C:attention}Steel Card{}',
                [2] = 'from the shop',
            }
        }
    },
    diplomatic_immunity = {
        ['en-us'] = {
            ['name'] = 'Diplomatic Immunity',
            ['text'] = {
                [1] = 'Last {C:attention}scored{} card',
                [2] = '{C:attention}cannot{} be debuffed',
            }
        }
    },

    ---- Rarity
    
    final = {
        ['en-us'] = {
            ['name'] = 'Final'
        }
    },
}