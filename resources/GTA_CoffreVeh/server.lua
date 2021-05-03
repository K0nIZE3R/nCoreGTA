local CARS = {}

function IndexSearch(plate)
    for key in pairs(CARS) do
        if (key == plate) then
            return true
        end
    end
    print("vehicule immatriculé " .. plate .. " chargé")
    return false
end

function getSlots(plate)
    local pods = 0
    if (IndexSearch(plate)) then
        for _, v in pairs(CARS[plate]) do
            print(CARS[plate])
            pods = pods + v.quantity
        end
    end
    return pods
end


MySQL.Async.fetchAll("SELECT vehicle_plate AS plate, items.id AS id, items.libelle AS libelle, quantity FROM gta_joueurs_vehicle LEFT JOIN vehicle_inventory ON `vehicle_inventory`.`plate` = `gta_joueurs_vehicle`.`vehicle_plate` LEFT JOIN items ON `vehicle_inventory`.`item` = `items`.`id`", {}, function(result)
    if (result) then
        for _, v in pairs(result) do
            if (not IndexSearch(v.plate)) then
			    print(v.plate)
                
                MySQL.Sync.execute("DELETE FROM vehicle_inventory WHERE plate = @vehicle_plate", {['@vehicle_plate'] = v.plate})

                CARS[v.plate] = {}
                print("new table has been created", v.plate)
            end

            if (v.id and v.libelle and v.quantity) then
                print("update value", v.id, v.libelle, v.quantity)
                --table.insert(CARS[v.plate], { libelle = v.libelle, quantity = v.quantity })
                CARS[v.plate][v.id] =  { quantity = v.quantity, libelle = v.libelle }
            end
        end
    end
end)


RegisterServerEvent("GTA_Coffre:RequestItemsCoffre")
AddEventHandler("GTA_Coffre:RequestItemsCoffre", function(plate)
    local res = nil
    if CARS[plate] then
        res = CARS[plate]
    end
    TriggerClientEvent("GTA_Coffre:GetInventoryTrunk", source, res)
end)

RegisterServerEvent("GTA_Coffre:RequestPlayerInventory")
AddEventHandler("GTA_Coffre:RequestPlayerInventory", function()
    local source = source	
    TriggerEvent('GTA:GetAllHandleItems', source, function(data)
        TriggerClientEvent("GTA_Coffre:GetPlayerInventory", source, data)
    end)
end)


RegisterServerEvent("GTA_Coffre:receiveItem")
AddEventHandler("GTA_Coffre:receiveItem", function(vehclass, plate, index, lib, quantity)
    local ActualSlotUsed = getSlots(plate)
    local limitslots = ActualSlotUsed + quantity

    if (limitslots <= Config.maxCapacity[vehclass].size) then
        if not IndexSearch(plate) then
            CARS[plate] = {}
        end
        add({ index, quantity, plate, lib })
        TriggerClientEvent("player:looseItem", source, index, tonumber(quantity))
        TriggerClientEvent("NUI-Notification", source, {"Vous avez déposer x" ..tonumber(quantity) .. " ".. lib})
    else
        if quantity > Config.maxCapacity[vehclass].size then
            TriggerClientEvent("NUI-Notification", source, {"Ce vehicule ne peut contenir seulement " .. Config.maxCapacity[vehclass].size .. " objets", "warning"})
        elseif ActualSlotUsed >= Config.maxCapacity[vehclass].size then
            TriggerClientEvent("NUI-Notification", source, {"Il n'y a plus assez de place !'", "error"})
        elseif limitslots > Config.maxCapacity[vehclass].size then
            TriggerClientEvent("NUI-Notification", source, {"Ce vehicule ne peut contenir seulement " .. Config.maxCapacity[vehclass].size .. " objets", "warning"})
        end
    end
end)

RegisterServerEvent("GTA_Coffre:looseItem")
AddEventHandler("GTA_Coffre:looseItem", function(plate, item, quantity)
    local source = source
    local cItem = CARS[plate][item]
    if (cItem.quantity >= quantity) then
        delete({ item, quantity, plate })
        TriggerEvent('GTA:GetMaxQtyItems', item, function(data)
            TriggerClientEvent("player:receiveItem", source, item, quantity, data)
        end)
    end
end)

RegisterNetEvent('GTA-Coffre:InitPlate')
AddEventHandler('GTA-Coffre:InitPlate', function(plate)
    CARS[plate] = {}
    MySQL.Async.execute("UPDATE vehicle_inventory SET `isOwner` = @Owner WHERE `plate` = @plate",
    { ['@plate'] = plate, ['@Owner'] = 1})
end)

function add(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local plate = arg[3]
    local lib = arg[4]
    local query
    local item
    if CARS[plate][itemId] then
        item = CARS[plate][itemId]
        query = "UPDATE vehicle_inventory SET `quantity` = @qty WHERE `plate` = @plate AND `item` = @item"
        item.quantity = item.quantity + qty
    else
        CARS[plate][itemId] = { quantity = qty, libelle = lib }
        item = CARS[plate][itemId]
        print(CARS[plate][itemId].libelle)
        query = "INSERT INTO vehicle_inventory (`quantity`,`plate`,`item`) VALUES (@qty,@plate,@item)"
    end
    MySQL.Async.execute(query, { ['@plate'] = plate, ['@qty'] = item.quantity, ['@item'] = itemId })
end

function delete(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local plate = arg[3]
    local item = CARS[plate][itemId]
    item.quantity = item.quantity - qty
    MySQL.Async.execute("UPDATE vehicle_inventory SET `quantity` = @qty WHERE `plate` = @plate AND `item` = @item",
        { ['@plate'] = plate, ['@qty'] = item.quantity, ['@item'] = itemId })
end