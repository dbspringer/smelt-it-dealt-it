local _, ns = ...

local Recipes = {}
ns.Recipes = Recipes

-- Every Smelt Recipe, in Mining skill order, which is also the Smelt Table's
-- row order. Vanilla values from AtlasLootClassic; the Mining window pass
-- checks them against the game and saves a correction where they differ.
--
-- The bar's item ID is the recipe's identity, and saved variables key on it.
-- Each recipe makes a different bar, and item IDs are more stable than spell
-- IDs, which stay here only for that check. There are no item names: the
-- client gives the localized ones.
Recipes.BUILT_IN = {
    -- Copper Ore -> Copper Bar
    { bar = 2840, barsMade = 1, spellID = 2657, reagents = { { 2770, 1 } } },
    -- Tin Ore -> Tin Bar
    { bar = 3576, barsMade = 1, spellID = 3304, reagents = { { 2771, 1 } } },
    -- Copper Bar + Tin Bar -> 2 Bronze Bars
    { bar = 2841, barsMade = 2, spellID = 2659, reagents = { { 2840, 1 }, { 3576, 1 } } },
    -- Silver Ore -> Silver Bar
    { bar = 2842, barsMade = 1, spellID = 2658, reagents = { { 2775, 1 } } },
    -- Iron Ore -> Iron Bar
    { bar = 3575, barsMade = 1, spellID = 3307, reagents = { { 2772, 1 } } },
    -- Iron Bar + Coal -> Steel Bar
    { bar = 3859, barsMade = 1, spellID = 3569, reagents = { { 3575, 1 }, { 3857, 1 } } },
    -- Gold Ore -> Gold Bar
    { bar = 3577, barsMade = 1, spellID = 3308, reagents = { { 2776, 1 } } },
    -- Mithril Ore -> Mithril Bar
    { bar = 3860, barsMade = 1, spellID = 10097, reagents = { { 3858, 1 } } },
    -- Truesilver Ore -> Truesilver Bar
    { bar = 6037, barsMade = 1, spellID = 10098, reagents = { { 7911, 1 } } },
    -- Thorium Ore -> Thorium Bar
    { bar = 12359, barsMade = 1, spellID = 16153, reagents = { { 10620, 1 } } },
    -- 8 Dark Iron Ore -> Dark Iron Bar, only at the Black Forge
    { bar = 11371, barsMade = 1, spellID = 14891, reagents = { { 11370, 8 } }, blackForge = true },
    -- Elementium Ore + 10 Arcanite Bar + Fiery Core + 3 Elemental Flux -> Elementium Bar
    {
        bar = 17771,
        barsMade = 1,
        spellID = 22967,
        reagents = { { 18562, 1 }, { 12360, 10 }, { 17010, 1 }, { 18567, 3 } },
    },
}

-- The game's version of a recipe, keyed on the bar, saved account-wide.
local corrections = {}

function Recipes.UseCorrections(saved)
    corrections = saved
end

function Recipes.Correct(bar, recipe)
    corrections[bar] = recipe
end

function Recipes.ClearCorrection(bar)
    corrections[bar] = nil
end

-- A correction wins over the built-in recipe, and keeps its row.
function Recipes.Get(bar)
    if corrections[bar] then
        return corrections[bar]
    end
    for _, recipe in ipairs(Recipes.BUILT_IN) do
        if recipe.bar == bar then
            return recipe
        end
    end
end

function Recipes.All()
    local all = {}
    for _, recipe in ipairs(Recipes.BUILT_IN) do
        table.insert(all, corrections[recipe.bar] or recipe)
    end
    return all
end
