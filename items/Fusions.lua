local fusions = {}

table.insert(fusions, {
    result_joker = "j_showdown_soul_gambling",
    jokers = {
        { name = "j_showdown_soul_avarice", carry_stat = "stat_to_carry", merge_stat = "stat_to_merge" },
        { name = "j_showdown_soul_malice", carry_stat = "stat_to_carry", merge_stat = "stat_to_merge" },
        { name = "j_showdown_soul_randomness", carry_stat = "stat_to_carry", merge_stat = "stat_to_merge" },
    },
    cost = 15,
    requirement = function ()
        --
    end,
    merged_stat = "stat",
    aftermath = function ()
        --
    end,
})

return {
    enabled = FusionJokers,
    exec = function ()
        for _, fusion in ipairs(fusions) do
            FusionJokers.fusions:register_fusion(fusion)
        end
    end,
    order = 3,
}