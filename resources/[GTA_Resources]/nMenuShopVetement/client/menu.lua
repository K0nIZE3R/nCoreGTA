tShirtMenu = RageUI.CreateMenu("T-Shirt",  "Magasin de vetement.")
pullMenu = RageUI.CreateMenu("Pull",  "Magasin de vetement.")
vesteMenu = RageUI.CreateMenu("Veste",  "Magasin de vetement.")
pantalonMenu = RageUI.CreateMenu("Pantalon",  "Magasin de vetement.")
chaussureMenu = RageUI.CreateMenu("Chaussure",  "Magasin de vetement.")
bonnetMenu = RageUI.CreateMenu("Chapeau",  "Magasin de vetement.")
accessMenu = RageUI.CreateMenu("Accessoire",  "Magasin de vetement.")

local itemName = " "
local Duree = 0
local index_tShirt, index_pull, indexVeste, indexPantalon, indexChaussure, indexChapeau, indexAccess = 1, 1, 1, 1, 1, 1, 1


--> TShirt Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(tShirtMenu, function()
			for i = 1, #Config.Locations do
                local tShirtPos = Config.Locations[i]["MagasinDeVetement"]["TShirtPos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, tShirtPos["x"], tShirtPos["y"], tShirtPos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('TShirt', tTshirtLabel, index_tShirt, "", {}, true, {
                        onListChange = function(Index, Item)
                            index_tShirt = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 11, tTshirtValue[index_tShirt][1], tTshirtValue[index_tShirt][2], 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 8, tTshirtValue[index_tShirt][5], 0, 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 3, tTshirtValue[index_tShirt][4], 0, 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouveauTshirt", tTshirtValue[index_tShirt][1], tTshirtValue[index_tShirt][2], tTshirtValue[index_tShirt][3], tTshirtValue[index_tShirt][4], tTshirtValue[index_tShirt][5])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)


--> Pull Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(pullMenu, function()
			for i = 1, #Config.Locations do
                local pullPos = Config.Locations[i]["MagasinDeVetement"]["PullPos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, pullPos["x"], pullPos["y"], pullPos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Pull', tPullLabel, index_pull, "", {}, true, {
                        onListChange = function(Index, Item)
                            index_pull = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 11, tPullValue[index_pull][1], tPullValue[index_pull][2], 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 8,  tPullValue[index_pull][5], 0, 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 3,  tPullValue[index_pull][4], 0, 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouveauPull", tPullValue[index_pull][1], tPullValue[index_pull][2], tPullValue[index_pull][3], tPullValue[index_pull][4], tPullValue[index_pull][5])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)

--> Veste Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(vesteMenu, function()
			for i = 1, #Config.Locations do
                local vestePos = Config.Locations[i]["MagasinDeVetement"]["VestePos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, vestePos["x"], vestePos["y"], vestePos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Veste', tVesteLabel, indexVeste, "", {}, true, {
                        onListChange = function(Index, Item)
                            indexVeste = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 11, tVesteValue[indexVeste][1], tVesteValue[indexVeste][2], 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 8,  tVesteValue[indexVeste][5], 0, 0)
                            SetPedComponentVariation(GetPlayerPed(-1), 3,  tVesteValue[indexVeste][4], 0, 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouvelVeste", tVesteValue[indexVeste][1], tVesteValue[indexVeste][2], tVesteValue[indexVeste][3], tVesteValue[indexVeste][4], tVesteValue[indexVeste][5])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)

--> Pantalon Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(pantalonMenu, function()
			for i = 1, #Config.Locations do
                local pantalonPos = Config.Locations[i]["MagasinDeVetement"]["PantalonPos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, pantalonPos["x"], pantalonPos["y"], pantalonPos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Pantalon', tPantalonLabel, indexPantalon, "", {}, true, {
                        onListChange = function(Index, Item)
                            indexPantalon = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 4, tPantalonValue[indexPantalon][1], tPantalonValue[indexPantalon][2], 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouveauPantalon", tPantalonValue[indexPantalon][1], tPantalonValue[indexPantalon][2], tPantalonValue[indexPantalon][3])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)

--> Chaussure Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(chaussureMenu, function()
			for i = 1, #Config.Locations do
                local chaussurePos = Config.Locations[i]["MagasinDeVetement"]["ChaussurePos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, chaussurePos["x"], chaussurePos["y"], chaussurePos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Chaussure', tChaussureLabel, indexChaussure, "", {}, true, {
                        onListChange = function(Index, Item)
                            indexChaussure = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 6, tChaussureValue[indexChaussure][1], tChaussureValue[indexChaussure][2], 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouvelChaussure", tChaussureValue[indexChaussure][1], tChaussureValue[indexChaussure][2], tChaussureValue[indexChaussure][3])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)


--> Bonnet Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(bonnetMenu, function()
			for i = 1, #Config.Locations do
                local chapeauPos = Config.Locations[i]["MagasinDeVetement"]["ChapeauPos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, chapeauPos["x"], chapeauPos["y"], chapeauPos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Chapeau', tChapeauLabel, indexChapeau, "", {}, true, {
                        onListChange = function(Index, Item)
                            indexChapeau = Index;
                            SetPedPropIndex(GetPlayerPed(-1), 0, tChapeauValue[indexChapeau][1], 0, 0)
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouveauBonnet", tChapeauValue[indexChapeau][1], tChapeauValue[indexChapeau][2])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)

--> Accessoire Menu : 
Citizen.CreateThread(function()
    while (true) do
        RageUI.IsVisible(accessMenu, function()
			for i = 1, #Config.Locations do
                local accessPos = Config.Locations[i]["MagasinDeVetement"]["AccessoirePos"]
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = GetDistanceBetweenCoords(plyCoords, accessPos["x"], accessPos["y"], accessPos["z"], true)

                if dist <= 5.0 then
                    Duree = 0
                    RageUI.List('Accessoire', tAccessLabel, indexAccess, "", {}, true, {
                        onListChange = function(Index, Item)
                            indexAccess = Index;
                            SetPedComponentVariation(GetPlayerPed(-1), 7, tAccessValue[indexAccess][1], 0, 0)	
                        end,
                        onSelected = function(Index, Item)
                            TriggerServerEvent("GTA_Vetement:NouveauAccessoire", tAccessValue[indexAccess][1], tAccessValue[indexAccess][2])
                            RageUI.CloseAll(true)
                        end
                    })
                end
            end
		end, function()end)
    Citizen.Wait(Duree)
    end
end)

Citizen.CreateThread(function()
    while true do
        Duree = 250
        if IsNearOfZones() then
            Duree = 0
            
            if GetLastInputMethod(0) then
                Ninja_Core__DisplayHelpAlert("~INPUT_PICKUP~ pour ~b~intéragir")
            else
                Ninja_Core__DisplayHelpAlert("~INPUT_CELLPHONE_EXTRA_OPTION~ pour ~b~intéragir")
            end
        end

        if GetNearZone() == "TshirtMenu" then 
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
               RageUI.Visible(tShirtMenu, not RageUI.Visible(tShirtMenu))
            end
        elseif GetNearZone() == "PullMenu" then
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                RageUI.Visible(pullMenu, not RageUI.Visible(pullMenu))
            end
        elseif GetNearZone() == "VesteMenu" then
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                RageUI.Visible(vesteMenu, not RageUI.Visible(vesteMenu))
            end
        elseif GetNearZone() == "PantalonMenu" then 
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                RageUI.Visible(pantalonMenu, not RageUI.Visible(pantalonMenu))
            end
        elseif GetNearZone() == "ChaussureMenu" then 
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                RageUI.Visible(chaussureMenu, not RageUI.Visible(chaussureMenu))
            end
        elseif GetNearZone() == "chapeauMenu" then 
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                RageUI.Visible(bonnetMenu, not RageUI.Visible(bonnetMenu))
            end
        elseif GetNearZone() == "accessMenu" then 
            if (IsControlJustReleased(0, 38) or IsControlJustReleased(0, 214)) then  
                RageUI.Visible(accessMenu, not RageUI.Visible(accessMenu))
            end
        end

        if RageUI.Visible(tShirtMenu) or RageUI.Visible(pullMenu) or RageUI.Visible(vesteMenu) or RageUI.Visible(pantalonMenu) or RageUI.Visible(chaussureMenu) or RageUI.Visible(bonnetMenu) or RageUI.Visible(accessMenu) == true then 
            DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
            DisableControlAction(0, 172,true) --DESACTIVE CONTROLL HAUT  
        end

       Citizen.Wait(Duree)
   end
end)