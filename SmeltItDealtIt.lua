local addonName, ns = ...

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:SetScript("OnEvent", function(_, event, name)
    if event == "ADDON_LOADED" and name == addonName then
        -- One account-wide table: Known Recipes must be readable from every
        -- character, so nothing lives in per-character saved variables.
        SmeltItDealtItDB = SmeltItDealtItDB or {}
        ns.db = SmeltItDealtItDB
    elseif event == "PLAYER_LOGIN" then
        -- Every OptionalDeps price addon has loaded by now, and Auctionator
        -- builds its price data on this event, so no price is read earlier.
        ns.PriceSource.Select()
        if not ns.PriceSource.IsAvailable() then
            print(ns.SmeltTable.NoPriceSourceMessage())
        end
    end
end)

SLASH_SMELTITDEALTIT1 = "/smelt"
SLASH_SMELTITDEALTIT2 = "/sidi"
SlashCmdList.SMELTITDEALTIT = function()
    ns.SmeltTable.Toggle()
end
