local addonName, ns = ...
local L = ns.L
local Config = ns.Config
local Items = ns.Items

-- The options panel in Options > AddOns. Every change applies at once.
local Options = {}
ns.Options = Options

local SLIDER_LEFT = 180
local RECIPE_COLUMNS = 2
local RECIPE_COLUMN_WIDTH = 260
local ICON_SIZE = 18

local category
-- Whether Options.Open closed an open Smelt Table.
local reopenTable = false

local function AddSectionHeader(panel, anchor, text)
    local header = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    header:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -30)
    header:SetText(text)
    return header
end

local function AddBodyText(panel, anchor, text)
    local body = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    body:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -10)
    body:SetPoint("RIGHT", -20, 0)
    body:SetJustifyH("LEFT")
    body:SetText(text)
    return body
end

-- A label with a slider at a fixed distance, so the sliders of all rows line
-- up. The slider shows its value, and a word at each end says what it does.
-- From SCT Mover.
local function AddSliderRow(panel, anchor, gap, text, min, max, minText, maxText, format)
    local label = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -gap)
    label:SetText(text)

    local Label = MinimalSliderWithSteppersMixin.Label
    local slider = CreateFrame("Frame", nil, panel, "MinimalSliderWithSteppersTemplate")
    slider:SetPoint("LEFT", label, "LEFT", SLIDER_LEFT, 0)
    slider:SetWidth(250)
    slider:Init(min, min, max, max - min, {
        [Label.Right] = format,
        [Label.Min] = CreateMinimalSliderFormatter(Label.Min, minText),
        [Label.Max] = CreateMinimalSliderFormatter(Label.Max, maxText),
    })
    return label, slider
end

-- Ties a slider to one setting. The stored value can differ from what the
-- slider shows (copper vs. silver), so each side converts. A refresh also
-- fires the change callback; the write only happens when the value moved.
local function BindSlider(panel, slider, name, toSlider, fromSlider)
    slider:RegisterCallback("OnValueChanged", function(_, value)
        local stored = fromSlider(value)
        if stored ~= Config.Get(name) then
            Config.Set(name, stored)
        end
    end, panel)
    return function()
        slider:SetValue(toSlider(Config.Get(name)))
    end
end

local function Same(value)
    return value
end

local function AddVerdictSection(panel, anchor)
    local header = AddSectionHeader(panel, anchor, L["Verdict"])
    local description = AddBodyText(
        panel,
        header,
        L["A difference at or below the larger of these two is a Toss-up: too small to be worth the time to smelt."]
    )

    local percentLabel, percent = AddSliderRow(
        panel, description, 30, L["Toss-up percent"], 0, 25, L["Any gain"], L["Big gains only"],
        function(value)
            return string.format(L["%d%%"], value)
        end
    )
    local minimumLabel, minimum = AddSliderRow(
        panel, percentLabel, 40, L["Toss-up minimum"], 0, 50, L["Any gain"], L["Big gains only"],
        function(silver)
            return GetMoneyString(silver * 100, true)
        end
    )

    local refreshPercent = BindSlider(panel, percent, "percent", Same, Same)
    -- The minimum is saved in copper and chosen in whole silver.
    local refreshMinimum = BindSlider(panel, minimum, "minimum", function(copper)
        return math.floor(copper / 100)
    end, function(silver)
        return silver * 100
    end)

    return minimumLabel, function()
        refreshPercent()
        refreshMinimum()
    end
end

local function AddPricesSection(panel, anchor)
    local header = AddSectionHeader(panel, anchor, L["Prices"])
    local description = AddBodyText(
        panel,
        header,
        L["An auction price not seen for this long gets a warning icon in the Smelt Table."]
    )

    local label, slider = AddSliderRow(
        panel, description, 30, L["Stale after"], 1, 14, L["Today only"], L["Two weeks"],
        function(days)
            if days == 1 then
                return L["1 day"]
            end
            return string.format(L["%d days"], days)
        end
    )
    return label, BindSlider(panel, slider, "staleDays", Same, Same)
end

local function AddRecipeCheckbox(panel, header, recipe, index)
    local column = (index - 1) % RECIPE_COLUMNS
    local line = math.floor((index - 1) / RECIPE_COLUMNS)

    local checkbox = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
    checkbox:SetPoint("TOPLEFT", header, "BOTTOMLEFT", column * RECIPE_COLUMN_WIDTH - 4, -10 - line * 28)
    checkbox:SetScript("OnClick", function(self)
        Config.SetHidden(recipe.bar, not self:GetChecked())
    end)

    local icon = panel:CreateTexture(nil, "ARTWORK")
    icon:SetSize(ICON_SIZE, ICON_SIZE)
    icon:SetPoint("LEFT", checkbox, "RIGHT", 2, 0)
    icon:SetTexture(Items.Icon(recipe.bar))

    local label = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    label:SetPoint("LEFT", icon, "RIGHT", 6, 0)
    local function ShowName()
        label:SetText(Items.Name(recipe.bar))
    end
    ShowName()
    Items.Load(recipe.bar, ShowName)

    return checkbox
end

local function AddRecipesSection(panel, anchor)
    local header = AddSectionHeader(panel, anchor, L["Smelt Recipes"])
    local description = AddBodyText(panel, header, L["Unchecked recipes leave the Smelt Table."])

    local checkboxes = {}
    local last
    for index, recipe in ipairs(ns.Recipes.All()) do
        checkboxes[recipe.bar] = AddRecipeCheckbox(panel, description, recipe, index)
        last = checkboxes[recipe.bar]
    end

    return last, function()
        for bar, checkbox in pairs(checkboxes) do
            checkbox:SetChecked(not Config.IsHidden(bar))
        end
    end
end

-- A canvas category, because the list view comes with a Defaults button that
-- also offers to reset every game setting. Ours resets only this addon's.
function Options.Register()
    local title = C_AddOns.GetAddOnMetadata(addonName, "Title")
    local panel = CreateFrame("Frame")

    local header = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
    header:SetPoint("TOPLEFT", 7, -22)
    header:SetText(title)

    local verdictBottom, refreshVerdict = AddVerdictSection(panel, header)
    local pricesBottom, refreshPrices = AddPricesSection(panel, verdictBottom)
    local recipesBottom, refreshRecipes = AddRecipesSection(panel, pricesBottom)

    local function Refresh()
        refreshVerdict()
        refreshPrices()
        refreshRecipes()
    end

    local reset = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    reset:SetPoint("TOPLEFT", recipesBottom, "BOTTOMLEFT", 4, -24)
    reset:SetText(L["Reset to defaults"])
    reset:SetWidth(reset:GetTextWidth() + 40)
    reset:SetScript("OnClick", function()
        Config.Reset()
        Refresh()
    end)

    -- The panel calls this each time it shows the category.
    panel.OnRefresh = Refresh

    category = Settings.RegisterCanvasLayoutCategory(panel, title)
    Settings.RegisterAddOnCategory(category)

    -- A post-hook only: it changes nothing on Blizzard's frame. Closing the
    -- panel goes on to hide the Smelt Table after OnHide, so the table comes
    -- back on the next frame instead.
    SettingsPanel:HookScript("OnHide", function()
        if reopenTable then
            reopenTable = false
            C_Timer.After(0, ns.SmeltTable.Show)
        end
    end)
end

function Options.Open()
    if InCombatLockdown() then
        -- The game blocks addons from opening the options in combat.
        UIErrorsFrame:AddMessage(ERR_NOT_IN_COMBAT, 1, 0.1, 0.1)
        return
    end
    -- Opening the options closes the Smelt Table, and the options panel would
    -- cover it anyway, so it comes back when the options close.
    reopenTable = ns.SmeltTable.IsShown()
    Settings.OpenToCategory(category:GetID())
end
