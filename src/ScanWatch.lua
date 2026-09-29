local _, ns = ...
local Freshness = ns.Freshness

-- Notes when auction house data arrives, for Price Age in hours. It listens
-- to Blizzard's auction house events only, so it works with whatever addon or
-- window runs the search, and reads nothing from the Price Source.

-- Only the items the Smelt Table prices, so the record stays small.
local function TrackedItems()
    local items = {}
    for _, recipe in ipairs(ns.Recipes.All()) do
        items[recipe.bar] = true
        for _, reagent in ipairs(recipe.reagents) do
            items[reagent[1]] = true
        end
    end
    return items
end

local function MarkSeen(results)
    local tracked, now, any = TrackedItems(), GetServerTime(), false
    for _, result in ipairs(results or {}) do
        local itemID = result.itemKey and result.itemKey.itemID
        if itemID and tracked[itemID] then
            Freshness.Seen(itemID, now)
            any = true
        end
    end
    return any
end

local events = CreateFrame("Frame")
-- A full scan: C_AuctionHouse.ReplicateItems, which Auctionator's Full Scan uses.
events:RegisterEvent("REPLICATE_ITEM_LIST_UPDATE")
-- A search for one commodity, such as an ore.
events:RegisterEvent("COMMODITY_SEARCH_RESULTS_UPDATED")
-- A browse list, which a shopping list search also fills.
events:RegisterEvent("AUCTION_HOUSE_BROWSE_RESULTS_UPDATED")
events:RegisterEvent("AUCTION_HOUSE_BROWSE_RESULTS_ADDED")
events:SetScript("OnEvent", function(_, event, payload)
    local changed = false
    if event == "REPLICATE_ITEM_LIST_UPDATE" then
        Freshness.FullScan(GetServerTime())
        changed = true
    elseif event == "COMMODITY_SEARCH_RESULTS_UPDATED" then
        if TrackedItems()[payload] then
            Freshness.Seen(payload, GetServerTime())
            changed = true
        end
    elseif event == "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED" then
        changed = MarkSeen(C_AuctionHouse.GetBrowseResults())
    else
        changed = MarkSeen(payload)
    end
    if changed then
        ns.SmeltTable.Refresh()
    end
end)
