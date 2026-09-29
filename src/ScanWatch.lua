local _, ns = ...
local Freshness = ns.Freshness

-- Notes when auction house data arrives, for Price Age in hours. It listens
-- to Blizzard's auction house events only, so it works with whatever addon or
-- window runs the search, and reads nothing from the Price Source.

-- A full scan lists every auction, often tens of thousands, so the pass over
-- it runs this many entries a frame.
local SCAN_BATCH = 2000
-- GetReplicateItemInfo's itemID return.
local REPLICATE_ITEM_ID = 17

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

local function ReplicateItemID(index)
    return (select(REPLICATE_ITEM_ID, C_AuctionHouse.GetReplicateItemInfo(index)))
end

-- A newer scan restarts the pass, and the older one stops at its next batch.
local scanPass = 0

local function ReadFullScan()
    scanPass = scanPass + 1
    local pass, tracked, when = scanPass, TrackedItems(), GetServerTime()
    local count = C_AuctionHouse.GetNumReplicateItems()
    local function Batch(first)
        if pass ~= scanPass then
            return
        end
        local last = math.min(first + SCAN_BATCH, count) - 1
        Freshness.SeenInScan(ReplicateItemID, first, last, tracked, when)
        if last + 1 < count then
            C_Timer.After(0, function()
                Batch(last + 1)
            end)
        else
            ns.SmeltTable.Refresh()
        end
    end
    Batch(0)
end

-- The event also fires while results are still loading, or when none came
-- back; Auctionator then keeps the old price, so only real listings count.
local function ReadCommoditySearch(itemID)
    if TrackedItems()[itemID]
        and C_AuctionHouse.HasFullCommoditySearchResults(itemID)
        and C_AuctionHouse.GetNumCommoditySearchResults(itemID) > 0 then
        Freshness.Seen(itemID, GetServerTime())
        return true
    end
    return false
end

-- A browse list holds only items with listings.
local function ReadBrowseResults(results)
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
        -- The pass refreshes the table when it finishes.
        ReadFullScan()
    elseif event == "COMMODITY_SEARCH_RESULTS_UPDATED" then
        changed = ReadCommoditySearch(payload)
    elseif event == "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED" then
        changed = ReadBrowseResults(C_AuctionHouse.GetBrowseResults())
    else
        changed = ReadBrowseResults(payload)
    end
    if changed then
        ns.SmeltTable.Refresh()
    end
end)
