local ns = {}
assert(loadfile("src/Recipes.lua"))("SmeltItDealtIt", ns)

describe("Smelt Recipes", function()
    -- Saved variables key on the bar, so two recipes with one bar would share
    -- their Hidden and Known state.
    it("each make a different bar", function()
        local seen = {}
        for _, recipe in ipairs(ns.Recipes) do
            assert.is_nil(seen[recipe.bar], "two Smelt Recipes make bar " .. recipe.bar)
            seen[recipe.bar] = true
        end
    end)
end)
