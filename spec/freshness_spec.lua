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

    it("keeps the later of two sightings", function()
        local Freshness = LoadFreshness()
        Freshness.Seen(ORE, T + 3 * HOUR)
        Freshness.Seen(ORE, T)
        assert.are.equal(0, Freshness.AgeHours(ORE, 0, T + 3 * HOUR))
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

describe("A full scan", function()
    local BAR, OTHER = 2, 3
    local TRACKED = { [ORE] = true, [BAR] = true }

    -- A full scan list: one item ID per index, from 0, as the game numbers it.
    local function Listing(itemIDs)
        return function(index)
            return itemIDs[index + 1]
        end
    end

    it("freshens only the tracked items it lists", function()
        local Freshness = LoadFreshness()
        Freshness.SeenInScan(Listing({ OTHER, ORE, OTHER }), 0, 2, TRACKED, T)

        assert.are.equal(0, Freshness.AgeHours(ORE, 0, T))
        -- Seen earlier today, but not in this scan: no hours of its own.
        assert.is_false(select(2, Freshness.AgeHours(BAR, 0, T)))
        assert.is_false(select(2, Freshness.AgeHours(OTHER, 0, T)))
    end)

    it("skips entries whose item isn't known yet", function()
        local Freshness = LoadFreshness()
        Freshness.SeenInScan(Listing({ nil, ORE }), 0, 1, TRACKED, T)
        assert.are.equal(0, Freshness.AgeHours(ORE, 0, T))
    end)
end)
