-- The module keeps its adapters and choice in file-level state, so each spec
-- loads a fresh copy.
local function LoadPriceSource()
    local ns = {}
    assert(loadfile("src/PriceSource.lua"))("SmeltItDealtIt", ns)
    return ns.PriceSource
end

-- An adapter over a table of { auction = copper, vendor = copper, age = days }.
local function StubAdapter(name, loaded, items)
    items = items or {}
    local function field(key)
        return function(itemID)
            return items[itemID] and items[itemID][key]
        end
    end
    return {
        name = name,
        IsLoaded = function()
            return loaded
        end,
        GetAuctionPrice = field("auction"),
        GetVendorPrice = field("vendor"),
        GetAuctionAge = field("age"),
        RegisterForUpdates = function() end,
    }
end

local ORE, COAL = 1, 2

describe("Price Source", function()
    it("prefers a vendor price, which has no age", function()
        local PriceSource = LoadPriceSource()
        PriceSource.Register(StubAdapter("A", true, { [COAL] = { vendor = 500, auction = 900, age = 3 } }))
        PriceSource.Select()

        local price, isVendor, age = PriceSource.Lookup(COAL)
        assert.are.equal(500, price)
        assert.is_true(isVendor)
        assert.is_nil(age)
    end)

    it("falls back to the Auction Price and its age", function()
        local PriceSource = LoadPriceSource()
        PriceSource.Register(StubAdapter("A", true, { [ORE] = { auction = 900, age = 3 } }))
        PriceSource.Select()

        local price, isVendor, age = PriceSource.Lookup(ORE)
        assert.are.equal(900, price)
        assert.is_false(isVendor)
        assert.are.equal(3, age)
    end)

    it("gives nil for an item with no price", function()
        local PriceSource = LoadPriceSource()
        PriceSource.Register(StubAdapter("A", true))
        PriceSource.Select()

        assert.is_nil(PriceSource.Lookup(ORE))
    end)

    it("uses the first loaded adapter in registration order", function()
        local PriceSource = LoadPriceSource()
        PriceSource.Register(StubAdapter("A", false, { [ORE] = { auction = 100 } }))
        PriceSource.Register(StubAdapter("B", true, { [ORE] = { auction = 200 } }))
        PriceSource.Register(StubAdapter("C", true, { [ORE] = { auction = 300 } }))
        PriceSource.Select()

        assert.are.equal(200, PriceSource.Lookup(ORE))
    end)

    it("is unavailable, with no prices, when no adapter's addon is loaded", function()
        local PriceSource = LoadPriceSource()
        PriceSource.Register(StubAdapter("A", false, { [ORE] = { auction = 100 } }))
        PriceSource.Select()

        assert.is_false(PriceSource.IsAvailable())
        assert.is_nil(PriceSource.Lookup(ORE))
    end)

    it("names every supported addon, for the message when none is loaded", function()
        local PriceSource = LoadPriceSource()
        PriceSource.Register(StubAdapter("A", false))
        PriceSource.Register(StubAdapter("B", false))

        assert.are.same({ "A", "B" }, PriceSource.SupportedNames())
    end)
end)
