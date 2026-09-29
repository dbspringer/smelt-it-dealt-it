local function LoadRecipes()
    local ns = {}
    assert(loadfile("src/Recipes.lua"))("SmeltItDealtIt", ns)
    return ns.Recipes
end

local DARK_IRON_BAR = 11371

local function Bars(recipes)
    local bars = {}
    for _, recipe in ipairs(recipes) do
        table.insert(bars, recipe.bar)
    end
    return bars
end

describe("Smelt Recipes", function()
    -- Saved variables key on the bar, so two recipes with one bar would share
    -- their Hidden and Known state.
    it("each make a different bar", function()
        local seen = {}
        for _, recipe in ipairs(LoadRecipes().BUILT_IN) do
            assert.is_nil(seen[recipe.bar], "two Smelt Recipes make bar " .. recipe.bar)
            seen[recipe.bar] = true
        end
    end)

    it("use the game's version of a recipe once the Mining window corrects it, in the same row", function()
        local Recipes = LoadRecipes()
        local corrected = { bar = DARK_IRON_BAR, barsMade = 1, spellID = 14891, reagents = { { 11370, 5 } } }
        Recipes.UseCorrections({})
        Recipes.Correct(DARK_IRON_BAR, corrected)

        assert.are.equal(corrected, Recipes.Get(DARK_IRON_BAR))
        assert.are.same(Bars(Recipes.BUILT_IN), Bars(Recipes.All()))
        for _, recipe in ipairs(Recipes.All()) do
            if recipe.bar == DARK_IRON_BAR then
                assert.are.equal(corrected, recipe)
            end
        end
    end)

    it("go back to the built-in recipe when the correction is cleared", function()
        local Recipes = LoadRecipes()
        Recipes.UseCorrections({})
        Recipes.Correct(DARK_IRON_BAR, { bar = DARK_IRON_BAR, barsMade = 1, reagents = { { 11370, 5 } } })
        Recipes.ClearCorrection(DARK_IRON_BAR)

        assert.are.same({ { 11370, 8 } }, Recipes.Get(DARK_IRON_BAR).reagents)
    end)
end)
