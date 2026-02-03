local fusions = {}

table.insert(fusions, {
    result_joker = "j_showdown_soul_gambling",
    experimental = true,
    jokers = {
        { name = "j_showdown_soul_avarice", carry_stat = "x_mult" },
        { name = "j_showdown_soul_malice", carry_stat = "retrigger" },
        { name = "j_showdown_soul_randomness", carry_stat = "x_chips" },
    },
    cost = 15,
})

return {
    enabled = FusionJokers,
    exec = function ()
        for _, fusion in ipairs(fusions) do
            if not fusion.experimental or (fusion.experimental and Showdown.config["Technical"]["Experimental"]) then
                FusionJokers.fusions:register_fusion(fusion)
            end
        end
    end,
    order = 3,
}