ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)


local TackleKey = 48 -- Change to a number which can be found here: https://wiki.fivem.net/wiki/Controls
local TackleTime = 7000 -- In milliseconds

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, TackleKey) then
			local isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)
			if not isInVeh and GetEntitySpeed(PlayerPedId()) > 2.5 then
				TryTackle()
			end
		end
	end
end)






TimerEnabled = false

function TryTackle()
		if not TimerEnabled then
			local target, distance = ESX.Game.GetClosestPlayer()
			playerheading = GetEntityHeading(GetPlayerPed(-1))
			playerlocation = GetEntityForwardVector(PlayerPedId())
			playerCoords = GetEntityCoords(GetPlayerPed(-1))
			local target_id = GetPlayerServerId(target)
			if(distance ~= -1 and distance < 2) then
				local maxheading = (GetEntityHeading(PlayerPedId()) + 15.0)
				local minheading = (GetEntityHeading(PlayerPedId()) - 15.0)
				local theading = (GetEntityHeading(target))

				TriggerServerEvent('CrashTackle',GetPlayerServerId(target))
				TriggerEvent("animation:tacklelol") 

				TimerEnabled = true
				Citizen.Wait(4500)
				TimerEnabled = false

			else
				TimerEnabled = true
				Citizen.Wait(1000)
				TimerEnabled = false

			end

		end
--SetPedToRagdoll(PlayerPedId(), 500, 500, 0, 0, 0, 0) 
end



RegisterNetEvent('playerTackled')
AddEventHandler('playerTackled', function()
	SetPedToRagdoll(PlayerPedId(), math.random(8500), math.random(8500), 0, 0, 0, 0) 

	TimerEnabled = true
	Citizen.Wait(1500)
	TimerEnabled = false
end)

function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end


function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end


function LoadAnimationDictionary(animationD) -- Simple way to load animation dictionaries to save lines.
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end


RegisterNetEvent('animation:tacklelol')
AddEventHandler('animation:tacklelol', function()

		if not IsPedRagdoll(PlayerPedId()) then

			local lPed = PlayerPedId()

			RequestAnimDict("swimming@first_person@diving")
			while not HasAnimDictLoaded("swimming@first_person@diving") do
				Citizen.Wait(1)
			end
			
			if IsEntityPlayingAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
				ClearPedSecondaryTask(lPed)

			else
				TaskPlayAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 8.0, -8, -1, 49, 0, 0, 0, 0)
				seccount = 3
				while seccount > 0 do
					Citizen.Wait(100)
					seccount = seccount - 1

				end
				ClearPedSecondaryTask(lPed)
				SetPedToRagdoll(PlayerPedId(), 150, 150, 0, 0, 0, 0) 
			end		

		end

end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end
