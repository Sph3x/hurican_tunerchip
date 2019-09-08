ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local G = GetCurrentResourceName()
ESX.RegisterUsableItem('tunerchip', function(source)
	if G = "hurican_tunerchip" then
		TriggerClientEvent('hurican_tunerchip:onUse', source)
	end
end)