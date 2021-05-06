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


RegisterNetEvent('GTA:GetUserQtyItem')  --> cette event sert uniquement a get la quantité d'un item server-side.
AddEventHandler('GTA:GetUserQtyItem', function(source, itemID, callback)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchAll("SELECT quantity FROM user_inventory WHERE license = @username AND item_id = @item", {['@username'] = license, ['@item'] = itemID}, function(result)
		if(result[1] ~= nil) then
			if callback then
				callback(result[1].quantity)
			end
		else
			TriggerClientEvent("GTA_NUI_ShowNotif_client",  source, "Vous ne possédez pas cette item sur vous.", "warning")
		end
	end)
end)


RegisterNetEvent('GTA:GetMaxQtyItems')  --> cette event sert uniquement a get le max de quantité de l'item saisit.
AddEventHandler('GTA:GetMaxQtyItems', function(itemID, callback)
    local source = source
    local item_name = ""
    MySQL.Async.fetchAll("SELECT libelle, max_qty FROM items WHERE id = @itemid", { ['@itemid'] = itemID}, function(res)
		if(res[1]) then
            if callback then
                item_name = res[1].libelle
                callback(res[1].max_qty)
            end
        else
            TriggerClientEvent("GTA_NUI_ShowNotif_client", source, "L'item saisit : "..item_name.." est introuvable.", "error", "fa fa-exclamation-circle fa-2x")
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