-- Config keeps its saved-variables table in file-level state, so each spec
-- loads a fresh copy over the given table.
local function LoadConfig(db)
    local ns = {}
    assert(loadfile("src/Recipes.lua"))("SmeltItDealtIt", ns)
    assert(loadfile("src/Config.lua"))("SmeltItDealtIt", ns)
    ns.Config.Use(db)
    return ns.Config, ns.Recipes
end

local TIN_BAR = 3576

local function Bars(recipes)
    local bars = {}
    for _, recipe in ipairs(recipes) do
        table.insert(bars, recipe.bar)
    end
    return bars
end

describe("Config", function()
    it("gives the defaults for a fresh install", function()
        local Config = LoadConfig({})
        assert.are.same({ percent = 0.05, minimum = 100 }, Config.Threshold())
        assert.are.equal(1, Config.StaleDays())
    end)

    it("falls back per value, so saved data from an older version still works", function()
        local Config = LoadConfig({ settings = { minimum = 500 } })
        assert.are.same({ percent = 0.05, minimum = 500 }, Config.Threshold())
        assert.are.equal(1, Config.StaleDays())
    end)

    it("leaves out Hidden Recipes and keeps Mining skill order", function()
        local Config, Recipes = LoadConfig({})
        Config.SetHidden(TIN_BAR, true)

        local expected = {}
        for _, bar in ipairs(Bars(Recipes)) do
            if bar ~= TIN_BAR then
                table.insert(expected, bar)
            end
        end
        assert.are.same(expected, Bars(Config.VisibleRecipes()))
    end)

    it("resets to the defaults and shows every recipe again", function()
        local Config, Recipes = LoadConfig({})
        Config.Set("percent", 10)
        Config.Set("staleDays", 7)
        Config.SetHidden(TIN_BAR, true)

        Config.Reset()

        assert.are.same({ percent = 0.05, minimum = 100 }, Config.Threshold())
        assert.are.equal(1, Config.StaleDays())
        assert.are.same(Bars(Recipes), Bars(Config.VisibleRecipes()))
    end)
end)
