--||@SuperCoolNinja.||--

RegisterServerEvent('nBanqueSolde:SRender')
AddEventHandler('nBanqueSolde:SRender', function()
	local source = source	
	TriggerClientEvent('nBanqueSolde:CRender', source)
end)


--> Retirer de l'argent de votre compte en banque :
RegisterServerEvent('nBanqueSolde:PermissionRABanque')
AddEventHandler('nBanqueSolde:PermissionRABanque', function(somme)
	local source = source 
	TriggerEvent("GTA:GetArgentBanque", source, function(qtyBank)
		if(tonumber(qtyBank) >= tonumber(somme)) then 
			TriggerClientEvent("GTA_Banque:ClientRetirerArgentBanque", source, somme)
        else
			TriggerClientEvent("NUI-Notification", source, {"Vous n'avez pas autant d'argent en banque !"})
        end
	end)
end)


--> Deposer de l'argent dans votre compte en banque :
RegisterServerEvent('nBanqueSolde:PermissionDABanque')
AddEventHandler('nBanqueSolde:PermissionDABanque', function(somme)
	local source = source 
	TriggerEvent("GTA:GetItemQty", source, "cash", function(qtyArgentPropre, itemid)
		if(tonumber(qtyArgentPropre) >= tonumber(somme)) then 
			TriggerClientEvent("GTA_Banque:ClientDeposerArgentBanque", source, "cash", itemid, somme)
        else
			TriggerClientEvent("NUI-Notification", source, {"Vous n'avez pas autant de cash sur vous !"})
        end
	end)
end)