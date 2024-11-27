return  {
    counterpart = {
        ['en-us'] = {
            ['name'] = 'Mirror Deck',
            ['text'] = {
                [1] = 'All faces, 8s, 5s and',
                [2] = '2s are replaced',
                [3] = 'by their {C:counterpart_ranks}counterpart{}',
                [4] = 'Aces are replaced by 0s',
            }
        }
    },

    counterpart_cards = {
        ['en-us'] = {
            ['name'] = 'Counterpart cards',
            ['text'] = {
                [1] = 'Cards with rank',
                [2] = '2.5, 5.5, 8.5,',
                [3] = 'Butler, Princess and Lord',
            }
        }
    },

    ---- Ranks
    
    two_half = {
        ['en-us'] = {
            ['name'] = '2.5',
            ['text'] = {
                [1] = 'Counts as a 2',
            }
        }
    },
    five_half = {
        ['en-us'] = {
            ['name'] = '5.5'
        }
    },
    eight_half = {
        ['en-us'] = {
            ['name'] = '8.5'
        }
    },
    butler = {
        ['en-us'] = {
            ['name'] = 'Butler'
        }
    },
    princess = {
        ['en-us'] = {
            ['name'] = 'Princess'
        }
    },
    lord = {
        ['en-us'] = {
            ['name'] = 'Lord'
        }
    },
    zero = {
        ['en-us'] = {
            ['name'] = '0',
            ['text'] = {
                [1] = 'Counts as any suit',
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
                [3] = "{C:inactive}(Must have room)",
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
                [2] = 'into either an {C:attention}Ace{}',
                [3] = 'or a {C:attention}0{}',
            }
        }
    },
    vision = {
        ['en-us'] = {
            ['name'] = 'Vision',
            ['text'] = {
                [1] = 'All cards held in hand {C:attention}converts{}',
                [2] = 'into their higher or equal,',
                [3] = 'decimal {C:counterpart_ranks}counterpart{} but loses',
                [4] = 'their {C:attention}edition{} and {C:attention}seal{}',
            }
        }
    },

    -- Mathematics

    constant = {
        ['en-us'] = {
            ['name'] = 'Constant',
            ['text'] = {
                [1] = 'idk',
            }
        }
    },
    variable = {
        ['en-us'] = {
            ['name'] = 'Variable',
            ['text'] = {
                [1] = 'idk',
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
                [4] = 'the leftest joker by {X:attention,C:white}x1.25{}',
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
                [3] = 'The value of the card is either the {C:attention}addition{} or',
                [4] = 'the {C:attention}substraction{} of the destroyed cards',
            }
        }
    },
    theorem = {
        ['en-us'] = {
            ['name'] = 'Theorem',
            ['text'] = {
                [1] = 'idk',
            }
        }
    },

    ---- Vouchers

    irrational = {
        ['en-us'] = {
            ['name'] = 'Irrational Numbers',
            ['text'] = {
                [1] = '{C:counterpart_ranks}Counterpart{} cards may',
                [2] = 'appear with an {C:attention}enhancement{}',
            },
            ['unlock'] = {
                [1] = 'Have at least {C:attention}20{} {C:counterpart_ranks}counterpart{}',
                [2] = 'cards in your deck',
            }
        }
    },
    transcendant = {
        ['en-us'] = {
            ['name'] = 'Transcendant Numbers',
            ['text'] = {
                [1] = '{C:counterpart_ranks}Counterpart{} cards may',
                [2] = 'appear with an {C:attention}edition{}',
            },
            ['unlock'] = {
                [1] = 'Have at least {C:attention}10{} {C:counterpart_ranks}counterpart{}',
                [2] = 'cards with one or more',
                [3] = '{C:attention}modifiers{} in your deck',
            }
        }
    },
    complex = {
        ['en-us'] = {
            ['name'] = 'Complex Numbers',
            ['text'] = {
                [1] = '{C:counterpart_ranks}Counterpart{} cards trigger',
                [2] = '{C:attention}one additional time{}',
            }
        }
    },

    ---- Jokers

    pinpoint = {
        ['en-us'] = {
            ['name'] = 'Pinpoint',
            ['text'] = {
                [1] = '{X:chips,C:white}x1.5{} Chips for each 0 in hand',
            },
            ['unlock'] = {
                [1] = 'Play a {C:attention}Five of a Kind{}',
                [2] = 'that contains only',
                [3] = '{C:attention,E:1}#1#{} cards',
            }
        }
    },
    motherDaughter = {
        ['en-us'] = {
            ['name'] = 'Like Mother Like Daughter',
            ['text'] = {
                [1] = '{X:mult,C:white}x#1#{} for each pair of',
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
                [1] = '{X:mult,C:white}x1.15{} for each',
                [2] = 'card held in hand',
            }
        }
    }
}