tTshirtLabel, tTshirtValue = {}, {}
tPullLabel, tPullValue = {}, {}
tVesteLabel, tVesteValue = {}, {}
tPantalonLabel, tPantalonValue = {}, {}
tChaussureLabel, tChaussureValue = {}, {}
tChapeauLabel, tChapeauValue = {}, {}
tAccessLabel, tAccessValue = {}, {}


Ninja_Core__DisplayHelpAlert = function(msg)
	BeginTextCommandDisplayHelp("STRING");  
    AddTextComponentSubstringPlayerName(msg);  
    EndTextCommandDisplayHelp(0, 0, 1, -1);
end

square = math.sqrt
function getDistance(a, b) 
  local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
  return square(x*x+y*y+z*z)
end

--> Retourne le sex de votre joueurs :
function getSexVetement()
	for i = 1, #Config.Locations do
		if IsPedModel(GetPlayerPed(-1), "mp_m_freemode_01") then
			return Config.Locations[i]["Homme"]
		else
			return Config.Locations[i]["Femme"]
		end
	end
end

--> Return vrais si vous êtes proche de la zone :
function IsNearOfZones()
    for i = 1, #Config.Locations do
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

        --> Position des tenue : 
        local tShirtPos = Config.Locations[i]["MagasinDeVetement"]["TShirtPos"]
        local pullPos = Config.Locations[i]["MagasinDeVetement"]["PullPos"]
		local vestePos = Config.Locations[i]["MagasinDeVetement"]["VestePos"]
		local pantalonPos = Config.Locations[i]["MagasinDeVetement"]["PantalonPos"]
		local chaussurePos = Config.Locations[i]["MagasinDeVetement"]["ChaussurePos"]
		local chapeauPos = Config.Locations[i]["MagasinDeVetement"]["ChapeauPos"]
		local accessPos = Config.Locations[i]["MagasinDeVetement"]["AccessoirePos"]
        

        --> Distance des tenues : 
        local dTShirt = getDistance(plyCoords, tShirtPos, true)
        local dPull = getDistance(plyCoords, pullPos, true)
        local dVeste = getDistance(plyCoords, vestePos, true)
        local dPantalon = getDistance(plyCoords, pantalonPos, true)
        local dChaussure = getDistance(plyCoords, chaussurePos, true)
        local dChapeau = getDistance(plyCoords, chapeauPos, true)
        local dAccess = getDistance(plyCoords, accessPos, true)



        if (dTShirt <= 1.0) or (dPull <= 1.0) or (dPull <= 1.0) or (dVeste <= 1.0) or (dPantalon <= 1.0) or (dChaussure <= 1.0) or (dChapeau <= 1.0) or (dAccess <= 1.0) then
            return true
        else
            return false 
        end
    end
end


--> Retourne le nom de votre zone le plus proche :
function GetNearZone()
    for i = 1, #Config.Locations do
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

        --> Position des tenue : 
        local tShirtPos = Config.Locations[i]["MagasinDeVetement"]["TShirtPos"]
        local pullPos = Config.Locations[i]["MagasinDeVetement"]["PullPos"]
        local vestePos = Config.Locations[i]["MagasinDeVetement"]["VestePos"]
		local pantalonPos = Config.Locations[i]["MagasinDeVetement"]["PantalonPos"]
		local chaussurePos = Config.Locations[i]["MagasinDeVetement"]["ChaussurePos"]
		local chapeauPos = Config.Locations[i]["MagasinDeVetement"]["ChapeauPos"]
        local accesPos = Config.Locations[i]["MagasinDeVetement"]["AccessoirePos"]
        
        
        
        
        --> Distance des tenues : 
        local distTShirt = getDistance(plyCoords, tShirtPos, true)
        local distPull = getDistance(plyCoords, pullPos, true)
        local distVeste = getDistance(plyCoords, vestePos, true)
        local distPantalon = getDistance(plyCoords, pantalonPos, true)
        local distChaussure = getDistance(plyCoords, chaussurePos, true)
        local distChapeau = getDistance(plyCoords, chapeauPos, true)
        local distAccess = getDistance(plyCoords, accesPos, true)


        if (distTShirt <= 2.0) then
            return "TshirtMenu"
        elseif (distPull <= 2.0) then 
            return "PullMenu"
        elseif (distVeste <= 2.0) then 
            return "VesteMenu"
        elseif (distPantalon <= 2.0) then 
            return "PantalonMenu"
        elseif (distChaussure <= 2.0) then 
            return "ChaussureMenu"
        elseif (distChapeau <= 2.0) then 
            return "chapeauMenu"
        elseif (distAccess <= 2.0) then 
            return "accessMenu"
        else
            return nil 
        end
    end
end


-- Get le nom des TShirt : 
function GetLabelTShirt()
	for k, v in pairs(getSexMenu["Tshirt"]) do
        table.insert(tTshirtLabel, k)
        table.insert(tTshirtValue, v)
	end
end

-- Get le nom des Pull : 
function GetLabelPulls()
	for k, v in pairs(getSexMenu["Pull"]) do
        table.insert(tPullLabel, k)
        table.insert(tPullValue, v)
	end
end

-- Get le nom des Veste : 
function GetLabelVeste()
	for k, v in pairs(getSexMenu["Veste"]) do
        table.insert(tVesteLabel, k)
        table.insert(tVesteValue, v)
	end
end

-- Get le nom des Pantalons : 
function GetLabelPantalons()
	for k, v in pairs(getSexMenu["Pantalon"]) do
        table.insert(tPantalonLabel, k)
        table.insert(tPantalonValue, v)
	end
end

-- Get le nom des Chaussures : 
function GetLabelChaussures()
	for k, v in pairs(getSexMenu["Chaussure"]) do
        table.insert(tChaussureLabel, k)
        table.insert(tChaussureValue, v)
	end
end

-- Get le nom des Chapeau : 
function GetLabelChapeau()
	for k, v in pairs(getSexMenu["Chapeau"]) do
        table.insert(tChapeauLabel, k)
        table.insert(tChapeauValue, v)
	end
end

-- Get le nom des Accessoires : 
function GetLabelAccessoire()
	for k, v in pairs(getSexMenu["Accessoire"]) do
        table.insert(tAccessLabel, k)
        table.insert(tAccessValue, v)
	end
end

--> Blips Magasin de vêtement : 
Citizen.CreateThread(function()
    for i = 1, #Config.Locations do
        local blip = Config.Locations[i]["MagasinDeVetement"]
        blip = AddBlipForCoord(blip["x"], blip["y"], blip["z"])

        SetBlipSprite(blip, 73)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, 12)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Magasin de vêtement")
        EndTextCommandSetBlipName(blip)
    end
end)

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
        getSexMenu = getSexVetement()
        Wait(150)
    
        GetLabelTShirt()
        GetLabelPulls()
        GetLabelVeste()
        GetLabelPantalons()
        GetLabelChaussures()
        GetLabelChapeau()
        GetLabelAccessoire()
        firstspawn = 1
    end
end)

--> Executer une fois la ressource restart : 
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
	end
	
    getSexMenu = getSexVetement()
    Wait(150)

    GetLabelTShirt()
    GetLabelPulls()
    GetLabelVeste()
    GetLabelPantalons()
    GetLabelChaussures()
    GetLabelChapeau()
    GetLabelAccessoire()
end)