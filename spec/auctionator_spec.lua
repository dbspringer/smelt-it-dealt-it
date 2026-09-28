-- A fake Auctionator API, so the adapter's rules can run outside the game.
local ORE = 1

local function LoadAdapter(api)
    _G.Auctionator = { API = { v1 = api } }
    local registered
    local ns = {
        PriceSource = {
            Register = function(adapter)
                registered = adapter
            end,
        },
    }
    assert(loadfile("src/Auctionator.lua"))("SmeltItDealtIt", ns)
    return registered
end

local function Returning(value)
    return function()
        return value
    end
end

local function Throwing()
    error("bad caller ID")
end

describe("Auctionator adapter", function()
    after_each(function()
        _G.Auctionator = nil
    end)

    it("turns an API error into no price, not a Lua error", function()
        local adapter = LoadAdapter({
            GetAuctionPriceByItemID = Throwing,
            GetVendorPriceByItemID = Throwing,
            GetAuctionAgeByItemID = Throwing,
        })
        assert.is_nil(adapter.GetAuctionPrice(ORE))
        assert.is_nil(adapter.GetVendorPrice(ORE))
        assert.is_nil(adapter.GetAuctionAge(ORE))
    end)

    it("turns a price of 0 into no price, so it never looks free", function()
        local adapter = LoadAdapter({
            GetAuctionPriceByItemID = Returning(0),
            GetVendorPriceByItemID = Returning(0),
        })
        assert.is_nil(adapter.GetAuctionPrice(ORE))
        assert.is_nil(adapter.GetVendorPrice(ORE))
    end)

    it("keeps an age of 0, which means the item was seen today", function()
        local adapter = LoadAdapter({ GetAuctionAgeByItemID = Returning(0) })
        assert.are.equal(0, adapter.GetAuctionAge(ORE))
    end)
end)
