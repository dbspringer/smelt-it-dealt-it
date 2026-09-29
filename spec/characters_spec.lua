local function LoadCharacters()
    local ns = {}
    assert(loadfile("src/Characters.lua"))("SmeltItDealtIt", ns)
    ns.Characters.Use({})
    return ns.Characters
end

local THORIUM_BAR, MITHRIL_BAR = 12359, 3860

-- The current character, on realm Home, which is connected to Linked.
local CURRENT = { faction = "Alliance", realm = "Home", realms = { Home = true, Linked = true } }

local function Info(name, realm, faction)
    return { name = name, realm = realm, faction = faction or "Alliance" }
end

describe("Known Recipes", function()
    it("only grow, since a partial or filtered Mining window must not erase any", function()
        local Characters = LoadCharacters()
        Characters.Record("Moxie-Home", Info("Moxie", "Home"), { THORIUM_BAR })
        Characters.Record("Moxie-Home", Info("Moxie", "Home"), { MITHRIL_BAR })

        assert.are.same({ "Moxie" }, Characters.KnownBy(THORIUM_BAR, CURRENT))
        assert.are.same({ "Moxie" }, Characters.KnownBy(MITHRIL_BAR, CURRENT))
    end)

    it("are gone once the character is forgotten", function()
        local Characters = LoadCharacters()
        Characters.Record("Moxie-Home", Info("Moxie", "Home"), { THORIUM_BAR })
        Characters.Forget("Moxie-Home")

        assert.are.same({}, Characters.KnownBy(THORIUM_BAR, CURRENT))
    end)

    it("count only characters the current one can mail to", function()
        local Characters = LoadCharacters()
        Characters.Record("Moxie-Home", Info("Moxie", "Home"), { THORIUM_BAR })
        Characters.Record("Ironbank-Linked", Info("Ironbank", "Linked"), { THORIUM_BAR })
        Characters.Record("Grunt-Home", Info("Grunt", "Home", "Horde"), { THORIUM_BAR })
        Characters.Record("Faraway-Elsewhere", Info("Faraway", "Elsewhere"), { THORIUM_BAR })

        -- A connected realm's name gets its realm, as in the game's mail.
        assert.are.same({ "Ironbank-Linked", "Moxie" }, Characters.KnownBy(THORIUM_BAR, CURRENT))
    end)
end)

describe("Any recorded character", function()
    it("is false on a fresh install", function()
        assert.is_false(LoadCharacters().AnyRecorded(CURRENT))
    end)

    it("ignores characters the current one can't mail to", function()
        local Characters = LoadCharacters()
        Characters.Record("Grunt-Home", Info("Grunt", "Home", "Horde"), { THORIUM_BAR })
        assert.is_false(Characters.AnyRecorded(CURRENT))
    end)

    it("counts a miner who knows no smelts yet", function()
        local Characters = LoadCharacters()
        Characters.Record("Moxie-Home", Info("Moxie", "Home"), {})
        assert.is_true(Characters.AnyRecorded(CURRENT))
    end)
end)
