local function LoadFreshness()
    local ns = {}
    assert(loadfile("src/Freshness.lua"))("SmeltItDealtIt", ns)
    ns.Freshness.Use({})
    return ns.Freshness
end

local ORE = 1
local HOUR = 3600
-- Any server time; only differences matter.
local T = 1000000

describe("Price Age in hours", function()
    it("is exact from the addon's own record of a search", function()
        local Freshness = LoadFreshness()
        Freshness.Seen(ORE, T)

        local hours, exact = Freshness.AgeHours(ORE, 0, T + HOUR / 2)
        assert.are.equal(0.5, hours)
        assert.is_true(exact)
    end)

    it("takes the last full scan only for items the Price Source saw today", function()
        local Freshness = LoadFreshness()
        Freshness.FullScan(T)

        assert.are.equal(1, Freshness.AgeHours(ORE, 0, T + HOUR))
        -- Seen two days ago: the scan today didn't list it.
        assert.are.equal(72, Freshness.AgeHours(ORE, 2, T + HOUR))
    end)

    it("uses the later of a search and a full scan", function()
        local Freshness = LoadFreshness()
        Freshness.Seen(ORE, T)
        Freshness.FullScan(T + 3 * HOUR)
        assert.are.equal(0, Freshness.AgeHours(ORE, 0, T + 3 * HOUR))

        Freshness.Seen(ORE, T + 5 * HOUR)
        assert.are.equal(0, Freshness.AgeHours(ORE, 0, T + 5 * HOUR))
    end)

    it("assumes the oldest time in the day without a record of its own", function()
        local Freshness = LoadFreshness()
        local hours, exact = Freshness.AgeHours(ORE, 1, T)
        assert.are.equal(48, hours)
        assert.is_false(exact)
    end)

    it("is unknown with no record and no age", function()
        assert.is_nil(LoadFreshness().AgeHours(ORE, nil, T))
    end)
end)

describe("Stale Price in hours", function()
    it("turns stale once past the limit", function()
        local Freshness = LoadFreshness()
        Freshness.Seen(ORE, T)
        assert.is_false(Freshness.IsStale(ORE, 0, T + HOUR / 2, 1))
        assert.is_true(Freshness.IsStale(ORE, 0, T + 2 * HOUR, 1))
    end)

    it("never calls a day-old price fresh without a record", function()
        local Freshness = LoadFreshness()
        -- Seen yesterday could mean 47 hours ago.
        assert.is_true(Freshness.IsStale(ORE, 1, T, 24))
        assert.is_false(Freshness.IsStale(ORE, 1, T, 48))
    end)

    it("is stale when the age is unknown", function()
        assert.is_true(LoadFreshness().IsStale(ORE, nil, T, 336))
    end)
end)
