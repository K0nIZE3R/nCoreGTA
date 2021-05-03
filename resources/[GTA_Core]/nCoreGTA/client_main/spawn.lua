--@Super.Cool.Ninja
local cam = nil
local cam2 = nil

--> Création/Load du player :
Citizen.CreateThread(function()
    Wait(1500)
    TriggerServerEvent("GTA:CreationJoueur") 
end)


RegisterNetEvent("GTA:JoueurLoaded")
AddEventHandler("GTA:JoueurLoaded", function(playersInfo, itemsList)
    config.Player = playersInfo
    config.itemList = itemsList

    TriggerServerEvent("GTA:TelephoneLoaded") --> Load le phone au spawn :

    local ipls = {'facelobby', 'farm', 'farmint', 'farm_lod', 'farm_props', 
                'des_farmhouse', 'post_hiest_unload', 'v_tunnel_hole',
                'rc12b_default', 'refit_unload', 'shr_int', 'Coroner_Int_on'}

    for _,v in pairs(ipls) do
        if not IsIplActive(v) then
            RequestIpl(v)
        end
    end

    Wait(1500)
    
    SetEntityCoords(GetPlayerPed(-1), config.Player.pos, 0.0, 0.0, 0.0, 0)
    SetEntityVisible(PlayerPedId(), false, 0)
	NetworkResurrectLocalPlayer(config.Player.pos + 0.0, 0, true, true, false)
	
	--> On charge les donné du player : 
	TriggerServerEvent("GTA:CheckAdmin", GetIsPlayerAdmin())
	TriggerServerEvent('GTA:LoadArgent')
	--TriggerEvent("GTA:LoadWeaponPlayer")

	--> Rend controlable notre player :
	FreezeEntityPosition(GetPlayerPed(-1), false)
	SetEntityVisible(PlayerPedId(), true, 0)
	Wait(500)
    
	exports.spawnmanager:setAutoSpawn(false)

	Wait(3000)
	
	SetEntityVisible(PlayerPedId(), true, 0)

	DisplayRadar(true)
	DisplayHud(true)

	--TriggerEvent('EnableDisableHUDFS', true)
	PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
	PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)

    --> PVP :
    if config.activerPvp == true then
        for _, v in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(v)
            SetCanAttackFriendly(ped, true, true)
            NetworkSetFriendlyFireOption(true)
        end
    end
end)


 --> Main Thread :
Citizen.CreateThread(function()
    --> COPS :
    if config.activerPoliceWanted == false then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                local myPlayer = GetEntityCoords(PlayerPedId())	
                --> Permet de ne pas recevoir d'indice de recherche :
                if (GetPlayerWantedLevel(PlayerId()) > 0) then
                    SetPlayerWantedLevel(PlayerId(), 0, false)
                    SetPlayerWantedLevelNow(PlayerId(), false)
                end

                --> Permet de ne pas spawn les véhicule de cops prés du poste de police :
                ClearAreaOfCops(myPlayer.x, myPlayer.y, myPlayer.z, 5000.0)
            end
        end)
    end

    --> Salaire :
    Citizen.CreateThread(function ()
        while true do
            Citizen.Wait(config.salaireTime)
            TriggerServerEvent("GTA:salaire", GetPlayerUniqueId())
        end
    end)

    --> Position Save :
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(config.timerPlayerSyncPos)
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            TriggerServerEvent("GTA:SavePos", pCoords)
        end
    end)
end)



--- System de distance de voix : 
local distance_voix = {}
local currentdistancevoice = 0
distance_voix.Grande = 12.001
distance_voix.Normal = 8.001
distance_voix.Faible = 2.001

RegisterCommand('+changevoice', function()
    currentdistancevoice = (currentdistancevoice + 1) % 3
	if currentdistancevoice == 0 then
		NetworkSetTalkerProximity(distance_voix.Normal) -- 5 meters range
	    TriggerEvent("NUI-Notification", {"Niveau vocal : normal."})

	elseif currentdistancevoice == 1 then
		NetworkSetTalkerProximity(distance_voix.Grande) -- 12 meters range
	    TriggerEvent("NUI-Notification", {"Niveau vocal : crier."})
	elseif currentdistancevoice == 2 then
        NetworkSetTalkerProximity(distance_voix.Faible) -- 1 meters range
	    TriggerEvent("NUI-Notification", {"Niveau vocal : chuchoter."})
	end
end, false)
AddEventHandler('onClientMapStart', function()
	if currentdistancevoice == 0 then
		NetworkSetTalkerProximity(distance_voix.Normal) -- 5 meters range
	elseif currentdistancevoice == 1 then
		NetworkSetTalkerProximity(distance_voix.Grande) -- 12 meters range
	elseif currentdistancevoice == 2 then
		NetworkSetTalkerProximity(distance_voix.Faible) -- 1 meters range
	end
end)
RegisterCommand('-changevoice', function() end, false)
RegisterKeyMapping('+changevoice', 'Distance de voix', 'keyboard', 'F1')




--> Executer une fois la ressource restart : 
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
	end

	PlaySoundFrontend(-1, "Whistle", "DLC_TG_Running_Back_Sounds", 0)
    TriggerServerEvent("GTA:CreationJoueur")
	exports.spawnmanager:setAutoSpawn(false)
end)