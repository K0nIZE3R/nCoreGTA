 --||@SuperCoolNinja. && RamexDeltaXOO||--

RegisterServerEvent("GTA:UpdateSexPersonnage")
AddEventHandler("GTA:UpdateSexPersonnage",function(sex)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	MySQL.Async.execute('UPDATE gta_joueurs_humain SET sex=@sex WHERE license = @license',{ ['@license'] = license,['@sex'] = sex})

	if sex == "mp_m_freemode_01" then
		MySQL.Async.execute('UPDATE gta_joueurs_vetement SET HatsDraw=@HatsDraw WHERE license = @license',{ ['@license'] = license,['@HatsDraw'] = 8})
	elseif sex == "mp_f_freemode_01" then
		MySQL.Async.execute('UPDATE gta_joueurs_vetement SET HatsDraw=@HatsDraw WHERE license = @license',{ ['@license'] = license,['@HatsDraw'] = 15})
	end

	TriggerClientEvent("GTA:ChangerSex", source, sex)
end)

RegisterServerEvent("GTA:UpdateVisage")
AddEventHandler("GTA:UpdateVisage", function(visage)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	MySQL.Async.execute('UPDATE gta_joueurs_humain SET visage=@visage WHERE license = @license',{ ['@license'] = license,['@visage'] = visage})
	TriggerClientEvent("GTA:ChangerVisage", source, visage)
end)

RegisterServerEvent("GTA:UpdateCouleurPeau")
AddEventHandler("GTA:UpdateCouleurPeau",function(peauID)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	MySQL.Async.execute('UPDATE gta_joueurs_humain SET couleurPeau=@couleurPeau WHERE license = @license',{ ['@license'] = license,['@couleurPeau'] = peauID})
	TriggerClientEvent("GTA:ChangerCouleurPeau", source, peauID)
end)

RegisterServerEvent("GTA:UpdateYeux")
AddEventHandler("GTA:UpdateYeux",function(yeux)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	MySQL.Async.execute('UPDATE gta_joueurs_humain SET couleurYeux=@couleurYeux WHERE license = @license',{ ['@license'] = license,['@couleurYeux'] = yeux})
	TriggerClientEvent("GTA:ChangerCouleurYeux", source, yeux)
end)

RegisterServerEvent("GTA:UpdateDad")
AddEventHandler("GTA:UpdateDad",function(dad)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	MySQL.Async.execute('UPDATE gta_joueurs_humain SET pere=@pere WHERE license = @license',{ ['@license'] = license,['@pere'] = dad})
	TriggerClientEvent("GTA:ChangerDad", source, dad)
end)

RegisterServerEvent("GTA:UpdateMom")
AddEventHandler("GTA:UpdateMom",function(mom)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	MySQL.Async.execute('UPDATE gta_joueurs_humain SET mere=@mere WHERE license = @license',{ ['@license'] = license,['@mere'] = mom})
	TriggerClientEvent("GTA:ChangerMom", source, mom)
end)

RegisterServerEvent("GTA:UpdateCheveux")
AddEventHandler("GTA:UpdateCheveux",function(cheveuxID)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	MySQL.Async.execute('UPDATE gta_joueurs_humain SET cheveux=@cheveux WHERE license = @license',{ ['@license'] = license,['@cheveux'] = cheveuxID})
	TriggerClientEvent("GTA:ChangerCoupeCheveux", source, cheveuxID)
end)


RegisterServerEvent("GTA:UpdateCouleurCheveux")
AddEventHandler("GTA:UpdateCouleurCheveux",function(couleurID)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	MySQL.Async.execute('UPDATE gta_joueurs_humain SET couleurCheveux=@couleurCheveux WHERE license = @license',{ ['@license'] = license,['@couleurCheveux'] = couleurID})
	TriggerClientEvent("GTA:ChangerCouleurCheveux", source, couleurID)
end)


RegisterServerEvent("GTA:TenueHomme") 
AddEventHandler("GTA:TenueHomme", function(TenueHomme)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	
	MySQL.Async.execute(
	"UPDATE gta_joueurs_vetement SET topsID=@topsid, topsDraw=@topdraw, topsCouleur=@topscouleur, undershirtsID=@undershirtsid, undershirtsDraw=@undershirtsdraw, undershirtsCouleur=@undershirtscouleur, shoesID=@shoesid, shoesDraw=@shoesdraw, shoesCouleur=@shoescouleur, legsID=@legsid, legsDraw=@legsdraw, legsCouleur=@legscouleur, torsosID=@torsosid, torsosDraw=@torsosdraw, AccessoiresID=@accessoiresid, AccessoiresDraw=@Accessoiresdraw, AccessoiresCouleur=@Accessoirescouleur WHERE license=@license", {
	['@license'] = license,
	['@topsid'] = 				TenueHomme["Tops"].componentId,
	['@topdraw'] = 				TenueHomme["Tops"].drawableId, 
	['@topscouleur'] = 			TenueHomme["Tops"].textureId, 
	['@undershirtsid'] = 		TenueHomme["Undershirts"].componentId,
	['@undershirtsdraw'] = 		TenueHomme["Undershirts"].drawableId, 
	['@undershirtscouleur'] = 	TenueHomme["Undershirts"].textureId,
	['@shoesid'] = 				TenueHomme["Shoes"].componentId, 
	['@shoesdraw'] = 			TenueHomme["Shoes"].drawableId,
	['@shoescouleur'] = 		TenueHomme["Shoes"].textureId,
	['@legsid'] = 				TenueHomme["Legs"].componentId, 
	['@legsdraw'] = 			TenueHomme["Legs"].drawableId, 
	['@legscouleur'] = 			TenueHomme["Legs"].textureId, 
	['@torsosid'] = 			TenueHomme["Torsos"].componentId, 
	['@torsosdraw'] = 			TenueHomme["Torsos"].drawableId,
	['@accessoiresid'] = 		TenueHomme["Accessories"].componentId,
	['@Accessoiresdraw'] = 		TenueHomme["Accessories"].drawableId,
	['@Accessoirescouleur'] = 	TenueHomme["Accessories"].textureId})
end)

RegisterServerEvent("GTA:TenueFemme")
AddEventHandler("GTA:TenueFemme", function(TenueFemme)
	local source = source
	local license = GetPlayerIdentifiers(source)[1]

	
	MySQL.Async.execute(
	"UPDATE gta_joueurs_vetement SET topsID=@topsid, topsDraw=@topdraw, topsCouleur=@topscouleur, undershirtsID=@undershirtsid, undershirtsDraw=@undershirtsdraw, undershirtsCouleur=@undershirtscouleur, shoesID=@shoesid, shoesDraw=@shoesdraw, shoesCouleur=@shoescouleur, legsID=@legsid, legsDraw=@legsdraw, legsCouleur=@legscouleur, torsosID=@torsosid, torsosDraw=@torsosdraw, AccessoiresID=@accessoiresid, AccessoiresDraw=@Accessoiresdraw, AccessoiresCouleur=@Accessoirescouleur WHERE license=@license", {
	['@license'] = license,
	['@topsid'] = 				TenueFemme["Tops"].componentId,
	['@topdraw'] = 				TenueFemme["Tops"].drawableId, 
	['@topscouleur'] = 			TenueFemme["Tops"].textureId, 
	['@undershirtsid'] = 		TenueFemme["Undershirts"].componentId,
	['@undershirtsdraw'] = 		TenueFemme["Undershirts"].drawableId, 
	['@undershirtscouleur'] = 	TenueFemme["Undershirts"].textureId,
	['@shoesid'] = 				TenueFemme["Shoes"].componentId, 
	['@shoesdraw'] = 			TenueFemme["Shoes"].drawableId,
	['@shoescouleur'] = 		TenueFemme["Shoes"].textureId,
	['@legsid'] = 				TenueFemme["Legs"].componentId, 
	['@legsdraw'] = 			TenueFemme["Legs"].drawableId, 
	['@legscouleur'] = 			TenueFemme["Legs"].textureId, 
	['@torsosid'] = 			TenueFemme["Torsos"].componentId, 
	['@torsosdraw'] = 			TenueFemme["Torsos"].drawableId,
	['@accessoiresid'] = 		TenueFemme["Accessories"].componentId,
	['@Accessoiresdraw'] = 		TenueFemme["Accessories"].drawableId,
	['@Accessoirescouleur'] = 	TenueFemme["Accessories"].textureId})
end)

RegisterServerEvent("GTA:LoadVetement")
AddEventHandler("GTA:LoadVetement",function()
	local source = source
	local license = GetPlayerIdentifiers(source)[1]


	MySQL.Async.fetchAll('SELECT * FROM gta_joueurs_vetement WHERE license = @license',{['@license'] = license}, function(res1)
		TriggerClientEvent("GTA:UpdateVetement", source,{res1[1].topsID, res1[1].topsDraw, res1[1].topsCouleur, res1[1].undershirtsID, res1[1].undershirtsDraw, res1[1].undershirtsCouleur, res1[1].torsosID, res1[1].torsosDraw, res1[1].legsID, res1[1].legsDraw, res1[1].legsCouleur, res1[1].shoesID, res1[1].shoesDraw, res1[1].shoesCouleur, res1[1].AccessoiresID, res1[1].AccessoiresDraw, res1[1].AccessoiresCouleur, res1[1].HatsID, res1[1].HatsDraw, res1[1].HatsCouleurs})
	end)
end)