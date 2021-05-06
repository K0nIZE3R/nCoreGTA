local waitRenderCarte = 1000
active = nil
RegisterNetEvent("GTA_Interaction:UpdateInfoPlayers")
AddEventHandler("GTA_Interaction:UpdateInfoPlayers", function(identiter, banque)
    config.joueurs.nom = identiter["nom"] 
    config.joueurs.prenom = identiter["prenom"]
    config.joueurs.age = identiter["age"] 
    config.joueurs.origine = identiter["origine"]

	--print(identiter["nom"] , identiter["prenom"], identiter["age"], identiter["origine"])

	config.joueurs.argentBanque = banque
	mainMenu.Title = config.joueurs.nom .. " ".. config.joueurs.prenom
end)

RegisterNetEvent("GTA:RefreshUserSex")
AddEventHandler("GTA:RefreshUserSex", function(sexe)
	config.joueurs.sexe = sexe
end)

RegisterNetEvent("GTA:MettreHautJoueur")
AddEventHandler("GTA:MettreHautJoueur", function(args)
	local playerPed = GetPlayerPed(-1)

	SetPedComponentVariation(playerPed, args[1], args[2], args[3], 0) --> TopsID
	SetPedComponentVariation(playerPed, args[4], args[5], args[6], 0) --> Undershirt
	SetPedComponentVariation(playerPed, args[7], args[8], 0, 0) --> Torsos
end)

RegisterNetEvent("GTA:MettreBasJoueur")
AddEventHandler("GTA:MettreBasJoueur", function(args)
	local playerPed = GetPlayerPed(-1)
	SetPedComponentVariation(playerPed, args[1], args[2], args[3], 0) --> Legs
end)

RegisterNetEvent("GTA:MettreChaussureJoueur")
AddEventHandler("GTA:MettreChaussureJoueur", function(args)
	local playerPed = GetPlayerPed(-1)
	SetPedComponentVariation(playerPed, args[1], args[2], args[3], 0) --> Shoes
end)

RegisterNetEvent("GTA:MettreBonnetJoueur")
AddEventHandler("GTA:MettreBonnetJoueur", function(args)
	local playerPed = GetPlayerPed(-1)
	SetPedPropIndex(playerPed, args[1], args[2], args[3], 0) --> Hats
end)

RegisterNetEvent("GTA:RetirerHautJoueur")
AddEventHandler("GTA:RetirerHautJoueur", function()
	local playerPed = GetPlayerPed(-1)
	if config.joueurs.sexe == "mp_m_freemode_01" then
		SetPedComponentVariation(playerPed, 11, 15, 0, 0)
		SetPedComponentVariation(playerPed, 8, 15, 0, 0)
		SetPedComponentVariation(playerPed, 3, 15, 0, 0)
	else
		SetPedComponentVariation(playerPed, 11, 15, 0, 0)
		SetPedComponentVariation(playerPed, 8, 2, 0, 0)
		SetPedComponentVariation(playerPed, 3, 15, 0, 0)
	end
end)

RegisterNetEvent("GTA:RetirerBasJoueur")
AddEventHandler("GTA:RetirerBasJoueur", function()
	local playerPed = GetPlayerPed(-1)
	if config.joueurs.sexe == "mp_m_freemode_01" then
		SetPedComponentVariation(playerPed, 4, 14, 0, 0)
	else
		SetPedComponentVariation(playerPed, 4, 17, 0, 0)
	end
end)

RegisterNetEvent("GTA:RetirerChaussureJoueur")
AddEventHandler("GTA:RetirerChaussureJoueur", function()
	local playerPed = GetPlayerPed(-1)
	if config.joueurs.sexe == "mp_m_freemode_01" then
		SetPedComponentVariation(playerPed, 6, 34, 0, 0)
	else
		SetPedComponentVariation(playerPed, 6, 35, 0, 0)
	end
end)

RegisterNetEvent("GTA:RetirerBonnetJoueur")
AddEventHandler("GTA:RetirerBonnetJoueur", function()
	local playerPed = GetPlayerPed(-1)
	if config.joueurs.sexe == "mp_m_freemode_01" then
		SetPedPropIndex(playerPed, 0, 8, 0, 0)
	else
		SetPedPropIndex(playerPed, 0, 57, 0, 0)
	end
end)

RegisterNetEvent("GTA_Inv:ReceiveItemAnim")
AddEventHandler("GTA_Inv:ReceiveItemAnim", function()
	TriggerEvent("TaskPlayAnimation", PlayerPedId(), "amb@world_human_security_shine_torch@male@enter", "enter", -1)
end)

RegisterNetEvent('GTA:RegarderIdentiter')
AddEventHandler('GTA:RegarderIdentiter', function(pNom, pPrenom, pTravail, pAge, pOrigine, pGrade)
	active = true
	config.joueurs.nom = tostring(pNom)
	config.joueurs.prenom = tostring(pPrenom)
	config.joueurs.travail = tostring(pTravail)
	config.joueurs.age = tonumber(pAge)
	config.joueurs.origine = tostring(pOrigine)
	config.joueurs.grade = tostring(pGrade)
end)

local square = math.sqrt
function getDistance(a, b) 
    local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
    return square(x*x+y*y+z*z)
end

function RenderCarte()
	DrawRect(0.883000000000001, 0.37, 0.185, 0.350, 0, 0, 0, 155)
	DrawAdvancedText2(0.975000000000001, 0.239, 0.005, 0.0028, 0.7, "Carte d'identité", 255, 255, 255, 255, 1, 0)
	
	DrawAdvancedText2(0.897000000000001, 0.290, 0.005, 0.0028, 0.3, "Nom :~b~ "..config.joueurs.nom .. " "..config.joueurs.prenom, 255, 255, 255, 255, 0, 1)
	DrawAdvancedText2(0.897000000000001, 0.320, 0.005, 0.0028, 0.3, "Age :~b~ "..config.joueurs.age.."~w~ ans", 255, 255, 255, 255, 0, 1)
	DrawAdvancedText2(0.897000000000001, 0.350, 0.005, 0.0028, 0.3, "Métier :~b~ "..config.joueurs.travail, 255, 255, 255, 255, 0, 1)
	DrawAdvancedText2(0.897000000000001, 0.380, 0.005, 0.0028, 0.3, "Grade :~b~ "..config.joueurs.grade, 255, 255, 255, 255, 0, 1)
	DrawAdvancedText2(0.897000000000001, 0.410, 0.005, 0.0028, 0.3, "Origine : ~b~"..config.joueurs.origine, 255, 255, 255, 255, 0, 1)
	--DrawAdvancedText2(0.897000000000001, 0.440, 0.005, 0.0028, 0.3, "[SOON] Permis Voiture : "..identitepermis3, 255, 255, 255, 255, 0, 1)
	--DrawAdvancedText2(0.897000000000001, 0.470, 0.005, 0.0028, 0.3, "[SOON] Permis Port d'armes : "..identitepermis4, 255, 255, 255, 255, 0, 1)
end

function GetInputNumber()
    local nb = 0
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TTTIP8", "", "", "", "", "", 20)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(10)
    end
    if (GetOnscreenKeyboardResult()) then
        nb = GetOnscreenKeyboardResult()
        nb = nb:gsub("[^0-9]", "")
        nb = tonumber(nb)
        if nb == nil or nb < 0 then
           nb = 0
        end
    end
    return nb
end

function GetInputText(actualtext)
    local text = ""
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TTTIP8", "", actualtext, "", "", "", 120)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(10)
    end
    if (GetOnscreenKeyboardResult()) then
        text = GetOnscreenKeyboardResult()
    end
    return text
end

function RequestToSave()
	local LastPosX, LastPosY, LastPosZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	TriggerServerEvent("GTA:SAVEPOS", LastPosX , LastPosY , LastPosZ)
	TriggerEvent("NUI-Notification", {"Position Sauvegarder."})
end

function DrawAdvancedText2(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end

function IsNearPlayer(player)
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
    local ply2Coords = GetEntityCoords(ply2, 0)
    local distance = GetDistanceBetweenCoords(ply2Coords["x"], ply2Coords["y"], ply2Coords["z"],  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 5) then
        return true
    end
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	for _,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if distance < 5 then
				if(closestDistance == -1 or closestDistance > distance) then
					closestPlayer = value
					closestDistance = distance
				end
			end
		end
	end

	return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		players[#players + 1] = player
	end
    return players
end



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(waitRenderCarte)
		if active then
			waitRenderCarte = 1
			RenderCarte()
		else
			waitRenderCarte = 1000
		end
	end
end)

--> Check si la carte d'identié est ouvert, on la ferme aprés 10 seconde :
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(waitRenderCarte)
		if active then
			RenderCarte()
			Wait(10000) --Permet l'affichage pendant 10 secondes
			active = false
		end
	end
end)

