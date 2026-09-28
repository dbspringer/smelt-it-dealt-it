local ns = {}
assert(loadfile("src/Smelt.lua"))("SmeltItDealtIt", ns)
local Smelt = ns.Smelt

-- Item IDs only matter as keys here, so short fake ones keep the recipes
-- readable.
local ORE, ORE_2, BAR, COAL = 1, 2, 10, 20

local function OneOre(ore, bar)
    return { bar = bar or BAR, barsMade = 1, reagents = { { ore or ORE, 1 } } }
end

-- A price is a number (an auction price) or { price, isVendor = true }.
local function PriceOf(prices)
    return function(itemID)
        local price = prices[itemID]
        if type(price) == "table" then
            return price[1], price.isVendor
        end
        return price, false
    end
end

local function Evaluate(recipe, prices, threshold)
    return Smelt.Evaluate(recipe, PriceOf(prices), threshold or Smelt.DEFAULT_THRESHOLD)
end

-- 0.95 isn't exact in binary floating point.
local EPSILON = 1e-6

describe("Verdict", function()
    it("is Smelt when the bars sell for clearly more than the ore", function()
        -- Thorium: 47.5s raw vs. 57s smelted.
        local result = Evaluate(OneOre(), { [ORE] = 5000, [BAR] = 6000 })
        assert.are.equal(Smelt.SMELT, result.verdict)
    end)

    it("is Sell Raw when the ore sells for clearly more than the bars", function()
        local result = Evaluate(OneOre(), { [ORE] = 6000, [BAR] = 5000 })
        assert.are.equal(Smelt.SELL_RAW, result.verdict)
    end)

    it("is Toss-up when the gain is below the minimum, however large as a percent", function()
        -- Copper: 9.5c raw vs. 23.75c smelted is +150%, but only 14c.
        local result = Evaluate(OneOre(), { [ORE] = 10, [BAR] = 25 })
        assert.are.equal(Smelt.TOSS_UP, result.verdict)
    end)

    it("is Toss-up when the gain is below the percent, however large in gold", function()
        -- 95g raw vs. 97.85g smelted: 2.85g is far above 1s, but under 5%.
        local result = Evaluate(OneOre(), { [ORE] = 1000000, [BAR] = 1030000 })
        assert.are.equal(Smelt.TOSS_UP, result.verdict)
    end)

    it("is Toss-up when the difference is exactly the threshold", function()
        -- 95c raw vs. 190c smelted.
        local threshold = { percent = 0, minimum = 95 }
        local result = Evaluate(OneOre(), { [ORE] = 100, [BAR] = 200 }, threshold)
        assert.are.equal(Smelt.TOSS_UP, result.verdict)
    end)
end)

describe("Values", function()
    it("take the AH Cut off both sides for ore the player holds", function()
        local result = Evaluate(OneOre(), { [ORE] = 5000, [BAR] = 6000 })
        assert.near(4750, result.rawValue, EPSILON)
        assert.near(5700, result.smeltedValue, EPSILON)
        assert.near(950, result.difference, EPSILON)
    end)

    it("count Smelt Profit against the full ore price, since a buyer pays no cut", function()
        local result = Evaluate(OneOre(), { [ORE] = 5000, [BAR] = 6000 })
        assert.near(700, result.smeltProfit, EPSILON)
    end)

    it("count every bar a Smelt Recipe makes", function()
        -- Bronze: 1 Copper Bar + 1 Tin Bar make 2 Bronze Bars.
        local bronze = { bar = BAR, barsMade = 2, reagents = { { ORE, 1 }, { ORE_2, 1 } } }
        local result = Evaluate(bronze, { [ORE] = 100, [ORE_2] = 100, [BAR] = 150 })
        assert.near(285, result.smeltedValue, EPSILON)
    end)

    it("count every unit of a Reagent", function()
        -- Dark Iron: 8 ore make 1 bar.
        local darkIron = { bar = BAR, barsMade = 1, reagents = { { ORE, 8 } } }
        local result = Evaluate(darkIron, { [ORE] = 1000, [BAR] = 10000 })
        assert.near(7600, result.rawValue, EPSILON)
        assert.near(1500, result.smeltProfit, EPSILON)
    end)

    it("count a Vendor Reagent at its full price on both sides", function()
        -- Steel: selling the Iron Bar raw also saves buying the Coal.
        local steel = { bar = BAR, barsMade = 1, reagents = { { ORE, 1 }, { COAL, 1 } } }
        local prices = { [ORE] = 1000, [COAL] = { 500, isVendor = true }, [BAR] = 2000 }
        local result = Evaluate(steel, prices)
        assert.near(950 + 500, result.rawValue, EPSILON)
        assert.near(1900 - 1000 - 500, result.smeltProfit, EPSILON)
    end)
end)

describe("No Data", function()
    it("gives no Verdict when the bar has no price", function()
        local result = Evaluate(OneOre(), { [ORE] = 5000 })
        assert.is_true(result.noData)
        assert.is_nil(result.verdict)
        assert.is_nil(result.smeltProfit)
    end)

    it("gives no Verdict when any Reagent has no price", function()
        local steel = { bar = BAR, barsMade = 1, reagents = { { ORE, 1 }, { COAL, 1 } } }
        local result = Evaluate(steel, { [ORE] = 1000, [BAR] = 2000 })
        assert.is_true(result.noData)
        assert.is_nil(result.verdict)
    end)
end)
