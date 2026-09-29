local ns = {}
assert(loadfile("src/RecipeCheck.lua"))("SmeltItDealtIt", ns)
local RecipeCheck = ns.RecipeCheck

local STEEL = { bar = 3859, barsMade = 1, spellID = 3569, reagents = { { 3575, 1 }, { 3857, 1 } } }

-- The game's side, as the Mining window pass reads it from the schematic.
local function Game(bar, barsMade, reagents)
    return { bar = bar, barsMade = barsMade, reagents = reagents }
end

describe("Recipe check", function()
    it("finds no difference when the game agrees", function()
        local result = RecipeCheck.Compare(STEEL, Game(3859, 1, { { 3575, 1 }, { 3857, 1 } }))
        assert.are.equal(RecipeCheck.SAME, result)
    end)

    it("finds no difference when the game lists the reagents in another order", function()
        local result = RecipeCheck.Compare(STEEL, Game(3859, 1, { { 3857, 1 }, { 3575, 1 } }))
        assert.are.equal(RecipeCheck.SAME, result)
    end)

    it("takes the game's reagent counts when they differ", function()
        local result, corrected = RecipeCheck.Compare(STEEL, Game(3859, 1, { { 3575, 2 }, { 3857, 1 } }))
        assert.are.equal(RecipeCheck.DIFFERENT, result)
        assert.are.same({ { 3575, 2 }, { 3857, 1 } }, corrected.reagents)
        assert.are.equal(STEEL.bar, corrected.bar)
    end)

    it("takes the game's bars made when they differ", function()
        local result, corrected = RecipeCheck.Compare(STEEL, Game(3859, 2, { { 3575, 1 }, { 3857, 1 } }))
        assert.are.equal(RecipeCheck.DIFFERENT, result)
        assert.are.equal(2, corrected.barsMade)
    end)

    it("changes no data when the spell makes a different bar, since the identity is wrong", function()
        local result, corrected = RecipeCheck.Compare(STEEL, Game(9999, 1, { { 3575, 1 }, { 3857, 1 } }))
        assert.are.equal(RecipeCheck.DIFFERENT_BAR, result)
        assert.is_nil(corrected)
    end)
end)
