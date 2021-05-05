local items = config.itemList


local __RoundNumber = function(value, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end

--[=====[
    	Parameter : 
        id : unique id of the player.
        item : item name exemple : pistol.
        itemid : id of the item v.itemId.
        count : number of item.
]=====]
RegisterNetEvent("GTA:RemoveItem")
AddEventHandler("GTA:RemoveItem", function(item, itemid, count) 
    local source = source
    if items[item] ~= nil then
        if PlayersSource[source].inventaire[itemid] ~= nil then -- Item do not exist in inventory
            if  PlayersSource[source].inventaire[itemid].count - __RoundNumber(count) <= 0 then -- If count < or = 0 after removing item count, then deleting it from player inv
                PlayersSource[source].inventaire[itemid].count = 0
            else
                PlayersSource[source].inventaire[itemid].count = PlayersSource[source].inventaire[itemid].count - __RoundNumber(count)
            end

            TriggerClientEvent("GTA:Refreshinventaire", source, PlayersSource[source].inventaire, GetInvWeight(PlayersSource[source].inventaire))
        end
    end
end)



--[=====[
    Permet de get la qty d'item que vous avez sur vous :
]=====]
RegisterNetEvent("GTA:GetItemQty")
AddEventHandler("GTA:GetItemQty", function(source, item_name, callback)
    if items[item_name] ~= nil then
        for _,v in pairs(PlayersSource[source].inventaire) do
            if v.item == item_name then
                callback(v.count, v.itemId) 
            end
        end
    end
end)

--[=====[
    	Parameter : 
        id : unique id of the player.
        item : item name exemple : pistol.
        count : number of item.
]=====]
RegisterNetEvent("GTA:ReceiveItem")
AddEventHandler("GTA:ReceiveItem", function(item, count, args) 
    local src = source
    if items[item] ~= nil then
        local exist, itemid = DoesItemExistWithArg(src, item, args)
        local iWeight = GetInvWeight(PlayersSource[src].inventaire)

        if iWeight + (items[item].weight * __RoundNumber(count)) <= config.maxWeight then
            if not exist then
                itemid = GenerateItemId()
                PlayersSource[src].inventaire[itemid] = {}
                PlayersSource[src].inventaire[itemid].item = item
                PlayersSource[src].inventaire[itemid].label = items[item].label
                PlayersSource[src].inventaire[itemid].count =  __RoundNumber(count)
                PlayersSource[src].inventaire[itemid].itemId = itemid
                PlayersSource[src].inventaire[itemid].args = {}
                if args ~= nil then
                    PlayersSource[src].inventaire[itemid].args = args
                end
            else
                PlayersSource[src].inventaire[itemid].count =  PlayersSource[src].inventaire[itemid].count +  __RoundNumber(count)
            end
            TriggerClientEvent("NUI-Notification", src, {"Vous avez reçu x" ..count.. " "..items[item].label})
            TriggerClientEvent("GTA:Refreshinventaire", src, PlayersSource[src].inventaire, GetInvWeight(PlayersSource[src].inventaire))
        else
            TriggerClientEvent("NUI-Notification", src, {"Quantité maximum atteind.", "warning"})
        end
    end
end)


--[=====[
    	Parameter : 
        id : unique id of the player.
        target : unique id of the target.
        item : item name exemple : pistol.
        count : number of item.
]=====]

--[[  --> A REWORK :
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
                    PlayersSource[id].inventaire[itemid].count = 0
                else
                    PlayersSource[id].inventaire[itemid].count = PlayersSource[id].inventaire[itemid].count - count
                end
                TriggerClientEvent("NUI-Notification", id, {"Vous avez donner x" ..count.. " "..items[item].label})
                TriggerClientEvent("GTA:Refreshinventaire", id, PlayersSource[id].inventaire, GetInvWeight(PlayersSource[id].inventaire))
            end

            -- Adding item to target
            local exist, itemid = DoesItemExistWithArg(item, args)
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
]]




--[[ 
return generated item id
]]--
function GenerateItemId()
    return ""..tostring(math.random(100001,900009)).."-"..tostring(math.random(100001,900009)).."-"..tostring(math.random(100001,900009))
end


------------------------------------------------------- :
-----------------------INVENTAIRE---------------------- :
------------------------------------------------------- :
--[[
id = player id
item = item name to check
arg = item args
]]--

function GetInvWeight(inv)
    local countWeight = 0
    for _,v in pairs(inv) do
        countWeight = items[v.item].weight * v.count
    end
    return countWeight
end

function DoesItemExistWithArg(source, item, arg)
    if arg == nil then arg = {} end
    for k,v in pairs(PlayersSource[source].inventaire) do
        if v.item == item then
            if json.encode(v.args) == json.encode(arg) then
                return true, v.itemId
            end
        end
    end
    return false
end

RegisterNetEvent("GTA_Inventaire:DoesItemExist")
AddEventHandler("GTA_Inventaire:DoesItemExist", function(source, item, callback) 
    for _,v in pairs(PlayersSource[source].inventaire) do
        if v.item == item then
            callback(v.itemId) 
        end
    end
end)

--[[ 
id = player id
itemId = itemID of the item targeted
arg = item args
]]--
function SetItemArg(source, itemId, arg)
    for k,v in pairs(PlayersSource[source].inventaire) do
        if v.itemId == itemId then
            v.args = arg
        end
    end

    TriggerClientEvent("GTA:Refreshinventaire", source, PlayersSource[source].inventaire, GetInvWeight(PlayersSource[source].inventaire))
end

