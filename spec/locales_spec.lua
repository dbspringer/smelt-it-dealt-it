-- A missing translation shows English with no error, a stale key does
-- nothing, and a translation that drops a format placeholder raises an error
-- only when that line shows, so none of them would be noticed in the game.

local LOCALES = { "deDE", "frFR", "esES", "ptBR", "ruRU", "koKR", "zhCN", "zhTW" }

-- Every Lua file the TOC loads, except the locales, so a new file can't be
-- left out of the check.
local function SourceFiles()
    local files = {}
    for line in io.lines("SmeltItDealtIt.toc") do
        line = line:gsub("\r", ""):gsub("\\", "/")
        if line:match("%.lua$") and not line:match("^#") and not line:match("^locales/") then
            table.insert(files, line)
        end
    end
    return files
end

local function KeysUsedInCode()
    local keys = {}
    for _, path in ipairs(SourceFiles()) do
        local source = assert(io.open(path)):read("*a")
        for key in source:gmatch('L%["(.-)"%]') do
            keys[key] = true
        end
    end
    return keys
end

-- The strings a locale file gives on a client that runs clientLocale.
local function Translations(file, clientLocale)
    _G.GetLocale = function()
        return clientLocale
    end
    local ns = { L = {} }
    assert(loadfile("locales/" .. file .. ".lua"))("SmeltItDealtIt", ns)
    return ns.L
end

local function KeySet(strings)
    local keys = {}
    for key in pairs(strings) do
        keys[key] = true
    end
    return keys
end

-- The format placeholders of a string, in order, so %s and %d can't swap.
local function Placeholders(text)
    local found = {}
    for placeholder in text:gmatch("%%[%%%a]") do
        table.insert(found, placeholder)
    end
    return found
end

describe("Translations", function()
    local used = KeysUsedInCode()

    it("find the code's keys through the TOC", function()
        assert.is_true(used["Smelt"])
        assert.is_true(used["Stale after"])
    end)

    for _, locale in ipairs(LOCALES) do
        it(locale .. " has exactly the strings the code shows", function()
            assert.are.same(used, KeySet(Translations(locale, locale)))
        end)

        it(locale .. " keeps every format placeholder, in order", function()
            for key, text in pairs(Translations(locale, locale)) do
                assert.are.same(Placeholders(key), Placeholders(text), locale .. ": " .. key)
            end
        end)
    end

    it("stay out of the way on a client with another language", function()
        assert.are.same({}, KeySet(Translations("deDE", "enUS")))
    end)

    it("esES also serves Latin American Spanish clients", function()
        assert.are.same(used, KeySet(Translations("esES", "esMX")))
    end)
end)
