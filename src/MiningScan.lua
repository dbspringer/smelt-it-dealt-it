local _, ns = ...
local L = ns.L
local Recipes = ns.Recipes
local Characters = ns.Characters
local RecipeCheck = ns.RecipeCheck

-- Reads the player's own Mining window: records their Known Recipes, checks
-- the built-in Smelt Recipes against the game, and reports any smelt the
-- addon doesn't know.
local MiningScan = {}
ns.MiningScan = MiningScan

-- The "Smelted Bars" category in the Mining window, the same ID in every
-- language. Forever hides unlearned recipes, so only learned smelts show.
local SMELTED_BARS_CATEGORY = 2575
local MINING_SKILL_LINE = 186
-- TRADE_SKILL_LIST_UPDATE fires in bursts; scan once it settles.
local SCAN_DELAY = 0.5

local scanTimer
-- Report each problem once per login, however often the window opens.
local reported = {}

-- Undocumented on Forever, though its own UI calls them, so each one is
-- checked before use.
local function TradeSkillIs(name)
    local check = C_TradeSkillUI[name]
    return check ~= nil and check() and true or false
end

-- Blizzard's own test for "the player's own list": not a linked, guild, or
-- NPC crafting list, which would record someone else's recipes.
local function IsOwnList()
    return not (
        TradeSkillIs("IsNPCCrafting")
        or TradeSkillIs("IsTradeSkillGuild")
        or TradeSkillIs("IsTradeSkillGuildMember")
        or TradeSkillIs("IsTradeSkillLinked")
    )
end

-- The game's side of a recipe, in the shape RecipeCheck compares.
local function GameRecipe(spellID)
    local schematic = C_TradeSkillUI.GetRecipeSchematic(spellID, false)
    if not schematic or not schematic.outputItemID then
        return nil
    end
    local reagents = {}
    for _, slot in ipairs(schematic.reagentSlotSchematics or {}) do
        local reagent = slot.reagents and slot.reagents[1]
        if slot.required ~= false and reagent and reagent.itemID then
            table.insert(reagents, { reagent.itemID, slot.quantityRequired })
        end
    end
    return { bar = schematic.outputItemID, barsMade = schematic.quantityMin, reagents = reagents }
end

-- Checks against the built-in recipe, not a saved correction, so a patch
-- that fixes the built-in data clears the correction again.
local function Check(builtIn, problems)
    local game = GameRecipe(builtIn.spellID)
    if not game then
        return
    end
    local result, corrected = RecipeCheck.Compare(builtIn, game)
    if result == RecipeCheck.SAME then
        Recipes.ClearCorrection(builtIn.bar)
    elseif result == RecipeCheck.DIFFERENT then
        Recipes.Correct(builtIn.bar, corrected)
        table.insert(problems, builtIn.bar)
    else
        table.insert(problems, builtIn.bar)
    end
end

local function Report(problems, unknownNames)
    local names = {}
    for _, bar in ipairs(problems) do
        if not reported[bar] then
            reported[bar] = true
            table.insert(names, ns.Items.Name(bar))
        end
    end
    for _, name in ipairs(unknownNames) do
        if not reported[name] then
            reported[name] = true
            table.insert(names, name)
        end
    end
    if #names > 0 then
        local list = table.concat(names, LIST_DELIMITER or ", ")
        local text = L["Smelt It/Dealt It: these smelts differ from what the addon knows. Please report them: %s"]
        print(string.format(text, list))
    end
end

local function Scan()
    scanTimer = nil
    if C_TradeSkillUI.IsDataSourceChanging() or not IsOwnList() then
        return
    end

    local bySpell = {}
    for _, recipe in ipairs(Recipes.BUILT_IN) do
        bySpell[recipe.spellID] = recipe
    end

    local learned, problems, unknownNames = {}, {}, {}
    for _, spellID in ipairs(C_TradeSkillUI.GetFilteredRecipeIDs()) do
        local info = C_TradeSkillUI.GetRecipeInfo(spellID)
        if info and info.learned then
            local builtIn = bySpell[spellID]
            if builtIn then
                table.insert(learned, builtIn.bar)
                Check(builtIn, problems)
            elseif info.categoryID == SMELTED_BARS_CATEGORY then
                table.insert(unknownNames, info.name)
            end
        end
    end

    -- Any profession window lands here. Only one with a smelt in it is Mining,
    -- and recording nothing from another window changes nothing.
    if #learned > 0 then
        Characters.Record(ns.player.key, ns.player, learned)
        ns.SmeltTable.CharactersChanged()
    end
    Report(problems, unknownNames)
end

-- A login without Mining forgets the character: its smelts are gone.
function MiningScan.CheckLogin()
    local first, second = GetProfessions()
    for _, index in ipairs({ first or 0, second or 0 }) do
        if index > 0 and select(7, GetProfessionInfo(index)) == MINING_SKILL_LINE then
            return
        end
    end
    Characters.Forget(ns.player.key)
end

local events = CreateFrame("Frame")
events:RegisterEvent("TRADE_SKILL_LIST_UPDATE")
events:RegisterEvent("TRADE_SKILL_CLOSE")
events:SetScript("OnEvent", function(_, event)
    if scanTimer then
        scanTimer:Cancel()
        scanTimer = nil
    end
    if event == "TRADE_SKILL_LIST_UPDATE" then
        scanTimer = C_Timer.NewTimer(SCAN_DELAY, Scan)
    end
end)
