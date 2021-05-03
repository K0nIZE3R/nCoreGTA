--[=====[
        Spawn du player :
]=====]
AddEventHandler('playerSpawned', function()
	TriggerServerEvent("GTA:LoadJobsJoueur")
	TriggerServerEvent("nGetStats")
    TriggerServerEvent('GTA:requestSync')
end)

--[=====[
        Notification :
]=====]

RegisterNetEvent("NUI-Notification")
AddEventHandler("NUI-Notification", function(t)
    setmetatable(t,{__index={b = "success", c = "fa fa-handshake-o fa-2x", d = "row-reverse"}})
    local textNotif, tType, iCon, pPos = t[1] or t.a, t[2] or t.b, t[3] or t.c, t[4] or t.d

    exports.nMainNotification:GTA_NUI_ShowNotification({
        text = textNotif,
        type = tType,
        icon = iCon,
        position = pPos
    })
end)

RegisterNetEvent('nMenuNotif:showNotification')
AddEventHandler('nMenuNotif:showNotification', function(text)
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
	DrawNotification( false, false )
end)

RegisterNetEvent('GTAO:NotificationIcon')
AddEventHandler('GTAO:NotificationIcon', function(icon, title, soustitre, text)
	soustitre = soustitre or " "
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	SetNotificationMessage(icon, icon, true, 1, title, soustitre, text)
	DrawNotification(false, true)
end)
--TriggerEvent("GTAO:NotificationIcon", "CHAR_BANK_MAZE", "Titre","Sous Titre", "TEXT LOREM SISISI ASASAASLLAALLA")



--[=====[
            Marker Target :
]=====]
RegisterNetEvent("ShowMarkerTarget")
AddEventHandler("ShowMarkerTarget", function()
    afficherMarkerTarget()
end)

function GetPlayers()
    local players = {}
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		players[#players + 1] = player
	end
    return players
end

local square = math.sqrt
function getDistance(a, b) 
    local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
    return square(x*x+y*y+z*z)
end

function afficherMarkerTarget()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	for _,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = getDistance(targetCoords, plyCoords, true)
			if distance < 2 then
				if(closestDistance == -1 or closestDistance > distance) then
					closestPlayer = value
					closestDistance = distance
					DrawMarker(0, targetCoords["x"], targetCoords["y"], targetCoords["z"] + 1, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.1, 255, 255, 255, 200, 0, 0, 0, 0)
				end
			end
		end
	end
end

--[=====[
            Play TaskStartScenarioInPlace :
]=====]
RegisterNetEvent("PlayTaskScenarioInPlace")
AddEventHandler("PlayTaskScenarioInPlace", function(handle, animation, timer) 
	TaskStartScenarioInPlace(handle, animation, 0, true)
	Citizen.Wait(timer)
	ClearPedTasks(handle)
	exports.rprogress:Start("Action en cours", timer)
end)


--[=====[
            Play TaskPlayAnim :
]=====]
RegisterNetEvent("TaskPlayAnimation")
AddEventHandler("TaskPlayAnimation", function(handle, dict, animation, duration, flags) 
	duration = duration or -1
	flags = flags or 0
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
	TaskPlayAnim(handle, dict, animation, 8.0, -8, duration, flags, 0, 0, 0, 0)
end)

--[=====[
           Anim Set Attitude (demarche) :
]=====]
RegisterNetEvent("BeginRequestAnimSet")
AddEventHandler("BeginRequestAnimSet", function(animSet) 
	if not HasAnimSetLoaded(animSet) then
		RequestAnimSet(animSet)

		while not HasAnimSetLoaded(animSet) do
			Citizen.Wait(1)
		end
		SetPedMotionBlur(GetPlayerPed(-1), true)
		SetPedMovementClipset(GetPlayerPed(-1), animSet, true)
	end
end)



--[=====[
            Show AlertNear :
]=====]
RegisterNetEvent("AlertNear")
AddEventHandler("AlertNear", function(message) 
	BeginTextCommandDisplayHelp("STRING");  
    AddTextComponentSubstringPlayerName(message);  
    EndTextCommandDisplayHelp(0, 0, 1, -1);
end)

--[=====[
            Spawn Vehicule :
]=====]
RegisterNetEvent("SpawnVehicule")
AddEventHandler("SpawnVehicule", function(pVeh, pos, imatricule)
    local pVeh = GetHashKey(pVeh)

    RequestModel(pVeh)
    while not HasModelLoaded(pVeh) do
        RequestModel(pVeh)
        Citizen.Wait(0)
    end

    local veh = CreateVehicle(pVeh, pos.x, pos.y, pos.z, pos.h, true, false)

	if (imatricule ~= nil) then
    	SetVehicleNumberPlateText(veh, imatricule)
	end

	SetEntityAsMissionEntity(veh, true, true)
end)


--[=====[
            Destroy Vehicule :
]=====]
RegisterNetEvent("DestroyVehicle")
AddEventHandler("DestroyVehicle", function(entity)
    SetEntityAsMissionEntity(entity,true,true)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
    TriggerEvent("NUI-Notification", {"Véhicule détruit."})
end)

--[=====[
            Play Sound List de sons : https://gtaforums.com/topic/795622-audio-for-mods
			Exemple : TriggerEvent("PlaySoundClient", GetPlayerPed(-1), "Radio_Off", "TAXI_SOUNDS")
]=====]
RegisterNetEvent("PlaySoundClient")
AddEventHandler("PlaySoundClient", function(handle,sound,dict)
	PlaySoundFromEntity(-1,tostring(sound),handle,tostring(dict), 0, 0)
end)

--[=====[
        Permet de refresh les nouvel donnée de l'inventaire sans devoir passé par la base de donnée :
]=====]
RegisterNetEvent("GTA:Refreshinventaire")
AddEventHandler("GTA:Refreshinventaire", function(inv, weight)
    config.Player.inventaire = inv
    config.Player.weight = weight
    TriggerEvent("GTA:UpdateInventaire", config.Player.inventaire, config.Player.weight)
end)


--[=====[
        Permet de refresh les nouvel donnée de vos stats faim/soif :
]=====]
RegisterNetEvent("GTA:RefreshFoodsStat")
AddEventHandler("GTA:RefreshFoodsStat", function(faim, soif)
    config.Player.faim = faim
    config.Player.soif = soif
    TriggerEvent("GTA:UpdateHungerStat", config.Player.faim, config.Player.soif)
end)

--[=====[
        Permet de refresh l'identité de votre perso :
		config.Player.nom = nom
		config.Player.prenom = prenom
		config.Player.age = age
		config.Player.origine = origine
]=====]

RegisterNetEvent("GTA:RefreshPlayerInfo")
AddEventHandler("GTA:RefreshPlayerInfo", function(identiter, banque)
	config.Player.identiter = identiter
	config.Player.banque = config.Player.banque or banque

    TriggerEvent("GTA_Interaction:UpdateInfoPlayers", config.Player.identiter, config.Player.banque)
end)



--[=====[
        Permet de refresh les nouvel donnée de votre argent en banque utile si vous l'afficher :
]=====]
RegisterNetEvent("GTA:AfficherBanque")
AddEventHandler("GTA:AfficherBanque", function(value)
	StatSetInt("BANK_BALANCE", value, true)
    RemoveMultiplayerHudCash(0x968F270E39141ECA)
end)