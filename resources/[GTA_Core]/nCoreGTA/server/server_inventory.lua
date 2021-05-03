local items = config.itemList

--[=====[
    	Parameter : 
        id : unique id of the player.
        item : item name exemple : pistol.
        itemid : id of the item v.itemId.
        count : number of item.
]=====]
RegisterNetEvent("GTA:RemoveItem")
AddEventHandler("GTA:RemoveItem", function(id, item, itemid, count) 
    RemoveItem(id, item, itemid, count)
end)
function RemoveItem(id, item, itemid, count)
    if items[item] ~= nil then
        if PlayersSource[id].inventaire[itemid] ~= nil then -- Item do not exist in inventory
            if PlayersSource[id].inventaire[itemid].count - count <= 0 then -- If count < or = 0 after removing item count, then deleting it from player inv
                PlayersSource[id].inventaire[itemid] = nil
            else
                PlayersSource[id].inventaire[itemid].count = PlayersSource[id].inventaire[itemid].count - count
            end

            TriggerClientEvent("NUI-Notification", id, {"Vous avez jeter x" ..count.. " "..items[item].label})
            TriggerClientEvent("GTA:Refreshinventaire", id, PlayersSource[id].inventaire, GetInvWeight(PlayersSource[id].inventaire))
            return true
        else
            return false
        end
    else
        return false
    end
end


--[=====[
    	Parameter : 
        id : unique id of the player.
        item : item name exemple : pistol.
        count : number of item.
]=====]
RegisterNetEvent("GTA:AddItem")
AddEventHandler("GTA:AddItem", function(id, item, count, args) 
    AddItem(id, item, count, args)
end)
function AddItem(id, item, count, args)
    if items[item] ~= nil then
        local exist, itemid = DoesItemExistWithArg(id, item, args)
        local iWeight = GetInvWeight(PlayersSource[id].inventaire)
        if iWeight + (items[item].weight * count) <= config.maxWeight then
            if not exist then
                itemid = GenerateItemId()
                PlayersSource[id].inventaire[itemid] = {}
                PlayersSource[id].inventaire[itemid].item = item
                PlayersSource[id].inventaire[itemid].label = items[item].label
                PlayersSource[id].inventaire[itemid].count = count
                PlayersSource[id].inventaire[itemid].itemId = itemid
                PlayersSource[id].inventaire[itemid].args = {}
                if args ~= nil then
                    PlayersSource[id].inventaire[itemid].args = args
                end
            else
                PlayersSource[id].inventaire[itemid].count = PlayersSource[id].inventaire[itemid].count + count
            end
            TriggerClientEvent("NUI-Notification", id, {"Vous avez reçu x" ..count.. " "..items[item].label})
            TriggerClientEvent("GTA:Refreshinventaire", id, PlayersSource[id].inventaire, GetInvWeight(PlayersSource[id].inventaire))
            return true
        else
            TriggerClientEvent("NUI-Notification", id, {"Quantité maximum atteind.", "warning"})
            return false
        end
    end
end


--[=====[
    	Parameter : 
        id : unique id of the player.
        target : unique id of the target.
        item : item name exemple : pistol.
        count : number of item.
]=====]
RegisterNetEvent("GTA:GiveItem")
AddEventHandler("GTA:GiveItem", function(id, target, item, count, args, itemid) 
    GiveItem(id, target, item, count, args, itemid)
end)
function GiveItem(id, target, item, count, args, itemid)
    if items[item] ~= nil then
        local tWeight = GetInvWeight(PlayersSource[target].inventaire)
        if tWeight + (items[item].weight * count) <= config.maxWeight then

            -- Removing item from source
            if PlayersSource[id].inventaire[itemid] == nil then
                return
            else
                if PlayersSource[id].inventaire[itemid].count - count <= 0 then
                    PlayersSource[id].inventaire[itemid] = nil
                else
                    PlayersSource[id].inventaire[itemid].count = PlayersSource[id].inventaire[itemid].count - count
                end
                TriggerClientEvent("NUI-Notification", id, {"Vous avez donner x" ..count.. " "..items[item].label})
                TriggerClientEvent("GTA:Refreshinventaire", id, PlayersSource[id].inventaire, GetInvWeight(PlayersSource[id].inventaire))
            end

            -- Adding item to target
            local exist, itemid = DoesItemExistWithArg(id, item, args)
            if not exist then
                itemid = GenerateItemId()
                PlayersSource[target].inventaire[itemid] = {}
                PlayersSource[target].inventaire[itemid].item = item
                PlayersSource[target].inventaire[itemid].label = items[item].label
                PlayersSource[target].inventaire[itemid].count = count
                PlayersSource[target].inventaire[itemid].itemId = itemid
                PlayersSource[target].inventaire[itemid].args = {}
                if args ~= nil then
                    PlayersSource[target].inventaire[itemid].args = args
                end
            else
                PlayersSource[target].inventaire[itemid].count = PlayersSource[target].inventaire[itemid].count + count
            end
            TriggerClientEvent("NUI-Notification", target, {"Vous avez reçu x" ..count.. " "..items[item].label})
            TriggerClientEvent("GTA:Refreshinventaire", target, PlayersSource[id].inventaire, tWeight)
        else
            TriggerClientEvent("NUI-Notification", target, {"Vous n'avez pas assez de place dans votre inventaire."})
        end
    end
end

--[[ 
id = player id
itemId = itemID of the item targeted
arg = item args
]]--
function SetItemArg(id, itemId, arg)
    for k,v in pairs(PlayersSource[id].inventaire) do
        if v.itemId == itemId then
            v.args = arg
        end
    end

    TriggerClientEvent("GTA:Refreshinventaire", id, PlayersSource[id].inventaire, GetInvWeight(PlayersSource[id].inventaire))
end

--[[ 
return generated item id
]]--
function GenerateItemId()
    return ""..tostring(math.random(100001,900009)).."-"..tostring(math.random(100001,900009)).."-"..tostring(math.random(100001,900009))
end

--[[ 
id = player id
item = item name to check
arg = item args
]]--
function DoesItemExistWithArg(id, item, arg)
    if arg == nil then arg = {} end
    for k,v in pairs(PlayersSource[id].inventaire) do
        if v.item == item then
            if json.encode(v.args) == json.encode(arg) then
                return true, v.itemId
            end
        end
    end
    return false
end