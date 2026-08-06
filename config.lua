local mod = SMODS.current_mod

mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = {align = "cm", padding = 0.1, colour = G.C.BLACK, r = 0.1},
        nodes = {
            create_toggle({
                label = "Simplify decimal fractions",
                ref_table = mod.config,
                ref_value = "simplify_decimal_fractions",
            }),--todo add dynamic example text here --> 1 in 1.25 chance vs 4 in 5 chance
        }
    }
end

return {
    ["simplify_decimal_fractions"] = true
}
