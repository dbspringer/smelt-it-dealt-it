local addonName, ns = ...
local L = ns.L
local Config = ns.Config

-- The two ways into the Smelt Table besides /smelt: a button on the auction
-- house and an addon compartment entry. The options can turn each one off.
local Access = {}
ns.Access = Access

-- A bar from vanilla, so every client has it. The TOC's IconTexture matches.
local ICON = "Interface\\Icons\\INV_Ingot_03"
local AUCTION_HOUSE_UI = "Blizzard_AuctionHouseUI"

local function ShowTooltip(owner)
    GameTooltip:SetOwner(owner, "ANCHOR_LEFT")
    GameTooltip_SetTitle(GameTooltip, C_AddOns.GetAddOnMetadata(addonName, "Title"))
    GameTooltip:AddLine(L["Open the Smelt Table."], 1, 1, 1, true)
    GameTooltip:Show()
end

local function HideTooltip()
    GameTooltip:Hide()
end

local function ToggleTable()
    ns.SmeltTable.Toggle()
end

-- Auction house button --------------------------------------------------------

local auctionHouseButton

-- Our own button as a child of the auction house frame, so it shows and hides
-- with it. It never writes to that frame or calls its methods, which keeps
-- purchases untainted. The title bar left of the close button is the one spot
-- Auctionator leaves free: it adds bottom tabs and a panel off the right edge.
local function CreateAuctionHouseButton()
    local closeButton = AuctionHouseFrame.CloseButton
    auctionHouseButton = CreateFrame("Button", nil, AuctionHouseFrame)
    auctionHouseButton:SetSize(16, 16)
    auctionHouseButton:SetPoint("RIGHT", closeButton, "LEFT", -2, 0)
    -- Above the template's title bar art, as with the Smelt Table's gear.
    auctionHouseButton:SetFrameLevel(closeButton:GetFrameLevel())
    auctionHouseButton:SetNormalTexture(ICON)
    auctionHouseButton:SetHighlightTexture(ICON, "ADD")
    -- Crop the item icon's border.
    auctionHouseButton:GetNormalTexture():SetTexCoord(0.08, 0.92, 0.08, 0.92)
    auctionHouseButton:GetHighlightTexture():SetTexCoord(0.08, 0.92, 0.08, 0.92)
    auctionHouseButton:SetScript("OnClick", ToggleTable)
    auctionHouseButton:SetScript("OnEnter", ShowTooltip)
    auctionHouseButton:SetScript("OnLeave", HideTooltip)
end

local function UpdateAuctionHouseButton()
    if auctionHouseButton then
        auctionHouseButton:SetShown(Config.Get("ahButton"))
    end
end

-- The auction house UI loads the first time the player opens the auction
-- house, so the button waits for it.
local function OnAuctionHouseLoaded()
    CreateAuctionHouseButton()
    UpdateAuctionHouseButton()
end

-- Addon compartment -----------------------------------------------------------

local compartmentEntry = {
    text = C_AddOns.GetAddOnMetadata(addonName, "Title"),
    icon = ICON,
    func = ToggleTable,
    funcOnEnter = ShowTooltip,
    funcOnLeave = HideTooltip,
}

local function CompartmentIndex()
    for index, entry in ipairs(AddonCompartmentFrame.registeredAddons) do
        if entry == compartmentEntry then
            return index
        end
    end
end

-- Blizzard has no way to remove an entry, so turning it off takes ours out of
-- the compartment's list by identity, the way LibDBIcon does. This is the one
-- place the addon writes to Blizzard's data; see the taint rule in AGENTS.md.
local function UpdateCompartment()
    if not AddonCompartmentFrame then
        return
    end
    local index = CompartmentIndex()
    if Config.Get("compartment") and not index then
        AddonCompartmentFrame:RegisterAddon(compartmentEntry)
    elseif not Config.Get("compartment") and index then
        table.remove(AddonCompartmentFrame.registeredAddons, index)
        AddonCompartmentFrame:UpdateDisplay()
    end
end

-- Setup -----------------------------------------------------------------------

function Access.Register()
    UpdateCompartment()

    if C_AddOns.IsAddOnLoaded(AUCTION_HOUSE_UI) then
        OnAuctionHouseLoaded()
    else
        local events = CreateFrame("Frame")
        events:RegisterEvent("ADDON_LOADED")
        events:SetScript("OnEvent", function(self, _, name)
            if name == AUCTION_HOUSE_UI then
                self:UnregisterEvent("ADDON_LOADED")
                OnAuctionHouseLoaded()
            end
        end)
    end

    Config.OnChange(function()
        UpdateAuctionHouseButton()
        UpdateCompartment()
    end)
end
