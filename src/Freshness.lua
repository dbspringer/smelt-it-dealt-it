local _, ns = ...

-- Price Age in hours. The Price Source only knows whole days, so the addon
-- keeps its own record of when it saw each item listed on the auction house:
-- in a full scan, a search, or a browse. Pure, so the specs can load it.
local Freshness = {}
ns.Freshness = Freshness

local HOUR = 3600

-- { seen = { [itemID] = time } } for the current realm, whose auction house
-- the prices come from.
local record = { seen = {} }

function Freshness.Use(saved)
    record = saved
    record.seen = record.seen or {}
end

function Freshness.Seen(itemID, when)
    if (record.seen[itemID] or 0) < when then
        record.seen[itemID] = when
    end
end

-- Marks the tracked items a full scan lists, over the indices first..last.
-- itemAt(index) gives the item at an index, or nil while the game hasn't
-- loaded it. Only listed items count: one the scan missed keeps its older
-- sighting, so its price can't look fresh.
function Freshness.SeenInScan(itemAt, first, last, tracked, when)
    for index = first, last do
        local itemID = itemAt(index)
        if itemID and tracked[itemID] then
            Freshness.Seen(itemID, when)
        end
    end
end

-- Returns the hours since the item was seen, and whether that is exact.
-- auctionAge is the Price Source's whole days (0 is today, nil unknown).
function Freshness.AgeHours(itemID, auctionAge, now)
    local seen = record.seen[itemID]
    if seen then
        return (now - seen) / HOUR, true
    end
    if auctionAge == nil then
        return nil
    end
    -- Seen d days ago means up to d + 1 days ago; assume the oldest.
    return (auctionAge + 1) * 24, false
end

-- An unknown age is stale, and a day age counts at its oldest, so an old
-- price never looks fresh.
function Freshness.IsStale(itemID, auctionAge, now, limitHours)
    local hours = Freshness.AgeHours(itemID, auctionAge, now)
    return hours == nil or hours > limitHours
end
