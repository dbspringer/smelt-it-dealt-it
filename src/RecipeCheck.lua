local _, ns = ...

-- Compares a built-in Smelt Recipe with what the game says it is. Pure, so
-- the specs can load it; the Mining window pass reads the game's side.
local RecipeCheck = {}
ns.RecipeCheck = RecipeCheck

RecipeCheck.SAME, RecipeCheck.DIFFERENT, RecipeCheck.DIFFERENT_BAR = "SAME", "DIFFERENT", "DIFFERENT_BAR"

local function Counts(reagents)
    local counts = {}
    for _, reagent in ipairs(reagents) do
        counts[reagent[1]] = (counts[reagent[1]] or 0) + reagent[2]
    end
    return counts
end

-- The game may list reagents in another order, which is no difference.
local function SameReagents(ours, theirs)
    local a, b = Counts(ours), Counts(theirs)
    for itemID, count in pairs(a) do
        if b[itemID] ~= count then
            return false
        end
    end
    for itemID in pairs(b) do
        if a[itemID] == nil then
            return false
        end
    end
    return true
end

-- game is { bar, barsMade, reagents }. Returns SAME; DIFFERENT and the
-- recipe to use instead; or DIFFERENT_BAR, when the spell makes another bar.
-- That means the built-in identity is wrong, so no data changes and only a
-- report can fix it.
function RecipeCheck.Compare(recipe, game)
    if game.bar ~= recipe.bar then
        return RecipeCheck.DIFFERENT_BAR
    end
    if game.barsMade == recipe.barsMade and SameReagents(recipe.reagents, game.reagents) then
        return RecipeCheck.SAME
    end
    return RecipeCheck.DIFFERENT, {
        bar = recipe.bar,
        barsMade = game.barsMade,
        spellID = recipe.spellID,
        reagents = game.reagents,
        blackForge = recipe.blackForge,
    }
end
