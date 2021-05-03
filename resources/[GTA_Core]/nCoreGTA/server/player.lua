Player = {}
Player.__index = Player
PlayersSource = {}


--[=====[
        Synchro toute les 5 minute des donnée du player sauvegarder dans la table PlayerSource :
]=====]
Citizen.CreateThread(function()
    while true do
        for k,v in pairs(PlayersSource) do
            SyncPlayer(v, k)
        end
		TriggerClientEvent("NUI-Notification", {"Synchronisation éfféctué."})
        Wait(config.timerPlayerSynchronisation)
    end
end)


--[=====[
        Player Disconnect :
]=====]
AddEventHandler('playerDropped', function(reason)
	local source = source
	if PlayersSource[source] ~= nil then
		SyncPlayer(PlayersSource[source], source)
		PlayersSource[source] = nil
	end
end)


--[=====[
        Player Création :
]=====]
function Player:New(license, banque) 
	MySQL.Async.execute('INSERT INTO gta_joueurs (`license`, `banque`, `inventaire`, `identiter`) VALUES (@license, @banque, @inventaire, @identiter)',{ ['@license'] = license, ['@banque'] = banque, ['@inventaire'] = "[]", ['@identiter'] = "[]"})

	local id = MySQL.Sync.fetchAll("SELECT id FROM gta_joueurs WHERE license = @identifier", {
        ['@identifier'] = license
    })

    return id[1].id --> Ceci return l'unique id qui est auto incrementé a la création du player depuis la bdd.
end


--[=====[
        En Update la base de donnée avec les nouvel donnée du player sauvegarder dans la table PlayerSource :
]=====]
function SyncPlayer(p, id)
	local inventaire = json.encode(p.inventaire)
	local lastPosition = "{" .. p.pos.x .. ", " .. p.pos.y .. ",  " .. p.pos.z.. "}"
    local identity = json.encode(p.identiter)
	MySQL.Sync.execute("UPDATE `gta_joueurs` SET inventaire = @inventaire, faim = @newFaim, soif = @newSoif, identiter = @identity, banque = @banque, lastpos = @lastpos, phone_number = @Number, isAdmin = @isAdmin, enService = @service, grade = @grade, job = @job WHERE gta_joueurs.id = @id", {
        ["@inventaire"] = inventaire,
        ["@newFaim"] = p.faim,
        ["@newSoif"] = p.soif,
        ["@identity"] = identity,
        ["@banque"] = p.banque,
        ["@lastpos"] = lastPosition,
        ["@isAdmin"] = p.isAdmin,
        ["@service"] = p.enService,
        ["@grade"] = p.grade,
        ["@job"] = p.job,
		["@Number"] = p.phone_number,
		["@id"] = id,
    })

	print("^2ID : ^7"..id.." joueur synchroniser.")
end


--[=====[
        Function Util pour le gcphone : 
]=====]
math.randomseed(os.time()) 
local function getPhoneRandomNumber()
   local numBase0 = math.random(100,999)
   local numBase1 = math.random(0,999)
   local num = string.format("%03d-%03d", numBase0, numBase1)

   return num
end

function getHistoriqueCall (num)
   local res = MySQL.Async.execute("SELECT * FROM phone_calls WHERE owner = @num ORDER BY time DESC LIMIT 120", {['@num'] = num})	
   return res
end

function sendHistoriqueCall(src, num) 
   MySQL.Async.fetchAll('SELECT * FROM phone_calls WHERE owner = @num ORDER BY time DESC LIMIT 120',{['@num'] = num}, function(res)
	   TriggerClientEvent('gcPhone:historiqueCall', src, res)
   end)
end

--[=====[
        C'est ici que l'on gére la création du player : 
]=====]
RegisterServerEvent('GTA:CreationJoueur')  --> cette event sert uniquement a créer votre perso.
AddEventHandler('GTA:CreationJoueur', function()
	local source = source
    local license = GetPlayerIdentifiers(source)[1]

	local result = MySQL.Sync.fetchAll("SELECT * FROM gta_joueurs WHERE license = @identifier", {
        ['@identifier'] = license
    })

	PlayersSource[source] = {}

	--> Create Data player : 
	if result[1] == nil then
		local randomPhoneNumber = getPhoneRandomNumber() 
		local id = Player:New(license, config.banque)
		PlayersSource[source].source = source
        PlayersSource[source].inventaire = {}
        PlayersSource[source].identiter = {}
        PlayersSource[source].id = id
		PlayersSource[source].faim = 100
        PlayersSource[source].soif = 100
        PlayersSource[source].banque = config.banque 
        PlayersSource[source].pos = vector3(-887.48388671875, -2311.68872070313, -3.50776553153992)
        PlayersSource[source].job = "Chomeur"
        PlayersSource[source].grade = 0
        PlayersSource[source].enService = 0
        PlayersSource[source].isAdmin = 0
        PlayersSource[source].isFirstConnection = 0
        PlayersSource[source].phone_number = randomPhoneNumber



		MySQL.Async.execute('INSERT INTO gta_joueurs_humain (`license`) VALUES (@license)',{ ['@license'] = license})
		MySQL.Async.execute('INSERT INTO gta_joueurs_vetement (`license`) VALUES (@license)',{ ['@license'] = license})

        Wait(5000)
		TriggerClientEvent("GTA:BeginCreation", source)
	else
		--> Load Data player : 
		local inv = json.decode(result[1].inventaire)
		local pos = json.decode(result[1].lastpos)
        local identiter = json.decode(result[1].identiter)
        PlayersSource[source].source = source
        PlayersSource[source].inventaire = inv
        PlayersSource[source].identiter = identiter
        PlayersSource[source].id = result[1].id
        PlayersSource[source].faim = result[1].faim
        PlayersSource[source].soif = result[1].soif
        PlayersSource[source].banque = result[1].banque
        PlayersSource[source].pos = vector3(pos[1], pos[2], pos[3])
        PlayersSource[source].job = result[1].job
        PlayersSource[source].job_grade = result[1].grade
        PlayersSource[source].isAdmin = result[1].isAdmin
		PlayersSource[source].enService = result[1].enService
        PlayersSource[source].phone_number = result[1].phone_number

		MySQL.Async.fetchAll('SELECT * FROM gta_joueurs_humain WHERE license = @license',{['@license'] = license}, function(res2)
			TriggerClientEvent("GTA:UpdatePersonnage", source, res2[1].sex, res2[1].cheveux, res2[1].couleurCheveux, res2[1].couleurYeux, res2[1].pere, res2[1].mere, res2[1].couleurPeau, res2[1].visage)
		end)
	end

	Wait(1000)
	
	local Myphone_number = MySQL.Sync.fetchScalar("SELECT phone_number FROM gta_joueurs WHERE license = @username", {['@username'] = license})
	if Myphone_number then
		TriggerClientEvent("gcPhone:myPhoneNumber", source, Myphone_number)
		
		MySQL.Async.fetchAll('SELECT * FROM phone_users_contacts WHERE identifier = @identifier',{['@identifier'] = license}, function(res2)
			TriggerClientEvent("gcPhone:contactList", source, res2)
		end)

		MySQL.Async.execute('SELECT phone_messages.* FROM phone_messages LEFT JOIN gta_joueurs ON gta_joueurs.license = @identifier WHERE phone_messages.receiver = gta_joueurs.phone_number',{ ['identifier'] = license},function(result) 
			if (result) then
				TriggerClientEvent("gcPhone:allMessage", source, result)
			end
		end)

		sendHistoriqueCall(source, Myphone_number)
	end

	TriggerClientEvent("GTA:JoueurLoaded", source, PlayersSource[source], config.itemList)

    Wait(5000)
    
	TriggerClientEvent("GTA:Refreshinventaire", source, PlayersSource[source].inventaire, GetInvWeight(PlayersSource[source].inventaire))
	TriggerClientEvent("GTA:RefreshFoodsStat", source, PlayersSource[source].faim, PlayersSource[source].soif)
	TriggerClientEvent("GTA:RefreshPlayerInfo", source, PlayersSource[source].identiter, PlayersSource[source].banque)
end)


--[=====[
    	cette event sert uniquement a ajouté de l'argent en banque.
]=====]
RegisterServerEvent('GTA:AjoutArgentBanque')
AddEventHandler('GTA:AjoutArgentBanque', function(id, value)
	PlayersSource[id].banque = PlayersSource[id].banque + tonumber(value)
end)


--[=====[
    	cette event sert uniquement a retirer votre argent en banque par une valeur en parametre. comme exemple payé une amende.
]=====]
RegisterServerEvent('GTA:RetirerArgentBanque')
AddEventHandler('GTA:RetirerArgentBanque', function(id, value)
    PlayersSource[id].banque = PlayersSource[id].banque - tonumber(value)
end)


--[=====[
    	cette event sert uniquement a get l'argent de banque.
]=====]
RegisterServerEvent('GTA:GetArgentBanque') 
AddEventHandler('GTA:GetArgentBanque', function(id, callback)
	callback(PlayersSource[id].banque)
end)


local items = config.itemList
function GetInvWeight(inv)
    local countWeight = 0
    for _,v in pairs(inv) do
        countWeight = items[v.item].weight * v.count
    end
    return countWeight
end


AddEventHandler('GTA:GetJoueurs', function(cb)
    cb(PlayersSource)
end)




