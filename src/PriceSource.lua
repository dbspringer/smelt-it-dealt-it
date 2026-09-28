local _, ns = ...

-- The only way the addon reads prices (ADR 0001). Each price addon has an
-- adapter that registers here; nothing else calls a price addon directly.
--
-- An adapter has a name (its addon's folder name), IsLoaded(), and
-- GetAuctionPrice / GetVendorPrice / GetAuctionAge (itemID), each nil for no
-- data, plus RegisterForUpdates(callback).
local PriceSource = {}
ns.PriceSource = PriceSource

-- In TOC load order, which is the priority order.
local adapters = {}
local active
local listeners = {}

function PriceSource.Register(adapter)
    table.insert(adapters, adapter)
end

-- Run at PLAYER_LOGIN, once every OptionalDeps addon has loaded. A setting
-- for the player's own choice comes with a second adapter; see ADR 0001.
function PriceSource.Select()
    active = nil
    for _, adapter in ipairs(adapters) do
        if adapter.IsLoaded() then
            active = adapter
            break
        end
    end
    if active then
        active.RegisterForUpdates(function()
            for _, listener in ipairs(listeners) do
                listener()
            end
        end)
    end
end

function PriceSource.IsAvailable()
    return active ~= nil
end

function PriceSource.ActiveName()
    return active and active.name
end

function PriceSource.SupportedNames()
    local names = {}
    for _, adapter in ipairs(adapters) do
        table.insert(names, adapter.name)
    end
    return names
end

-- Returns price (copper, nil for no data), isVendor, and age (whole days, nil
-- for a vendor price or an unknown age). The vendor price wins, as in
-- Auctionator's own crafting cost, and it can't go stale.
function PriceSource.Lookup(itemID)
    if not active then
        return nil
    end
    local vendorPrice = active.GetVendorPrice(itemID)
    if vendorPrice then
        return vendorPrice, true, nil
    end
    local auctionPrice = active.GetAuctionPrice(itemID)
    if auctionPrice == nil then
        return nil
    end
    return auctionPrice, false, active.GetAuctionAge(itemID)
end

function PriceSource.OnChange(listener)
    table.insert(listeners, listener)
end
