local _, ns = ...

-- Localized item names and icons from the client. Names can arrive after the
-- first ask, so Load tells the caller when one does.
local Items = {}
ns.Items = Items

local names = {}

function Items.Name(itemID)
    return names[itemID] or RETRIEVING_ITEM_INFO
end

function Items.Icon(itemID)
    return C_Item.GetItemIconByID(itemID)
end

function Items.Load(itemID, onLoad)
    if names[itemID] then
        if onLoad then
            onLoad()
        end
        return
    end
    local item = Item:CreateFromItemID(itemID)
    item:ContinueOnItemLoad(function()
        names[itemID] = item:GetItemName()
        if onLoad then
            onLoad()
        end
    end)
end
