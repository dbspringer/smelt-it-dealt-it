local _, ns = ...

-- Price Age in hours. The Price Source only knows whole days, so the addon
-- keeps its own record of when it saw auction house data: the last full scan,
-- and each item a search or browse listed. Pure, so the specs can load it.
local Freshness = {}
ns.Freshness = Freshness

local HOUR = 3600

-- { fullScan = time, seen = { [itemID] = time } } for the current realm,
-- whose auction house the prices come from.
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

function Freshness.FullScan(when)
    record.fullScan = when
end

-- Returns the hours since the item was seen, and whether that is exact.
-- auctionAge is the Price Source's whole days (0 is today, nil unknown).
function Freshness.AgeHours(itemID, auctionAge, now)
    local seen = record.seen[itemID]
    -- A full scan saw the item only if the Price Source has it as seen today.
    if auctionAge == 0 and record.fullScan and (seen == nil or record.fullScan > seen) then
        seen = record.fullScan
    end
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
