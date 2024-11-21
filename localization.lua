return  {
    counterpart = {
        ['en-us'] = {
            ['name'] = 'Counterpart Deck',
            ['text'] = {
                [1] = 'All faces, aces and',
                [2] = 'numbers are replaced',
                [3] = 'by their {C:bunco_exotic}counterpart{}'
            },
            ['unlock'] = {
                [1] = 'Not implemented'
            }
        }
    },

    counterpart_cards = {
        ['en-us'] = {
            ['name'] = 'Counterpart cards',
            ['text'] = {
                [1] = 'Cards with rank',
                [2] = '2.5, 5.5, 8.5,',
                [3] = 'Butler, Princess and Lord'
            }
        }
    },

    ---- Ranks
    
    two_half = {
        ['en-us'] = {
            ['name'] = '2.5',
            ['text'] = {
                [1] = 'Counts as a 2'
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
            ['name'] = '0'
        }
    },

    ---- Consumables

    -- Tarots

    reflection = {
        ['en-us'] = {
            ['name'] = 'The Reflection',
            ['text'] = {
                [1] = 'Converts up to',
                [2] = '{C:attention}#2#{} selected cards',
                [3] = 'to their counterpart'
            }
        }
    },
    vessel = {
        ['en-us'] = {
            ['name'] = 'The Vessel',
            ['text'] = {
                [1] = 'Converts {C:attention}#1#{} selected card',
                [2] = 'to a 0 with a random enhancement',
                [3] = 'or seal'
            }
        }
    },

    -- Spectrals

    mist = {
        ['en-us'] = {
            ['name'] = 'Mist',
            ['text'] = {
                [1] = 'Converts 6 random cards into',
                [2] = 'either an Ace or a 0'
            }
        }
    },
    vision = {
        ['en-us'] = {
            ['name'] = 'Vision',
            ['text'] = {
                [1] = 'All cards held in hand converts into',
                [2] = 'their higher or equal decimal counterpart,',
                [3] = 'but loses their edition'
            }
        }
    },

    -- Jokers

    pinpoint = {
        ['en-us'] = {
            ['name'] = 'Pinpoint',
            ['text'] = {
                [1] = '{X:chips}x1.5{} for each 0 in hand',
            },
            ['unlock'] = {
                [1] = 'Play a 5 card hand',
                [2] = 'that contains only',
                [3] = '{C:attention,E:1}0{} cards'
            }
        }
    },
    motherDaughter = {
        ['en-us'] = {
            ['name'] = 'Like Mother Like Daughter',
            ['text'] = {
                [1] = '{X:mult}x#1#{} for each pair of',
                [2] = 'Princess scored and Queen in hand'
            },
            ['unlock'] = {
                [1] = 'Play a double pair hand',
                [2] = 'that contains {C:attention}Queens{}',
                [3] = 'and {C:attention}Princesses{}'
            }
        }
    },
    crouton = {
        ['en-us'] = {
            ['name'] = 'Crouton',
            ['text'] = {
                [1] = '{X:mult}x1.15{} for each',
                [2] = 'card held in hand'
            }
        }
    }
}