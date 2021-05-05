mainMenu = RageUI.CreateMenu("",  "Menu Interaction")
local subInventaire =  RageUI.CreateSubMenu(mainMenu, "Inventaire", "Votre inventaire.")
local subPapiers =  RageUI.CreateSubMenu(mainMenu, "Information personnel", "Votre portefeuille.")
local subTenues =  RageUI.CreateSubMenu(mainMenu, "Tenue", "Votre tenue.")
local subOptions =  RageUI.CreateSubMenu(mainMenu, "Option menu", "options.")

local isMouseEnable, hautMis, basMis, chaussureMis, ChapeauMis, isFoodHudEnable = true, true, true, true, false, true
local isEssenceHudActiver = true
local pInv = {}
local pWeight = 0
local item = {
    item = "",
    label = "",
    count = 0,
    args = {},
    id = 0
}


RegisterNetEvent("GTA:UpdateInventaire")
AddEventHandler("GTA:UpdateInventaire", function(inv, weight)
    if inv ~= nil then pInv = inv end
    if weight ~= nil then pWeight = weight end

    for _,v in pairs(pInv) do
        if v.itemId == item.id then
            item.count = v.count
        end
    end
end)

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(1.0)
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button('Inventaire', "", {}, true, {
                onSelected = function()
                playerInventaire = exports.nCoreGTA:GetPlayerInv()
                pInv = playerInventaire.inventaire
                pWeight = playerInventaire.weight or 0
                --TriggerEvent("GTA:LoadWeaponPlayer")
            end}, subInventaire)

            RageUI.Button('Mon Portefeuille', "", {}, true, {}, subPapiers);
            RageUI.Button('Tenue', "", {}, true, {}, subTenues);
            RageUI.Checkbox('Activer/désactiver hud faim/soif', "", isFoodHudEnable, {}, {
                onChecked = function()
                    TriggerEvent("EnableDisableHUDFS", true)
                end,
                onUnChecked = function()
                    TriggerEvent("EnableDisableHUDFS", false)
                end,
                onSelected = function(Index)
                    isFoodHudEnable = Index
                end
            })
            RageUI.Checkbox('Activer/désactiver hud essence', "", isEssenceHudActiver, {}, {
                onChecked = function()
                    TriggerEvent("fuel-vehicle:AfficherHud", true)
                end,
                onUnChecked = function()
                    TriggerEvent("fuel-vehicle:AfficherHud", false)
                end,
                onSelected = function(Index)
                    isEssenceHudActiver = Index
                end
            })
            RageUI.Button('~g~Sauvegarder ma position', "", {}, true, { onSelected = function() RequestToSave() end});
            RageUI.Button('Options Menu', "", {}, true, {}, subOptions);
        end, function()end)

        --> SubMenu Inventaire : 
        RageUI.IsVisible(subInventaire, function()

            TriggerEvent("ShowMarkerTarget")

            for _,v in pairs(pInv) do
                if v.count > 0 then 
                    RageUI.List(v.label .. " ".. v.count, {
                            { Name = "~h~~b~Utiliser~w~"},
                            { Name = "~h~~g~Donner~w~"},
                            { Name = "~h~~r~Jeter~w~"},
                        }, v.index or 1, "", {}, true, {
                            onListChange = function(Index, Item)
                                v.index = Index;
                            end,

                            onSelected = function(Index, Item)
                                item.label = v.label  
                                item.count = v.count
                                item.args = v.args
                                item.item = v.item
                                item.id = v.itemId

                                if Index == 1 then  
                                   --> Utiliser
                                elseif Index == 2 then 
                                    --> Donner
                                    --[[ 
                                    local ClosestPlayerSID = GetPlayerServerId(GetClosestPlayer())
                                    if ClosestPlayerSID ~= 0 then
                                        local result = InputNombre("Montant : ")
                        
                                        if tonumber(result) == nil then
                                            TriggerEvent("NUI-Notification", {"Veuillez inserer un nombre correct !", "warning"})
                                            return nil
                                        end
                        
                                        if tonumber(v.quantity) >= tonumber(result) and tonumber(result) > 0 then
                                            TriggerServerEvent('player:giveItem',ClosestPlayerSID,k, v.libelle,tonumber(result))
                                        else
                                            TriggerEvent("NUI-Notification", {"Vous n'avez pas assez d'items.", "warning"})
                                        end
                                    else
                                        TriggerEvent("NUI-Notification", {"Aucune personne devant vous !", "warning"})
                                    end
                                    Wait(250)
                            		TriggerEvent("GTA:LoadWeaponPlayer")
                                    ]]
                                elseif Index == 3 then
                                    local count = KeyboardAmount()
                                    if count ~= nil and count > 0 and count <= item.count then
                                        TriggerServerEvent("GTA:RemoveItem", item.item, item.id, count)
                                        TriggerEvent("NUI-Notification", {"Vous avez jeter x" ..count.. " "..item.label})
                                    end

                                    --[[ 
                                        local result = InputNombre("Montant : ")

                                        if tonumber(result) == nil then
                                            TriggerEvent("NUI-Notification", {"Veuillez inserer un nombre correct !", "warning"})
                                            return nil
                                        end
                            
                                        if tonumber(v.quantity) >= tonumber(result) and tonumber(result) > 0 then
                                            TriggerEvent('player:looseItem',k,tonumber(result))
                                            TriggerEvent("NUI-Notification", {"Vous avez jeter x".. tonumber(result) .. " "..v.libelle})
                                        else
                                            TriggerEvent("NUI-Notification", {"Vous n'avez pas tout ça sur vous d'items."})
                                        end
                                        Wait(250)
                                        TriggerEvent("GTA:LoadWeaponPlayer")
                                    ]]
                                end
                        end,
                    })
                end
            end
        end, function() end)

        --> SubMenu Portefeuille : 
        RageUI.IsVisible(subPapiers, function()
            
            TriggerEvent("ShowMarkerTarget")

            RageUI.Button('Regarder votre identité', "", {}, true, {
                onSelected = function()
                TriggerServerEvent("GTA:ChercherSonIdentiter")
            end});

            RageUI.Button('Montrer votre identité', "", {}, true, {
                onSelected = function()
                    local ClosestPlayerSID = GetPlayerServerId(GetClosestPlayer())
                    if ClosestPlayerSID ~= 0 then
                        TriggerServerEvent("GTA:MontrerSonIdentiter", ClosestPlayerSID)
                    else
                        TriggerEvent("NUI-Notification", {"Aucune personne devant vous !", "warning"})
                    end
            end});
        end, function() end)

        --> Tenue Menu : 
        RageUI.IsVisible(subTenues, function()
            RageUI.Checkbox('Mettre/Retirer haut', "", hautMis, {}, {
                onChecked = function()
                    TriggerEvent("TaskPlayAnimation", GetPlayerPed(-1), "clothingtie", "try_tie_negative_a", 1500, 51)
                    TriggerServerEvent("GTA:GetHautJoueur")
                end,
                onUnChecked = function()
                    TriggerEvent("TaskPlayAnimation", GetPlayerPed(-1), "clothingtie", "try_tie_negative_a", 1500, 51)
                    TriggerEvent("GTA:RetirerHautJoueur")
                end,
                onSelected = function(Index)
                    hautMis = Index
                end
            })

            RageUI.Checkbox('Mettre/Retirer bas', "", basMis, {}, {
                onChecked = function()
                    TriggerEvent("TaskPlayAnimation", GetPlayerPed(-1), "re@construction", "out_of_breath", 1300, 51)
                    TriggerServerEvent("GTA:GetBasJoueur")
                end,
                onUnChecked = function()
                    TriggerEvent("TaskPlayAnimation", GetPlayerPed(-1), "re@construction", "out_of_breath", 1300, 51)
                    TriggerEvent("GTA:RetirerBasJoueur")
                end,
                onSelected = function(Index)
                    basMis = Index
                end
            })

            RageUI.Checkbox('Mettre/Retirer chaussures', "", chaussureMis, {}, {
                onChecked = function()
                    TriggerEvent("TaskPlayAnimation", GetPlayerPed(-1), "random@domestic", "pickup_low", 1200, 0)
                    TriggerServerEvent("GTA:GetChaussureJoueur")
                end,
                onUnChecked = function()
                    TriggerEvent("TaskPlayAnimation", GetPlayerPed(-1), "random@domestic", "pickup_low", 1200, 0)
                    TriggerEvent("GTA:RetirerChaussureJoueur")
                end,
                onSelected = function(Index)
                    chaussureMis = Index
                end
            })

            RageUI.Checkbox('Mettre/Retirer bonnets', "", ChapeauMis, {}, {
                onChecked = function()
                    TriggerEvent("TaskPlayAnimation", GetPlayerPed(-1), "mp_masks@standard_car@ds@", "put_on_mask", 600, 51)
                    TriggerServerEvent("GTA:GetBonnetJoueur")
                end,
                onUnChecked = function()
                    TriggerEvent("TaskPlayAnimation", GetPlayerPed(-1), "mp_masks@standard_car@ds@", "put_on_mask", 600, 51)
                    TriggerEvent("GTA:RetirerBonnetJoueur")
                end,
                onSelected = function(Index)
                    ChapeauMis = Index
                end
            })
        end, function()end)

        --> Option Menu : 
        RageUI.IsVisible(subOptions, function()
            RageUI.Checkbox('🖱️ Activer/désactiver souris', "", isMouseEnable, {}, {
                onChecked = function()
                    mainMenu:DisplayMouse(true)
                    subInventaire:DisplayMouse(true)
                    subPapiers:DisplayMouse(true)
                    subOptions:DisplayMouse(true)
                end,
                onUnChecked = function()
                    mainMenu:DisplayMouse(false)
                    subInventaire:DisplayMouse(false)
                    subPapiers:DisplayMouse(false)
                    subOptions:DisplayMouse(false)
                end,
                onSelected = function(Index)
                    isMouseEnable = Index
                end
            })
        end, function()end)
        
        if IsControlJustReleased(0, 244) then
            TriggerServerEvent("GTA:GetPlayerSexServer")
            RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
        end
        
        if RageUI.Visible(mainMenu) or RageUI.Visible(subInventaire) or RageUI.Visible(subPapiers) or RageUI.Visible(subTenues) or RageUI.Visible(subOptions) then 
            DisableControlAction(0, 140, true) --> DESACTIVER LA TOUCHE POUR PUNCH
           DisableControlAction(0, 172, true) --DESACTIVE CONTROLL HAUT  
       end
    end
end)