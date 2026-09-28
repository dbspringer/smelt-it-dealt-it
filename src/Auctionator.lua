local addonName, ns = ...

-- The Auctionator adapter for the Price Source. Auctionator's code is All
-- Rights Reserved, so this uses only its public API (Auctionator.API.v1).
local AUCTIONATOR = "Auctionator"

-- The API throws on a bad argument, and a price lookup must never break the
-- Smelt Table, so an error reads as no data.
local function Call(method, ...)
    local ok, result = pcall(function(...)
        return Auctionator.API.v1[method](addonName, ...)
    end, ...)
    if ok then
        return result
    end
    return nil
end

-- A price of 0 would make an item look free, so it counts as no data.
local function Price(method, itemID)
    local price = Call(method, itemID)
    if price == 0 then
        return nil
    end
    return price
end

ns.PriceSource.Register({
    name = AUCTIONATOR,
    IsLoaded = function()
        return C_AddOns.IsAddOnLoaded(AUCTIONATOR)
    end,
    GetAuctionPrice = function(itemID)
        return Price("GetAuctionPriceByItemID", itemID)
    end,
    GetVendorPrice = function(itemID)
        return Price("GetVendorPriceByItemID", itemID)
    end,
    -- 0 is a real age: seen today.
    GetAuctionAge = function(itemID)
        return Call("GetAuctionAgeByItemID", itemID)
    end,
    -- Fires after every search or scan that Auctionator processes. It has no
    -- way to unregister, so this runs once.
    RegisterForUpdates = function(callback)
        Call("RegisterForDBUpdate", callback)
    end,
})
