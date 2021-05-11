local items = config.itemList


local __RoundNumber = function(value, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end


--[=====[
    	Permet de rename un item de votre inventaire : 
]=====]
RegisterNetEvent("GTA:RenameItem")
AddEventHandler("GTA:RenameItem", function(item_name, newLabel, itemid) 
    local source = source
    PlayersSource[source].inventaire[itemid].label = newLabel
        
    TriggerClientEvent("NUI-Notification", source, {"Vous avez renomer votre item : " ..PlayersSource[source].inventaire[itemid].label})
    TriggerClientEvent("GTA:Refreshinventaire", source, PlayersSource[source].inventaire, GetInvWeight(PlayersSource[source].inventaire))
end)


--[=====[
    	Permet de retirer un item de votre inventaire ou target :
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
    Permet de recevoir un item :
]=====]
RegisterNetEvent("GTA:ReceiveItem")
AddEventHandler("GTA:ReceiveItem", function(item, count, args) 
    local count = count or 1
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
    Permet de give un item a un player:
]=====]
RegisterNetEvent("GTA:GiveItem")
AddEventHandler("GTA:GiveItem", function(target, item, itemid, count, args) 
    local src = source
    if items[item] ~= nil then
        local tWeight = GetInvWeight(PlayersSource[target].inventaire)
        if tWeight + (items[item].weight * count) <= config.maxWeight then

            -- Removing item from source
            if PlayersSource[src].inventaire[itemid] == nil then
                return
            else
                if PlayersSource[src].inventaire[itemid].count - count <= 0 then
                    PlayersSource[src].inventaire[itemid].count = 0
                else
                    PlayersSource[src].inventaire[itemid].count = PlayersSource[src].inventaire[itemid].count - count
                end
                TriggerClientEvent("NUI-Notification", src, {"Vous avez donner x" ..count.. " "..items[item].label})
                TriggerClientEvent("GTA:Refreshinventaire", src, PlayersSource[src].inventaire, GetInvWeight(PlayersSource[src].inventaire))
            end

            -- Adding item to target
            local exist, itemid = DoesItemExistWithArg(target,item, args)
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

            TriggerClientEvent("GTA_Inv:ReceiveItemAnim", target)
            TriggerClientEvent("GTA_Inv:ReceiveItemAnim", source)

            TriggerClientEvent("NUI-Notification", target, {"Vous avez reçu x" ..count.. " "..items[item].label})
            TriggerClientEvent("GTA:Refreshinventaire", target, PlayersSource[target].inventaire, tWeight)
        else
            TriggerClientEvent("NUI-Notification", src, {"Son inventaire est rempli.", "warning"})
            TriggerClientEvent("NUI-Notification", target, {"Vous n'avez pas assez de place dans votre inventaire.", "warning"})
        end
    end
end)


--[[ 
    Permet de savoir si l'item existe dans la liste des items, si vrais il retourne "l'id" de l'item :
]]--
RegisterNetEvent("GTA_Inventaire:DoesItemExist")
AddEventHandler("GTA_Inventaire:DoesItemExist", function(source, item, callback) 
    for _,v in pairs(PlayersSource[source].inventaire) do
        if v.item == item then
            callback(v.itemId) 
        end
    end
end)



--[[ 
return generated item id
]]--
function GenerateItemId()
    return ""..tostring(math.random(100001,900009)).."-"..tostring(math.random(100001,900009)).."-"..tostring(math.random(100001,900009))
end



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

function SetItemArg(source, itemId, arg)
    for k,v in pairs(PlayersSource[source].inventaire) do
        if v.itemId == itemId then
            v.args = arg
        end
    end

    TriggerClientEvent("GTA:Refreshinventaire", source, PlayersSource[source].inventaire, GetInvWeight(PlayersSource[source].inventaire))
end