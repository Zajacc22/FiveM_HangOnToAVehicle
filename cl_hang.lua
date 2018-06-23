--[[ 

	Created by G.H.0.S.T aka mPH4NT0M
	2018/06/23
	Version 1.0

	This script allows players to hang on the side of specific vehicles.

]]--


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)

		--
		-- Edit button of preference here, default: G
		-- List of controls can be found here https://docs.fivem.net/game-references/controls/
		--
		if IsControlJustPressed(1, 47) then
			SetPedHangOnVehicle()
		end
	end
end)


function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end


function getNearestVeh()
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 3.0, 0.0) -- 3 is the radius infront of player (recommended)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
	return vehicleHandle
end


function SetPedHangOnVehicle()
	local ped = GetPlayerPed(-1)
  	local vehicle = getNearestVeh()
  	local isVehicle = GetEntityType(vehicle) == 2 -- int 2 for vehicle

	--[[ 
		Checks nearest entity is vehicle then checks if driver seat or all seats is/are occupied then set player
		hanging on side depending on vehicle from array above.
 	]]--
  	if isVehicle then 
		local vehicles = {'GRANGER', 'ROOSEVELT', 'ROOSEVELT2', 'FBI2', 'PRANGER'} -- Add allowed vehicles here
  		local model = GetEntityModel(vehicle)
		local name = GetDisplayNameFromVehicleModel(model)

		if not IsVehicleSeatFree(vehicle, -1) or not AreAnyVehicleSeatsFree(vehicle) then
			if has_value(vehicles, name) then
				if name == "GRANGER" then
					-- Right side equals even number (for future improvments)
					SetPedIntoVehicle(ped, vehicle, 3 or 4 or 5 or 6) 
				else
					SetPedIntoVehicle(ped, vehicle, 3 or 4)
				end
			end
		end
	end
end
