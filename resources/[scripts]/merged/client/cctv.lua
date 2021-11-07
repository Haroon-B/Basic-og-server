local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData = {}
local blockbuttons = false
local currentCameraIndex = 0
local currentCameraIndexIndex = 0
local createdCamera = 0
local cameraIsim = ""

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	PlayerData.job = job
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


RegisterCommand("cctv", function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) and vehicleType(GetVehiclePedIsUsing(PlayerPedId())) or (PlayerData.job and PlayerData.job.name == "police") then
		cameraMenu()
		else	
		exports['mythic_notify']:SendAlert('error', 'Youre not in a PD vehicle or you are not a cop.')
	end
end)

Citizen.CreateThread(function()
	while true do
		sleep = 2000
		local ped = PlayerPedId()
		local kordinat = GetEntityCoords(ped)
		local dist = GetDistanceBetweenCoords(kordinat, 459.75, -989.1, 24.91, true)
		if dist < 3.0 then
			sleep = 5
		end
		if dist < 2.0 then
			ESX.ShowHelpNotification('Press ~INPUT_PICKUP~ to access security cameras')
			if IsControlJustReleased(0, 46) then
				TriggerEvent("mythic_progbar:client:progress", {
					name = "unique_action_name",
					duration = 6000,
					label = "Connecting to Database",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = true,
						disableCombat = true,
					},
					animation = {
						animDict = "mp_fbi_heist",
						anim = "loop",
					},
					prop = {
						model = "",
					}
				}, function(status)
					if not status then
						-- Do Something If Event Wasn't Cancelled
					end
				end)
				Wait(6500)
				cameraMenu()
			end
		end
		Citizen.Wait(sleep)
	end
	end)

function marketcameraMenu()
	local elements = {}
	for no, marketler in pairs(cameralar) do
		if no ~= "Motel" and no ~= "Vangelico" and no ~= "Pillbox" and no ~= "Police" and no ~= "TownMotel" and no ~= "Bank" then
			table.insert(elements, {label = no .. " Numbered Market Cameras",  menu = no})
		end
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = "Security cameras",
		align    = 'top-left',
		elements = elements
	}, function(data2, menu2)
		menu2.close()
		FreezeEntityPosition(PlayerPedId(), true)
		blockbuttons = true
		cameraIsim = data2.current.menu
		local firstCamx = cameralar[cameraIsim][1].x
		local firstCamy = cameralar[cameraIsim][1].y
		local firstCamz = cameralar[cameraIsim][1].z
		local firstCamr = cameralar[cameraIsim][1].r
		SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
		ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)

		currentCameraIndex = 1
		currentCameraIndexIndex = 1
		TriggerEvent('esx_securitycam:freeze', true)
		
	end, function(data2, menu2)
		menu2.close()
		FreezeEntityPosition(PlayerPedId(), false)
		blockbuttons = false
	end)
end

function cameraMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = "LSPD - CCTV",
		align    = 'top-left',
		elements = {
			{label = 'Market CC TV', menu = 'market'},
			{label = "Pacific Bank CC TV",  menu = 'Bank'},
			{label = "Paletobay Bank CC TV",  menu = 'TownMotel'},
			{label = "Mission Row CC TV", menu = 'Police'},
			{label = 'Pillbox Hospital CC TV', menu = 'Pillbox'},
			{label = 'Vangelico CC TV', menu = 'Vangelico'},
			{label = 'Pink Cage CC TV', menu = 'Motel'},			
		}
	}, function(data, menu)

		if data.current.menu == "market" then
			marketcameraMenu()
		else
			menu.close()
			blockbuttons = true
			cameraIsim = data.current.menu
			local firstCamx = cameralar[cameraIsim][1].x
			local firstCamy = cameralar[cameraIsim][1].y
			local firstCamz = cameralar[cameraIsim][1].z
			local firstCamr = cameralar[cameraIsim][1].r
			SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
			ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)

			currentCameraIndex = 1
			currentCameraIndexIndex = 1
			TriggerEvent('esx_securitycam:freeze', true)
		end

	end, function(data, menu)
		menu.close()
		blockbuttons = false
	end)
end

Citizen.CreateThread(function()
	while true do
		local time = 1000
		if createdCamera ~= 0 then
			time = 1
			local instructions = CreateInstuctionScaleform("instructional_buttons")

			DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
			SetTimecycleModifier("scanline_cam_cheap")
			SetTimecycleModifierStrength(2.0)

			-- CLOSE CAMERAS
			if IsControlJustPressed(0, Keys["BACKSPACE"]) then
				CloseSecurityCamera()
				TriggerEvent('esx_securitycam:freeze', false)
			end

			-- GO BACK CAMERA
			if IsControlJustPressed(0, Keys["LEFT"]) then
				local newCamIndex

				if currentCameraIndexIndex == 1 then
					newCamIndex = #cameralar[cameraIsim]
				else
					newCamIndex = currentCameraIndexIndex - 1
				end

				local newCamx = cameralar[cameraIsim][newCamIndex].x
				local newCamy = cameralar[cameraIsim][newCamIndex].y
				local newCamz = cameralar[cameraIsim][newCamIndex].z
				local newCamr = cameralar[cameraIsim][newCamIndex].r

				SetFocusArea(newCamx, newCamy, newCamz, newCamx, newCamy, newCamz)

				ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
				currentCameraIndexIndex = newCamIndex
			end

			-- GO FORWARD CAMERA
			if IsControlJustPressed(0, Keys["RIGHT"]) then
				local newCamIndex
			
				if currentCameraIndexIndex == #cameralar[cameraIsim] then
					newCamIndex = 1
				else
					newCamIndex = currentCameraIndexIndex + 1
				end

				local newCamx = cameralar[cameraIsim][newCamIndex].x
				local newCamy = cameralar[cameraIsim][newCamIndex].y
				local newCamz = cameralar[cameraIsim][newCamIndex].z
				local newCamr = cameralar[cameraIsim][newCamIndex].r

				ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
				currentCameraIndexIndex = newCamIndex
			end

			if cameralar[cameraIsim][currentCameraIndex].canRotate then
				local getCameraRot = GetCamRot(createdCamera, 2)

				-- ROTATE LEFT
				if IsControlPressed(1, Keys['N4']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
				end

				-- ROTATE RIGHT
				if IsControlPressed(1, Keys['N6']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
				end

			elseif cameralar[cameraIsim][currentCameraIndex].canRotate then
				local getCameraRot = GetCamRot(createdCamera, 2)

				-- ROTATE LEFT
				if IsControlPressed(1, Keys['N4']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
				end

				-- ROTATE RIGHT
				if IsControlPressed(1, Keys['N6']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
				end
			end

		end
		Citizen.Wait(time)
	end
end)

function ChangeSecurityCamera(x, y, z, r)
	if createdCamera ~= 0 then
		DestroyCam(createdCamera, 0)
		createdCamera = 0
	end

	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(cam, x, y, z)
	SetCamRot(cam, r.x, r.y, r.z, 2)
	RenderScriptCams(1, 0, 0, 1, 1)

	createdCamera = cam
end

function CloseSecurityCamera()
	blockbuttons = false
	DestroyCam(createdCamera, 0)
	RenderScriptCams(0, 0, 1, 1, 1)
	createdCamera = 0
	ClearTimecycleModifier("scanline_cam_cheap")
	SetFocusEntity(GetPlayerPed(PlayerId()))
	Citizen.Wait(50)
	cameraMenu()
end

function CreateInstuctionScaleform(scaleform)
	local scaleform = RequestScaleformMovie(scaleform)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(10)
	end

	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, Keys["RIGHT"], true))
	InstructionButtonMessage("next camera")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(1)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, Keys["LEFT"], true))
	InstructionButtonMessage("previous camera")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(2)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, Keys["BACKSPACE"], true))
	InstructionButtonMessage("Exit")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(80)
	PopScaleformMovieFunctionVoid()

	return scaleform
end

function InstructionButtonMessage(text)
	BeginTextCommandScaleformString("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandScaleformString()
end

RegisterNetEvent('esx_securitycam:freeze')
AddEventHandler('esx_securitycam:freeze', function(freeze)
	FreezeEntityPosition(PlayerPedId(), freeze)
end)

Citizen.CreateThread(function()
	while true do
		local time = 1000
		if blockbuttons then
			time = 1
			DisableControlAction(2, 24, true)
			DisableControlAction(2, 257, true)
			DisableControlAction(2, 25, true)
			DisableControlAction(2, 263, true)
			DisableControlAction(2, Keys['R'], true)
			DisableControlAction(2, Keys['SPACE'], true)
			DisableControlAction(2, Keys['Q'], true)
			DisableControlAction(2, Keys['TAB'], true)
			DisableControlAction(2, Keys['F'], true)
			DisableControlAction(2, Keys['F1'], true)
			DisableControlAction(2, Keys['F2'], true)
			DisableControlAction(2, Keys['F3'], true)
			DisableControlAction(2, Keys['F6'], true)
			DisableControlAction(2, Keys['F7'], true)
			DisableControlAction(2, Keys['F10'], true)
		end
		Citizen.Wait(time)
	end
end)

function DrawText3Dcamera(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 330
	DrawRect(_x, _y + 0.0150, 0.0 + factor, 0.035, 41, 11, 41, 100)
end

function DrawText3Ds(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.44, 0.44)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 80)
	end

function vehicleType(using)
	local cars = Config.Cars
	for i=1, #cars, 1 do
		if IsVehicleModel(using, GetHashKey(cars[i])) then
		return true
		end
	end
end

cameralar = {
	["Bank"] = {
		{x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.0}, canRotate = true},
		{x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.0}, canRotate = true},
		{x = 261.50, y = 218.08, z = 107.95, r = {x = -25.0, y = 0.0, z = -149.0}, canRotate = true},
		{x = 241.64, y = 233.83, z = 111.48, r = {x = -25.0, y = 0.0, z = 120.0}, canRotate = true},
		{x = 269.66, y = 223.67, z = 113.23, r = {x = -25.0, y = 0.0, z = 111.0}, canRotate = true},
		{x = 261.98, y = 217.92, z = 113.25, r = {x = -25.0, y = 0.0, z = -159.0}, canRotate = true},
		{ x = 258.44, y = 204.97, z = 113.25, r = {x = -25.0, y = 0.0, z = 10.0}, canRotate = true},
		{x = 235.53, y = 227.37, z = 113.23, r = {x = -25.0, y = 0.0, z = -160.0}, canRotate = true},
		{x = 254.72, y = 206.06, z = 113.28, r = {x = -25.0, y = 0.0, z = 44.0}, canRotate = true},
		{x = 269.89, y = 223.76, z = 106.48, r = {x = -25.0, y = 0.0, z = 112.0}, canRotate = true},
		{x = 252.27, y = 225.52, z = 103.99, r = {x = -25.0, y = 0.0, z = -74.0}, canRotate = true}
	},

	["TownMotel"] = {
		{x = -107.99, y = 6463.06, z = 33.35, r = {x = -25.0, y = 0.0, z = 6.0}, canRotate = true},
		{x = -103.14, y = 6467.86, z = 33.35, r = {x = -25.0, y = 0.0, z = 46.0}, canRotate = true},
		{x = -115.21, y = 6472.39, z = 33.35, r = {x = -25.0, y = 0.0, z = 206.0}, canRotate = true},
		{x = -112.64, y = 6464.64, z = 33.35, r = {x = -25.0, y = 0.0, z = 355.0}, canRotate = true},
		{x = -108.0, y = 6468.52, z = 33.35, r = {x = -25.0, y = 0.0, z = 259.0}, canRotate = true},
		{x = -107.19, y = 6476.16, z = 33.35, r = {x = -25.0, y = 0.0, z = 203.0}, canRotate = true},
		{x = -104.53, y = 6479.56, z = 33.35, r = {x = -25.0, y = 0.0, z = 175.0}, canRotate = true},
		{x = -103.42, y = 6451.33, z = 34.5, r = {x = -25.0, y = 0.0, z = 127.0}, canRotate = true},
	},

	["Police"] = {
		{x = 416.744, y = -1009.270, z = 34.08, r = {x = -25.0, y = 0.0, z = 28.0}, canRotate = true},
		{x = 465.151, y = -994.266, z = 26.80, r = {x = -25.0, y = 0.0, z = 100.0}, canRotate = true},
		{x = 465.631, y = -997.777, z = 26.80, r = {x = -25.0, y = 0.0, z = 90.0}, canRotate = true},
		{x = 465.544, y = -1001.583, z = 26.80, r = {x = -25.0, y = 0.0, z = 90.0}, canRotate = true},
		{x = 420.241, y = -1009.010, z = 34.95, r = {x = -25.0, y = 0.0, z = 230.0}, canRotate = true},
		{x = 433.249, y = -977.786, z = 33.456, r = {x = -25.0, y = 0.0, z = 100.0}, canRotate = true},
		{x = 449.440, y = -987.639, z = 33.0, r = {x = -25.0, y = 0.0, z = 50.0}, canRotate = true}
	},


	["Pillbox"] = {
		{x = 301.17, y = -581.32, z = 45.30, r = {x = -25.0, y = 0.0, z = 204.0}, canRotate = true},
		{x = 312.19, y = -597.73, z = 45.30, r = {x = -25.0, y = 0.0, z = 42.0}, canRotate = true},
		{ x = 328.08, y = -591.11, z = 45.30, r = {x = -25.0, y = 0.0, z = 131.0}, canRotate = true},
		{x = 324.22, y = -602.02, z = 45.30, r = {x = -25.0, y = 0.0, z = 43.0}, canRotate = true},
		{x = 324.97, y = -602.8, z = 45.30, r = {x = -25.0, y = 0.0, z = 310.0}, canRotate = true},
		{x = 306.11, y = -569.67, z = 45.30, r = {x = -25.0, y = 0.0, z = 207.0}, canRotate = true},
		{x = 315.23, y = -578.76, z = 45.30, r = {x = -25.0, y = 0.0, z = 132.0}, canRotate = true},
		{x = 333.81, y = -569.22, z = 45.30, r = {x = -25.0, y = 0.0, z = 132.0}, canRotate = true},
		{x = 348.78, y = -585.19, z = 45.30, r = {x = -25.0, y = 0.0, z = 78.0}, canRotate = true},
		{x = 337.26, y = -586.45, z = 45.30, r = {x = -25.0, y = 0.0, z = 205.0}, canRotate = true},
		{x = 355.02, y = -573.98, z = 45.30, r = {x = -25.0, y = 0.0, z = 190.0}, canRotate = true},
	},

	["Vangelico"] = {
		{x = -627.34, y = -239.85, z = 39.85, r = {x = -25.0, y = 0.0, z = 345.0}, canRotate = true},
		{x = -620.25, y = -224.22, z = 39.85, r = {x = -25.0, y = 0.0, z = 153.0}, canRotate = true},
		{x = -622.46, y = -235.5, z = 39.85, r = {x = -25.0, y = 0.0, z = 343.0}, canRotate = true},
		{x = -627.78, y = -230.01, z = 39.85, r = {x = -25.0, y = 0.0, z = 160.0}, canRotate = true}
	},

	["Motel"] = {
		{x = 326.79, y = -194.97, z = 57.0, r = {x = -25.0, y = 0.0, z = 230.0}, canRotate = true},
		{x = 306.36, y = -216.39, z = 60.02, r = {x = -25.0, y = 0.0, z = 299.0}, canRotate = true},
		{x = 347.02, y = -199.04, z = 60.02, r = {x = -25.0, y = 0.0, z = 107.0}, canRotate = true},
		{x = 339.31, y = -240.46, z = 61.05, r = {x = -25.0, y = 0.0, z = 83.0}, canRotate = true},
	},

	["1"] = {
		{x = 373.27, y = 331.44, z = 105.57, r = {x = -25.0, y = 0.0, z = 208.0}, canRotate = true},
		{x = 380.63, y = 330.38, z = 105.57, r = {x = -25.0, y = 0.0, z = 55.0}, canRotate = true},
	},

	["2"] = {
		{x = 2552.09, y = 380.34, z = 110.62, r = {x = -25.0, y = 0.0, z = 322.0}, canRotate = true},
		{x = 2551.68, y = 388.01, z = 110.62, r = {x = -25.0, y = 0.0, z = 147.0}, canRotate = true},
	},

	["3"] = {
		{x = -3043.24, y = 582.42, z = 9.91, r = {x = -25.0, y = 0.0, z = 344.0}, canRotate = true},
		{x = -3046.66, y = 589.29, z = 9.91, r = {x = -25.0, y = 0.0, z = 168.0}, canRotate = true},
	},

	["4"] = {
		{x = -1483.5, y = -380.12, z = 42.6, r = {x = -25.0, y = 0.0, z = 85.0}, canRotate = true},
		{x = -1479.84, y = -372.09, z = 42.16, r = {x = -25.0, y = 0.0, z = 168.0}, canRotate = true},
	},

	["5"] = {
		{x = 1387.83, y = 3604.63, z = 36.98, r = {x = -25.0, y = 0.0, z = 265.0}, canRotate = true},
		{x = 1398.25, y = 3610.38, z = 36.98, r = {x = -25.0, y = 0.0, z = 50.0}, canRotate = true},
	},

	["6"] = {
		{x = -2965.79, y = 387.31, z = 17.04, r = {x = -25.0, y = 0.0, z = 46.0}, canRotate = true},
		{x = -2957.82, y = 389.9, z = 16.04, r = {x = -25.0, y = 0.0, z = 139.0}, canRotate = true},
	},

	["7"] = {
		{x = 2673.41, y = 3281.22, z = 57.24, r = {x = -25.0, y = 0.0, z = 303.0}, canRotate = true},
		{x = 2676.25, y = 3288.3, z = 57.24, r = {x = -25.0, y = 0.0, z = 109.0}, canRotate = true},
	},

	["8"] = {
		{x = -42.85, y = -1755.13, z = 31.44, r = {x = -25.0, y = 0.0, z = 100.0}, canRotate = true},
		{x = -41.37, y = -1749.37, z = 31.42, r = {x = -25.0, y = 0.0, z = 103.0}, canRotate = true},
	},

	["9"] = {
		{x = 1164.64, y = -318.63, z = 71.21, r = {x = -25.0, y = 0.0, z = 150.0}, canRotate = true},
		{x = 1161.57, y = -312.94, z = 71.21, r = {x = -25.0, y = 0.0, z = 176.0}, canRotate = true},
	},

	["10"] = {
		{x = -705.5, y = -909.72, z = 21.22, r = {x = -25.0, y = 0.0, z = 150.0}, canRotate = true},
		{x = -707.46, y = -903.42, z = 21.22, r = {x = -25.0, y = 0.0, z = 154.0}, canRotate = true},
	},

	["11"] = {
		{x = -1822.4, y = 797.64, z = 140.09, r = {x = -25.0, y = 0.0, z = 195.0}, canRotate = true},
		{x = -1827.99, y = 800.84, z = 138.15, r = {x = -25.0, y = 0.0, z = 195.0}, canRotate = true},
	},

	["12"] = {
		{x = 1701.11, y = 4920.02, z = 44.06, r = {x = -25.0, y = 0.0, z = 20.0}, canRotate = true},
		{x = 1707.21, y = 4918.19, z = 44.06, r = {x = -25.0, y = 0.0, z = 20.0}, canRotate = true},
	},

	["13"] = {
		{x = 1956.98, y = 3744.05, z = 34.34, r = {x = -25.0, y = 0.0, z = 262.0}, canRotate = true},
		{x = 1963.16, y = 3748.54, z = 34.34, r = {x = -25.0, y = 0.0, z = 80.0}, canRotate = true},
	},

	["14"] = {
		{x = 1132.96, y = -979.16, z = 48.42, r = {x = -25.0, y = 0.0, z = 224.0}, canRotate = true},
		{x = 1125.22, y = -983.36, z = 48.0, r = {x = -25.0, y = 0.0, z = 312.0}, canRotate = true},
	},

	["15"] = {
		{x = 23.64, y = -1342.25, z = 31.5, r = {x = -25.0, y = 0.0, z = 236.0}, canRotate = true},
		{x = 31.41, y = -1341.48, z = 31.5, r = {x = -25.0, y = 0.0, z = 48.0}, canRotate = true},
	},

	["16"] = {
		{x = 550.48, y = 2666.68, z = 44.16, r = {x = -25.0, y = 0.0, z = 67.0}, canRotate = true},
		{x = 542.92, y = 2664.67, z = 44.16, r = {x = -25.0, y = 0.0, z = 243.0}, canRotate = true},
	},

	["17"] = {
		{x = -3247.53, y = 1000.08, z = 14.83, r = {x = -25.0, y = 0.0, z = 305.0}, canRotate = true},
		{x = -3247.55, y = 1007.36, z = 14.83, r = {x = -25.0, y = 0.0, z = 138.0}, canRotate = true},
	},

	["18"] = {
		{x = 1169.3, y = 2711.34, z = 40.16, r = {x = -25.0, y = 0.0, z = 120.0}, canRotate = true},
		{x = 1166.57, y = 2719.52, z = 40.16, r = {x = -25.0, y = 0.0, z = 230.0}, canRotate = true},
	},

	["19"] = {
		{x = 1729.41, y = 6419.83, z = 37.04, r = {x = -25.0, y = 0.0, z = 213.0}, canRotate = true},
		{x = 1736.66, y = 6417.44, z = 37.04, r = {x = -25.0, y = 0.0, z = 19.0}, canRotate = true},
	},	
}
