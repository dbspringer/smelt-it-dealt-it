local addonName, ns = ...
local L = ns.L

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:SetScript("OnEvent", function(_, event, name)
    if event == "ADDON_LOADED" and name == addonName then
        -- One account-wide table: Known Recipes must be readable from every
        -- character, so nothing lives in per-character saved variables.
        SmeltItDealtItDB = SmeltItDealtItDB or {}
        ns.db = SmeltItDealtItDB
        ns.Config.Use(SmeltItDealtItDB)
    elseif event == "PLAYER_LOGIN" then
        -- Every OptionalDeps price addon has loaded by now, and Auctionator
        -- builds its price data on this event, so no price is read earlier.
        ns.PriceSource.Select()
        if not ns.PriceSource.IsAvailable() then
            print(ns.SmeltTable.NoPriceSourceMessage())
        end
        ns.Options.Register()
    end
end)

SLASH_SMELTITDEALTIT1 = "/smelt"
SLASH_SMELTITDEALTIT2 = "/sidi"
-- The command words stay English in every locale, so macros travel.
SlashCmdList.SMELTITDEALTIT = function(message)
    local word = message:lower():match("^%s*(%S*)")
    if word == "" then
        ns.SmeltTable.Toggle()
    elseif word == "options" or word == "config" then
        ns.Options.Open()
    else
        print(L["/smelt opens the Smelt Table, and /smelt options opens the options."])
    end
end
