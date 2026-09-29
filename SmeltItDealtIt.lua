local addonName, ns = ...
local L = ns.L

-- Who is logged in, and which realms they can mail to (their own, plus any
-- connected realms), for the Mailable Character rule.
local function CurrentPlayer()
    local name, realm = UnitName("player"), GetNormalizedRealmName()
    local realms = { [realm] = true }
    for _, connected in ipairs(GetAutoCompleteRealms() or {}) do
        realms[connected] = true
    end
    return {
        key = name .. "-" .. realm,
        name = name,
        realm = realm,
        faction = UnitFactionGroup("player"),
        realms = realms,
    }
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:SetScript("OnEvent", function(_, event, name)
    if event == "ADDON_LOADED" and name == addonName then
        -- One account-wide table: Known Recipes must be readable from every
        -- character, so nothing lives in per-character saved variables.
        SmeltItDealtItDB = SmeltItDealtItDB or {}
        ns.db = SmeltItDealtItDB
        ns.db.characters = ns.db.characters or {}
        ns.db.corrections = ns.db.corrections or {}
        ns.db.freshness = ns.db.freshness or {}
        ns.Config.Use(ns.db)
        ns.Characters.Use(ns.db.characters)
        ns.Recipes.UseCorrections(ns.db.corrections)
    elseif event == "PLAYER_LOGIN" then
        ns.player = CurrentPlayer()
        -- Each realm has its own auction house and prices.
        ns.db.freshness[ns.player.realm] = ns.db.freshness[ns.player.realm] or {}
        ns.Freshness.Use(ns.db.freshness[ns.player.realm])
        ns.MiningScan.CheckLogin()
        -- Every OptionalDeps price addon has loaded by now, and Auctionator
        -- builds its price data on this event, so no price is read earlier.
        ns.PriceSource.Select()
        if not ns.PriceSource.IsAvailable() then
            print(ns.SmeltTable.NoPriceSourceMessage())
        end
        ns.Options.Register()
        ns.Access.Register()
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
