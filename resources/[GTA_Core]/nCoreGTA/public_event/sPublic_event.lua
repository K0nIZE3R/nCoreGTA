--[[
RegisterNetEvent('GTA:GetAllHandleItems')  --> cette event sert uniquement a get toute les items de l'inventaire d'une source ou target pour l'afficher par exemple sur un menu.
AddEventHandler('GTA:GetAllHandleItems', function(handle, callback)
    local items = {}
    local source = handle
    local license = GetPlayerIdentifiers(source)[1]

    MySQL.Async.fetchAll("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_id` = `items`.`id` WHERE license=@username", { ['@username'] = license}, function(result)
        if (result) then
            for _,v in pairs(result) do
				t = { ["quantity"] = v.quantity, ["libelle"] = v.libelle, ["isUsable"] = v.isUsable, ["type"] = v.type }
				items[v.item_id] = t
			end
        end

        if callback then
            if (items ~= nil) then
                callback(items)
            end
        end
    end)
end)
--]]

--[=====[
        Return le sex de votre perso :
]=====]
RegisterNetEvent('GTA:GetUserSex')  --> cette event sert uniquement a get la quantité d'un item server-side.
AddEventHandler('GTA:GetUserSex', function(license, callback)
	MySQL.Async.fetchAll("SELECT sex FROM gta_joueurs_humain WHERE license = @username", {['@username'] = license}, function(res)
		if(res[1].sex ~= nil) then
			if callback then
				callback(res[1].sex)
			end
		end
	end)
end)


--[=====[
        Salaire toute les 15 minutes:
]=====]
RegisterNetEvent('GTA:salaire')
AddEventHandler('GTA:salaire', function()
	local source = source
    local license = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchAll('SELECT salaire FROM gta_joueurs INNER JOIN gta_metiers ON gta_joueurs.job = gta_metiers.metiers WHERE license = @license',{['@license'] = license}, function(res)
		PlayersSource[source].banque = PlayersSource[source].banque + res[1].salaire
		TriggerClientEvent('GTA:AfficherBanque', source, PlayersSource[source].banque)
		TriggerClientEvent("GTAO:NotificationIcon", source, "CHAR_BANK_MAZE", "Maze Bank", "+ : ~g~" ..res[1].salaire.. " $", "Salaire reçu")
	end)
end)


--[=====[
        Food :
]=====]
RegisterNetEvent("nSetFaim")
AddEventHandler("nSetFaim", function(faim)
	local source = source
	PlayersSource[source].faim = faim
end)

RegisterNetEvent("nSetSoif")
AddEventHandler("nSetSoif", function(soif)
	local source = source
	PlayersSource[source].soif = soif
end)

--[=====[
    	Sauvegarde de la pos du joueur : 
]=====]
RegisterNetEvent("GTA:SavePos")
AddEventHandler("GTA:SavePos", function(pos)
	local source = source
    PlayersSource[source].pos = pos
	TriggerClientEvent("NUI-Notification", source, {"Position Sauvegarder."})
end)



--[=====[
    	Changement d'identité :
]=====]
RegisterNetEvent("GTA:UpdateIdentiter")
AddEventHandler("GTA:UpdateIdentiter", function(nom, prenom, age, origine)
	local source = source
	if nom ~= nil then PlayersSource[source].identiter.nom = nom end
    if prenom ~= nil then PlayersSource[source].identiter.prenom = prenom end
    if age ~= nil then PlayersSource[source].identiter.age = age end
    if origine ~= nil then PlayersSource[source].identiter.origine = origine end

	local t = { 
		["nom"] = PlayersSource[source].identiter.nom or "Sans Nom",
		["prenom"] = PlayersSource[source].identiter.prenom or "Sans Prenom",
		["age"] = PlayersSource[source].identiter.age or "0",
		["origine"] = PlayersSource[source].identiter.origine or "Origine"
	}

	TriggerClientEvent("GTA_Interaction:UpdateInfoPlayers", source, t)
end)


--[=====[
    	Cette event vous retourne les informations de votre player ou target pour afficher les info de la carte d'identité :
]=====]
RegisterNetEvent("GTA:GetPlayerInformationsIdentiter")
AddEventHandler("GTA:GetPlayerInformationsIdentiter", function(target)
	local source = source
	local targetP = source or target
	local t = { 
		["nom"] = PlayersSource[source].identiter.nom,
		["prenom"] = PlayersSource[source].identiter.prenom,
		["age"] = PlayersSource[source].identiter.age,
		["origine"] = PlayersSource[source].identiter.origine,
		["profession"] = PlayersSource[source].job,
		["telephone"] = PlayersSource[source].phone_number,
	}

	if (target ~= nil) then
		TriggerClientEvent("GTA_Inv:ReceiveItemAnim", target)
		TriggerClientEvent("GTA_Inv:ReceiveItemAnim", source)
	end
	TriggerClientEvent("GTA_Interaction:UpdateInfoPlayersIdentiter", targetP, t)
end)



--[=====[
    	cette event sert uniquement a get l'argent de banque utile pour faire des condition avant vos achat ou autre.
]=====]
RegisterServerEvent('GTA:GetArgentBanque')
AddEventHandler('GTA:GetArgentBanque', function(source, callback)
	callback(PlayersSource[source].banque)
end)