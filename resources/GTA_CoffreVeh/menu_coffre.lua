local CARITEMS = {}
local PLAYTEMS = {}
local lastPlate = nil
local Duree = 1000
local index = 1
local maxItems = 0

function getPods()
    local pods = 0
    for _, v in pairs(CARITEMS) do
        pods = pods + v.quantity
    end
    return pods
end

RegisterNetEvent("GTA_Coffre:GetPlayerInventory")
AddEventHandler("GTA_Coffre:GetPlayerInventory", function(items)
    if items then
        PLAYTEMS = items
    else
        PLAYTEMS = {}
    end
end)

RegisterNetEvent("GTA_Coffre:GetInventoryTrunk")
AddEventHandler("GTA_Coffre:GetInventoryTrunk", function(items)
    if items then
        CARITEMS = items
    else
        CARITEMS = {}
    end
end)


--MENU :
local mainMenuCoffre = RageUI.CreateMenu("Coffre",  "Menu Coffre")
local deposerMenu = RageUI.CreateSubMenu(mainMenuCoffre, "Déposer", "Items: " .. (getPods()) .. "/" .. Config.maxCapacity[GetVehicleClass(vehFront)].size)


RoundNumber = function(value, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end

Citizen.CreateThread(function()
	while (true) do

        ---> SHOW CAR INVENTORY :
        RageUI.IsVisible(mainMenuCoffre, function()
            RageUI.Button("Déposer", "", {}, true, {onSelected = function()  end}, deposerMenu)
            
            for k, v in pairs(CARITEMS) do 
                local arg = {k, v.libelle, v.quantity }
                if (v.quantity > 0) then
                    RageUI.Button("~b~"..v.libelle.. " ~g~" .. RoundNumber(v.quantity), "", {}, true, {onSelected = function()
                        RemoveItem(arg)
                        RageUI.CloseAll(true)
                    end})
                end
            end
		end, function()end)

        ---> SHOW PLAYER INVENTORY :
        RageUI.IsVisible(deposerMenu, function()
            for k, v in pairs(PLAYTEMS) do 
                local arg = {k, v.libelle, v.quantity }

                if (v.quantity > 0) then
                    RageUI.Button("~b~"..v.libelle.. " ~g~" .. RoundNumber(v.quantity), "", {}, true, {onSelected = function()
                        AddItem(arg)
                        RageUI.CloseAll(true)
                    end})
                end
            end
		end, function()end)

        Citizen.Wait(1.0)
    end
end)

Citizen.CreateThread(function()
	while true do
        Duree = 1000
        if RageUI.Visible(mainMenuCoffre) == true then 
            Duree = 0
            DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
            DisableControlAction(0, 172, true) --DESACTIVE CONTROLL HAUT  
        end
		Citizen.Wait(Duree)
    end
end)

function RemoveItem(arg)
    local id = tonumber(arg[1])
    local lib = arg[2]
    local qtymax = arg[3]
    local vehFront = VehicleInFront()
    if vehFront > 0 then
        local qty = DisplayInput()
        if (type(qty) ~= "number") then
            TriggerEvent("NUI-Notification", {"Veuillez saisir un nombre correct.", "warning"})
            return false
        end
        if tonumber(qty) <= tonumber(qtymax) and tonumber(qty) > -1 then
            TriggerServerEvent("GTA_Coffre:looseItem", GetVehicleNumberPlateText(vehFront), id, tonumber(qty))
        else
            TriggerEvent("NUI-Notification", {"Il n'y a pas autant de " .. lib .. " dans votre inventaire", "warning"})
        end
    end
end

function AddItem(arg)
    local id = tonumber(arg[1])
    local lib = arg[2]
    local qtymax = arg[3]
    local vehFront = VehicleInFront()
    if vehFront > 0 then
        local qty = DisplayInput()
        if (type(qty) ~= "number") then
            TriggerEvent("NUI-Notification", {"Veuillez saisir un nombre correct.", "warning"})
            return false
        end
        if tonumber(qty) <= tonumber(qtymax) and tonumber(qty) > -1 then
            TriggerServerEvent("GTA_Coffre:receiveItem", GetVehicleClass(vehFront), GetVehicleNumberPlateText(vehFront), id, lib, tonumber(qty))
        else
            TriggerEvent("NUI-Notification", {"Il n'y a pas autant de " .. lib .. " dans le coffre", "warning"})
        end
    end
end


function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end


function DisplayInput()
    DisplayOnscreenKeyboard(1, "FMMC_MPM_TYP8", "", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(1)
    end
    if GetOnscreenKeyboardResult() then
        return tonumber(GetOnscreenKeyboardResult())
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then --> E
            local vehFront = VehicleInFront()
            if vehFront > 0 then
                lastPlate = vehFront
                if (RageUI.Visible(mainMenuCoffre) == false) then 
                    SetVehicleDoorOpen(lastPlate, 5, false, false)
                    TriggerServerEvent("GTA_Coffre:RequestPlayerInventory")
                    TriggerServerEvent("GTA_Coffre:RequestItemsCoffre", GetVehicleNumberPlateText(vehFront))
                    Wait(125)
                    RageUI.Visible(mainMenuCoffre, true)
                    SetVehicleDoorShut(lastPlate, 5, false)
                end
            end
        end
    end
end)




--> Executer une fois la ressource restart : 
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
	end

    TriggerServerEvent("GTA_Coffre:RequestPlayerInventory")
end)