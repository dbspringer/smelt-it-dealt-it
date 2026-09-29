local _, ns = ...

-- The player's settings and Hidden Recipes, read from the account-wide saved
-- variables with a default for each value. Pure, so the specs can load it.
-- Named Config because Settings is Blizzard's own global.
local Config = {}
ns.Config = Config

-- Whole numbers, as the sliders show them: the Toss-up percent, the Toss-up
-- minimum in copper for one cast, and the stale limit in days. Then the two
-- ways into the Smelt Table besides /smelt.
local DEFAULTS = { percent = 5, minimum = 100, staleDays = 1, ahButton = true, compartment = true }

local db
local listeners = {}

local function Notify()
    for _, listener in ipairs(listeners) do
        listener()
    end
end

function Config.Use(savedVariables)
    db = savedVariables
end

function Config.OnChange(listener)
    table.insert(listeners, listener)
end

-- Each value falls back on its own, so saved data from an older version,
-- with fewer values, still works.
function Config.Get(name)
    local saved = db.settings and db.settings[name]
    if saved == nil then
        return DEFAULTS[name]
    end
    return saved
end

function Config.Set(name, value)
    db.settings = db.settings or {}
    db.settings[name] = value
    Notify()
end

function Config.Threshold()
    return { percent = Config.Get("percent") / 100, minimum = Config.Get("minimum") }
end

function Config.StaleDays()
    return Config.Get("staleDays")
end

-- Keyed on the bar's item ID, the Smelt Recipe's identity.
function Config.IsHidden(bar)
    return db.hidden ~= nil and db.hidden[bar] == true
end

function Config.SetHidden(bar, hidden)
    db.hidden = db.hidden or {}
    db.hidden[bar] = hidden or nil
    Notify()
end

-- In Mining skill order, the Smelt Table's row order.
function Config.VisibleRecipes()
    local visible = {}
    for _, recipe in ipairs(ns.Recipes.All()) do
        if not Config.IsHidden(recipe.bar) then
            table.insert(visible, recipe)
        end
    end
    return visible
end

-- Only this addon's settings. The window position stays.
function Config.Reset()
    db.settings = nil
    db.hidden = nil
    Notify()
end
