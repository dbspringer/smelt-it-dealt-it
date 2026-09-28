local _, ns = ...

-- Pure calculations, with no WoW API calls, so the specs can load this file
-- outside the game. Money is in copper and keeps its fractions; only the
-- display rounds.
local Smelt = {}
ns.Smelt = Smelt

-- Verdict keys, not display text: the Smelt Table maps them to ns.L strings.
Smelt.SMELT, Smelt.SELL_RAW, Smelt.TOSS_UP = "SMELT", "SELL_RAW", "TOSS_UP"

-- 5% of the higher value or 1 silver for one cast, whichever is larger.
Smelt.DEFAULT_THRESHOLD = { percent = 0.05, minimum = 100 }

-- The auction house keeps 5% of a sale, and nothing of a purchase.
local AFTER_AH_CUT = 0.95

local function Verdict(difference, higherValue, threshold)
    local limit = math.max(threshold.percent * higherValue, threshold.minimum)
    if math.abs(difference) <= limit then
        return Smelt.TOSS_UP
    end
    return difference > 0 and Smelt.SMELT or Smelt.SELL_RAW
end

-- priceOf(itemID) returns the price in copper (nil for no data) and whether
-- it is a vendor price. The result is { noData = true } when any price is
-- missing, since a Verdict on a partial price would be wrong.
function Smelt.Evaluate(recipe, priceOf, threshold)
    local barPrice = priceOf(recipe.bar)
    if barPrice == nil then
        return { noData = true }
    end

    -- Selling raw earns the auction Reagents' price less the cut, and saves
    -- buying the Vendor Reagents, so those count at their full price.
    local rawValue, reagentCost = 0, 0
    for _, reagent in ipairs(recipe.reagents) do
        local itemID, count = reagent[1], reagent[2]
        local price, isVendor = priceOf(itemID)
        if price == nil then
            return { noData = true }
        end
        local cost = price * count
        reagentCost = reagentCost + cost
        rawValue = rawValue + (isVendor and cost or cost * AFTER_AH_CUT)
    end

    local smeltedValue = barPrice * recipe.barsMade * AFTER_AH_CUT
    local difference = smeltedValue - rawValue
    return {
        rawValue = rawValue,
        smeltedValue = smeltedValue,
        difference = difference,
        verdict = Verdict(difference, math.max(rawValue, smeltedValue), threshold),
        smeltProfit = smeltedValue - reagentCost,
    }
end
