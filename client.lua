--[[ Made by hurican       -       discord: hurican#5083 ]]--

local display = false
local vehicle
local lastVehicle = nil
local currentGear
local currentFuel
local currentBraking
local currentDrive
local tunercount = 0

--< Comment out if not using ESX 
ESX              = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
-->

--[[ Uncomment if you want the command
RegisterCommand('tunerchip', function(source)
	local player = PlayerPedId()
	if IsPedInAnyVehicle(player, false) then
		if vehicle ~= lastVehicle then
			currentGear = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift")
			currentFuel = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fAntiRollBarForce")
			currentBraking = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeBiasFront")
			currentDrive = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront")
		end
		openGui(not display)
	else
		exports['mythic_notify']:DoHudText('inform', 'You are not in a vehicle')
	end
end)
--]]


 --< Comment out if you are not using ESX
RegisterNetEvent('hurican_tunerchip:onUse')
AddEventHandler('hurican_tunerchip:onUse', function()
	local player = PlayerPedId()
	if IsPedInAnyVehicle(player, false) then
		vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		TriggerEvent("mythic_progbar:client:progress", {
	        name = "unique_action_name",
	        duration = 5000,
	        label = "Connecting Tuner Laptop",
	        useWhileDead = false,
	        canCancel = true,
	        controlDisables = {
	            disableMovement = true,
	            disableCarMovement = true,
	            disableMouse = false,
	            disableCombat = true,
	        },
	        animation = {
	            animDict = nil,
	            anim = nil,
	        },
	        prop = {
	            model = nil,
	        }
	    }, function(status)
	        if not status then
	            if vehicle ~= lastVehicle then
					currentGear = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift")
					currentFuel = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fAntiRollBarForce")
					currentBraking = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeBiasFront")
					currentDrive = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront")
				end
				openGui(not display)
	        end
	    end)
	else
		exports['mythic_notify']:DoHudText('inform', 'You are not in a vehicle')
	end
end)
-->

RegisterNUICallback("exit", function()
	openGui(false)
end)

RegisterNUICallback("save", function(data)
	if data.boost ~= nil then
		SetVehicleEnginePowerMultiplier(vehicle, data.boost / 1.8)
	else
		SetVehicleEnginePowerMultiplier(vehicle, 0.0)
	end
	if data.fuel ~= nil then
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fAntiRollBarForce", tonumber(data.fuel))
	else
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fAntiRollBarForce", currentFuel)
	end
	if data.gear ~= nil then
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift", tonumber(data.gear) + currentGear)
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift", tonumber(data.gear) + currentGear)
	else
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift", currentGear)
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift", currentGear)
	end
	if data.braking ~= nil then
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeBiasFront", tonumber(data.braking) / 10)
	else
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeBiasFront", currentBraking)
	end
	if data.drive ~= nil then
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront", tonumber(data.drive) / 10)
	else
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront", currentDrive)
	end
	lastVehicle = vehicle
end)

Citizen.CreateThread(function()
	while display do
		Citizen.Wait(0)
		DisableControlAction(0, 1, display)
		DisableControlAction(0, 2, display)
		DisableControlAction(0, 142, display)
		DisableControlAction(0, 18, display)
		DisableControlAction(0, 322, display)
		DisableControlAction(0, 106, display)
	end
end)

function openGui (bool)
	display = bool
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		type = "ui",
		status = bool
	})
end