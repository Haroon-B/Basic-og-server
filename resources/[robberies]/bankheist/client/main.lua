ESX = nil

cachedData = {
	["banks"] = {

	}
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) 
			ESX = obj 
		end)

		Citizen.Wait(0)
	end

	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response

	ESX.TriggerServerCallback("bankrobberies:getCurrentRobbery", function(found)
		if found then
			for bank, bankData in pairs(found) do
				cachedData["banks"][bank] = bankData["trolleys"]

				RobberyThread({
					["bank"] = bank,
					["trolleys"] = bankData["trolleys"]
				})
			end
		end
	end)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

RegisterNetEvent("bankrobberies:eventHandler")
AddEventHandler("bankrobberies:eventHandler", function(event, eventData)
	if event == "start_robbery" then
		RobberyThread(eventData)
	elseif event == "alarm_police" then
		if ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "police" then
			SetAudioFlag("LoadMPData", true)
			PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")

			ESX.ShowNotification("Someone is trying to ~r~decrypt ~s~the bank lock - ~g~ " .. eventData .. " ~s~waypoint is now set.")

			local bankValues = Config.Bank[eventData]

			SetNewWaypoint(bankValues["start"]["pos"]["x"], bankValues["start"]["pos"]["y"])

			local blipRobbery = AddBlipForCoord(bankValues["start"]["pos"])

			SetBlipSprite(blipRobbery, 161)
			SetBlipScale(blipRobbery, 2.0)
			SetBlipColour(blipRobbery, 8)

			Citizen.CreateThread(function()
				local startedBlip = GetGameTimer()

				while GetGameTimer() - startedBlip < 60000 * 5 do
					Citizen.Wait(0)
				end

				RemoveBlip(blipRobbery)
			end)
		end
	else
	
	end
		-- print("Wrong event handler.")
end)

Citizen.CreateThread(function()
	Citizen.Wait(100)

	while true do
		local sleepThread = 500

	  	local ped = PlayerPedId()
	  	local pedCoords = GetEntityCoords(ped)

		for bank, values in pairs(Config.Bank) do
			local dstCheck = GetDistanceBetweenCoords(pedCoords, values["start"]["pos"], true)

			if dstCheck <= 5.0 then
				sleepThread = 5

				if dstCheck <= 1.0 then
					local usable, displayText = not cachedData["banks"][bank], cachedData["hacking"] and "~r~Hacking..." or cachedData["banks"][bank] and "~r~Assault~s~ in progress . . ." or "~INPUT_CONTEXT~ Start ~r~breaking~s~ into the device."

					ESX.ShowHelpNotification(displayText)

					if IsControlJustPressed(0, 38) then
						if usable then
							TryHackingDevice(bank)
						end
					end
				end

				DrawScriptMarker({
					["type"] = 6,
					["pos"] = values["start"]["pos"] - vector3(0.0, 0.0, 0.985),
					["r"] = 255,
					["g"] = 0,
					["b"] = 0
				})
			end
		end
		Citizen.Wait(sleepThread)
	end
	
end)
RegisterNetEvent("ir_force:estefade_az_item")
AddEventHandler("ir_force:estefade_az_item",function(source)
	local player = PlayerPedId(source)
	local coords = GetEntityCoords(player)
	if GetDistanceBetweenCoords(coords, vector3(261.58, 222.05, 106.28), true) <= 2.5 then
		thermite()
		ESX.ShowNotification("~r~~h~Planting")
	end
end)


local thermited = 0
RegisterNetEvent("ir_force:terkidan")
AddEventHandler("ir_force:terkidan",function(thermiteID,doorID)
	thermited = doorID
	terkidan(thermiteID)
end)

RegisterNetEvent('ir_force:bazshodan')
AddEventHandler('ir_force:bazshodan', function(x,y,z,doortype)
	local coords = {x,y,z}
	local obs, distance = ESX.Game.GetClosestObject('hei_v_ilev_bk_gate2_pris', coords)
	local pos = GetEntityCoords(obs);
	local rotation = GetEntityHeading(obs) + 70
	globalcoords = coords
	globalrotation = rotation
	globalDoortype = doortype
	Citizen.CreateThread(function()
	Wait(2000)
	SetEntityHeading(obs, globalrotation)
	end)
end)