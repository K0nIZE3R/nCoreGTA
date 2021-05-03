--||@SuperCoolNinja.||--

RegisterServerEvent('nBanqueSolde:SRender')
AddEventHandler('nBanqueSolde:SRender', function()
	local source = source	
	TriggerClientEvent('nBanqueSolde:CRender', source)
end)

RegisterServerEvent('nBanqueSolde:PermissionRABanque')
AddEventHandler('nBanqueSolde:PermissionRABanque', function(somme)
	local source = source			
	TriggerEvent('GTA:RetirerAtmBanque', source, tonumber(somme))
end)


RegisterServerEvent('nBanqueSolde:PermissionDABanque')
AddEventHandler('nBanqueSolde:PermissionDABanque', function(somme)
	local source = source	
	TriggerEvent('GTA:DeposerAtmBanque', source, tonumber(somme))
end)