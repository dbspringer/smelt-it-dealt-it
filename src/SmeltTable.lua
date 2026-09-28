local addonName, ns = ...
local L = ns.L
local Smelt = ns.Smelt
local PriceSource = ns.PriceSource
local Config = ns.Config
local Items = ns.Items

-- The Smelt Table window: one row for each Smelt Recipe that is not hidden,
-- in Mining skill order.
local SmeltTable = {}
ns.SmeltTable = SmeltTable

local FRAME_NAME = "SmeltItDealtItFrame"
local ROW_HEIGHT = 24
local ICON_SIZE = 18
local PADDING = 8
-- ButtonFrameTemplate's title bar and borders around the inset.
local CHROME_WIDTH, CHROME_HEIGHT = 12, 70
local STALE_ICON = "Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew"
local OPTIONS_ICON = "Interface\\Buttons\\UI-OptionsButton"
local NO_VALUE = "-"

local COLUMNS = {
    { key = "bar", width = 180, justify = "LEFT", header = L["Bar"],
      tip = L["The bar that one smelt makes, and how many."] },
    { key = "reagents", width = 110, justify = "LEFT", header = L["Reagents"],
      tip = L["What one smelt uses up."] },
    { key = "raw", width = 95, header = L["Raw Value"],
      tip = L["What you keep if you sell the reagents as they are, after the 5% auction house cut."] },
    { key = "smelted", width = 95, header = L["Smelted Value"],
      tip = L["What you get for the bars, after the 5% auction house cut."] },
    { key = "difference", width = 95, header = L["Difference"],
      tip = L["Smelted Value minus Raw Value."] },
    { key = "verdict", width = 80, header = L["Verdict"],
      tip = L["Smelt or Sell Raw, or Toss-up when the difference is too small to be worth the time."] },
    { key = "profit", width = 95, header = L["Smelt Profit"],
      tip = L["What you make if you buy the reagents at these prices, smelt them, and sell the bars."] },
    { key = "stale", width = 20 },
}

local TABLE_WIDTH = 0
for _, column in ipairs(COLUMNS) do
    column.x = TABLE_WIDTH
    TABLE_WIDTH = TABLE_WIDTH + column.width
end

local VERDICTS = {
    [Smelt.SMELT] = { text = L["Smelt"], color = GREEN_FONT_COLOR },
    [Smelt.SELL_RAW] = { text = L["Sell Raw"], color = RED_FONT_COLOR },
    [Smelt.TOSS_UP] = { text = L["Toss-up"], color = GRAY_FONT_COLOR },
}

local frame
-- One row for every Smelt Recipe, keyed on the bar. Hidden ones stay built.
local rows = {}
local visibleRows = {}

-- GetMoneyString takes whole, positive copper, so the sign is added here.
-- Rounding toward zero matches Auctionator's display.
local function Money(copper)
    return GetMoneyString(math.floor(math.abs(copper)), true)
end

local function SignedMoney(copper)
    if copper >= 1 then
        return "+" .. Money(copper)
    elseif copper <= -1 then
        return "-" .. Money(copper)
    end
    return Money(copper)
end

local function CountedName(itemID, count)
    if count > 1 then
        return string.format(L["%s x%d"], Items.Name(itemID), count)
    end
    return Items.Name(itemID)
end

local function IsStale(price, isVendor, age)
    return price ~= nil and not isVendor and (age == nil or age >= Config.StaleDays())
end

local function AgeText(isVendor, age)
    if isVendor then
        return L["vendor price"]
    elseif age == nil then
        return L["age unknown"]
    elseif age == 0 then
        return L["seen today"]
    elseif age == 1 then
        return L["seen yesterday"]
    end
    return string.format(L["seen %d days ago"], age)
end

-- Every item a row prices: its Reagents, then its bar.
local function EachItem(recipe, callback)
    for _, reagent in ipairs(recipe.reagents) do
        callback(reagent[1], reagent[2])
    end
    callback(recipe.bar, recipe.barsMade)
end

local function AddPriceLine(itemID, count)
    local price, isVendor, age = PriceSource.Lookup(itemID)
    local label = CountedName(itemID, count)
    if price == nil then
        GameTooltip:AddDoubleLine(label, L["no price"], 1, 1, 1, GRAY_FONT_COLOR:GetRGB())
        return
    end
    local color = IsStale(price, isVendor, age) and RED_FONT_COLOR or HIGHLIGHT_FONT_COLOR
    local text = string.format(L["%s each, %s"], Money(price), AgeText(isVendor, age))
    GameTooltip:AddDoubleLine(label, text, 1, 1, 1, color:GetRGB())
end

local function ShowRowTooltip(row)
    local recipe = row.recipe
    GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
    GameTooltip_SetTitle(GameTooltip, Items.Name(recipe.bar))
    EachItem(recipe, AddPriceLine)
    if recipe.blackForge then
        GameTooltip:AddLine(L["Smelt only at the Black Forge."], 1, 1, 1, true)
    end
    GameTooltip:Show()
end

local function ShowHeaderTooltip(cell)
    GameTooltip:SetOwner(cell, "ANCHOR_TOP")
    GameTooltip_SetTitle(GameTooltip, cell.column.header)
    GameTooltip:AddLine(cell.column.tip, 1, 1, 1, true)
    GameTooltip:Show()
end

local function ShowOptionsTooltip(button)
    GameTooltip:SetOwner(button, "ANCHOR_TOP")
    GameTooltip_SetTitle(GameTooltip, L["Options"])
    GameTooltip:Show()
end

local function HideTooltip()
    GameTooltip:Hide()
end

local function AddText(parent, column, template)
    local text = parent:CreateFontString(nil, "ARTWORK", template)
    text:SetPoint("LEFT", parent, "LEFT", column.x, 0)
    text:SetWidth(column.width - 6)
    text:SetJustifyH(column.justify or "RIGHT")
    text:SetWordWrap(false)
    return text
end

local function AddIcon(parent, itemID, x)
    local icon = parent:CreateTexture(nil, "ARTWORK")
    icon:SetSize(ICON_SIZE, ICON_SIZE)
    icon:SetPoint("LEFT", parent, "LEFT", x, 0)
    icon:SetTexture(Items.Icon(itemID))
    return icon
end

local function ColumnByKey(key)
    for _, column in ipairs(COLUMNS) do
        if column.key == key then
            return column
        end
    end
end

local function CreateHeader(parent)
    local header = CreateFrame("Frame", nil, parent)
    header:SetSize(TABLE_WIDTH, ROW_HEIGHT)
    header:SetPoint("TOPLEFT", PADDING, -PADDING)
    for _, column in ipairs(COLUMNS) do
        if column.header then
            local cell = CreateFrame("Frame", nil, header)
            cell:SetPoint("LEFT", column.x, 0)
            cell:SetSize(column.width, ROW_HEIGHT)
            cell.column = column
            cell:SetScript("OnEnter", ShowHeaderTooltip)
            cell:SetScript("OnLeave", HideTooltip)
            AddText(header, column, "GameFontNormal"):SetText(column.header)
        end
    end
    return header
end

local function CreateRow(parent, recipe)
    local row = CreateFrame("Frame", nil, parent)
    row:SetSize(TABLE_WIDTH, ROW_HEIGHT)
    row:EnableMouse(true)
    row:SetScript("OnEnter", ShowRowTooltip)
    row:SetScript("OnLeave", HideTooltip)
    row.recipe = recipe

    local barColumn = ColumnByKey("bar")
    AddIcon(row, recipe.bar, barColumn.x)
    row.bar = row:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    row.bar:SetPoint("LEFT", row, "LEFT", barColumn.x + ICON_SIZE + 4, 0)
    row.bar:SetWidth(barColumn.width - ICON_SIZE - 10)
    row.bar:SetJustifyH("LEFT")
    row.bar:SetWordWrap(false)
    local function ShowBarName()
        row.bar:SetText(CountedName(recipe.bar, recipe.barsMade))
    end
    ShowBarName()
    Items.Load(recipe.bar, ShowBarName)

    local x = ColumnByKey("reagents").x
    for _, reagent in ipairs(recipe.reagents) do
        local icon = AddIcon(row, reagent[1], x)
        if reagent[2] > 1 then
            local count = row:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmall")
            count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
            count:SetText(reagent[2])
        end
        Items.Load(reagent[1])
        x = x + ICON_SIZE + 6
    end

    for _, key in ipairs({ "raw", "smelted", "difference", "verdict", "profit" }) do
        row[key] = AddText(row, ColumnByKey(key), "GameFontHighlight")
    end

    row.stale = row:CreateTexture(nil, "ARTWORK")
    row.stale:SetSize(14, 14)
    row.stale:SetPoint("LEFT", row, "LEFT", ColumnByKey("stale").x + 4, 0)
    row.stale:SetTexture(STALE_ICON)
    return row
end

local function ShowRow(row)
    local result = Smelt.Evaluate(row.recipe, PriceSource.Lookup, Config.Threshold())

    local stale = false
    EachItem(row.recipe, function(itemID)
        stale = stale or IsStale(PriceSource.Lookup(itemID))
    end)
    row.stale:SetShown(stale)

    if result.noData then
        for _, key in ipairs({ "raw", "smelted", "difference", "profit" }) do
            row[key]:SetText(NO_VALUE)
        end
        row.verdict:SetText(L["No data"])
        row.verdict:SetTextColor(GRAY_FONT_COLOR:GetRGB())
        return false
    end

    row.raw:SetText(Money(result.rawValue))
    row.smelted:SetText(Money(result.smeltedValue))
    row.difference:SetText(SignedMoney(result.difference))
    row.profit:SetText(SignedMoney(result.smeltProfit))
    local verdict = VERDICTS[result.verdict]
    row.verdict:SetText(verdict.text)
    row.verdict:SetTextColor(verdict.color:GetRGB())
    return true
end

function SmeltTable.NoPriceSourceMessage()
    local names = table.concat(PriceSource.SupportedNames(), LIST_DELIMITER or ", ")
    return string.format(L["Smelt It/Dealt It needs a price addon. Install or enable one of: %s"], names)
end

-- The table shows either rows or one line that says why it has none.
local function ShowMessage(text)
    frame.content:SetShown(text == nil)
    frame.message:SetText(text or "")
    frame.message:SetShown(text ~= nil)
end

function SmeltTable.Refresh()
    if not frame or not frame:IsShown() then
        return
    end

    if not PriceSource.IsAvailable() then
        ShowMessage(SmeltTable.NoPriceSourceMessage())
        return
    end
    if #visibleRows == 0 then
        ShowMessage(L["Every Smelt Recipe is hidden. Show some in the options."])
        return
    end

    local anyPrices = false
    for _, row in ipairs(visibleRows) do
        anyPrices = ShowRow(row) or anyPrices
    end
    if anyPrices then
        ShowMessage(nil)
    else
        ShowMessage(string.format(L["Scan the auction house with %s to see prices."], PriceSource.ActiveName()))
    end
end

-- Stacks the visible rows and fits the window to them, at least one row high
-- so the message has room.
local function Layout()
    visibleRows = {}
    for _, row in pairs(rows) do
        row:Hide()
    end
    for index, recipe in ipairs(Config.VisibleRecipes()) do
        local row = rows[recipe.bar]
        row:SetPoint("TOPLEFT", PADDING, -PADDING - index * ROW_HEIGHT)
        row:Show()
        table.insert(visibleRows, row)
    end
    local tableHeight = (math.max(#visibleRows, 1) + 1) * ROW_HEIGHT + 2 * PADDING
    frame:SetSize(TABLE_WIDTH + 2 * PADDING + CHROME_WIDTH, tableHeight + CHROME_HEIGHT)
end

local function SavePosition()
    local point, _, relativePoint, x, y = frame:GetPoint()
    ns.db.window = { point = point, relativePoint = relativePoint, x = x, y = y }
end

local function RestorePosition()
    local window = ns.db.window
    frame:ClearAllPoints()
    if window then
        frame:SetPoint(window.point, UIParent, window.relativePoint, window.x, window.y)
    else
        frame:SetPoint("CENTER")
    end
end

local function CreateOptionsButton()
    local button = CreateFrame("Button", nil, frame)
    button:SetSize(16, 16)
    button:SetPoint("RIGHT", frame.CloseButton, "LEFT", -2, 0)
    button:SetNormalTexture(OPTIONS_ICON)
    button:SetHighlightTexture(OPTIONS_ICON, "ADD")
    button:SetScript("OnClick", function()
        ns.Options.Open()
    end)
    button:SetScript("OnEnter", ShowOptionsTooltip)
    button:SetScript("OnLeave", HideTooltip)
end

local function Create()
    frame = CreateFrame("Frame", FRAME_NAME, UIParent, "ButtonFrameTemplate")
    ButtonFrameTemplate_HidePortrait(frame)
    ButtonFrameTemplate_HideButtonBar(frame)
    frame:SetTitle(C_AddOns.GetAddOnMetadata(addonName, "Title"))
    frame:SetToplevel(true)
    frame:SetClampedToScreen(true)
    frame:Hide()

    -- Saved in the addon's own table rather than the client layout cache,
    -- which is less reliable for addon frames.
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
        frame:SetUserPlaced(false)
        SavePosition()
    end)
    table.insert(UISpecialFrames, FRAME_NAME)
    CreateOptionsButton()

    frame.content = CreateFrame("Frame", nil, frame.Inset)
    frame.content:SetAllPoints()
    CreateHeader(frame.content)
    for _, recipe in ipairs(ns.Recipes) do
        rows[recipe.bar] = CreateRow(frame.content, recipe)
    end

    frame.message = frame.Inset:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.message:SetPoint("TOPLEFT", PADDING * 2, -PADDING * 2)
    frame.message:SetPoint("RIGHT", -PADDING * 2, 0)
    frame.message:SetJustifyH("LEFT")

    frame:SetScript("OnShow", SmeltTable.Refresh)
    Layout()
    RestorePosition()
end

function SmeltTable.Toggle()
    if not frame then
        Create()
    end
    frame:SetShown(not frame:IsShown())
end

-- Auctionator fires this after every search it processes, so it only redraws
-- while the table is open.
PriceSource.OnChange(function()
    SmeltTable.Refresh()
end)

-- Settings apply at once: a slider or checkbox redraws the open table.
Config.OnChange(function()
    if frame then
        Layout()
        SmeltTable.Refresh()
    end
end)
