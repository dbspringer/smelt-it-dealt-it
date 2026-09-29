local _, ns = ...

-- Each character's Known Recipes, account-wide, so every character can see
-- what the others can smelt. Pure, so the specs can load it.
--
-- A record is { name, realm, faction, known = { [bar] = true } }, keyed on
-- "Name-Realm". The current character is { faction, realm, realms }, where
-- realms is a set of the realms it can mail to.
local Characters = {}
ns.Characters = Characters

local records = {}

function Characters.Use(saved)
    records = saved
end

-- Adds, never removes: a filtered or partial Mining window must not erase a
-- recipe, and a smelt can't be unlearned short of dropping Mining.
function Characters.Record(key, info, bars)
    local record = records[key] or { known = {} }
    record.name, record.realm, record.faction = info.name, info.realm, info.faction
    for _, bar in ipairs(bars) do
        record.known[bar] = true
    end
    records[key] = record
end

function Characters.Forget(key)
    records[key] = nil
end

-- The Mailable Character rule: same faction, same or connected realm.
local function IsMailable(record, current)
    return record.faction == current.faction and current.realms[record.realm] == true
end

-- Sorted, and with the realm on names from a connected realm, as in the
-- game's mail.
function Characters.KnownBy(bar, current)
    local names = {}
    for _, record in pairs(records) do
        if IsMailable(record, current) and record.known[bar] then
            if record.realm == current.realm then
                table.insert(names, record.name)
            else
                table.insert(names, record.name .. "-" .. record.realm)
            end
        end
    end
    table.sort(names)
    return names
end

-- Whether any Mailable Character has opened the Mining window, so the table
-- knows enough to grey out what none of them can smelt.
function Characters.AnyRecorded(current)
    for _, record in pairs(records) do
        if IsMailable(record, current) then
            return true
        end
    end
    return false
end
