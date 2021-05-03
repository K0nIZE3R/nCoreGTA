--||@SuperCoolNinja.||--

RegisterServerEvent('GTA_Police:Menotter_DemenotterServer')
AddEventHandler('GTA_Police:Menotter_DemenotterServer', function(joueurMenotter, target)
    if joueurMenotter == true then 
        TriggerClientEvent("GTA_Police:Menotter_Demenotter",target, true)
        TriggerClientEvent('nMenuNotif:showNotification', source, "l'individu est ~g~menotté")
        TriggerClientEvent('nMenuNotif:showNotification', target, "~b~La police ~w~vous ~r~menotté")
    else
        TriggerClientEvent("GTA_Police:Menotter_Demenotter", target, false)
        TriggerClientEvent('nMenuNotif:showNotification', target, "~b~La police ~w~vous ~g~démenotte")
        TriggerClientEvent('nMenuNotif:showNotification', source, "l'individu est ~r~démenotter")
    end
end)