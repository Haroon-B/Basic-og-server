local ESX = nil

local cachedData = {}

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

ESX.RegisterServerCallback("bankrobberies:getCurrentRobbery", function(source, callback)
	callback(cachedData)
end)

ESX.RegisterServerCallback("bankrobberies:fetchCops", function(source, callback)
	local players = ESX.GetPlayers()

	local policeMen = 0

	for index, player in ipairs(players) do
		local player = ESX.GetPlayerFromId(player)

		if player then
			if player["job"]["name"] == "police" then
				policeMen = policeMen + 1
			end
		end
	end

	callback(policeMen >= Config.CopsNeeded)
end)

RegisterServerEvent("bankrobberies:globalEvent")
AddEventHandler("bankrobberies:globalEvent", function(options)
	if type(options["data"]) == "table" then
		if options["data"]["save"] then
			cachedData[options["data"]["bank"]] = {
				["started"] = os.time(),
				["robber"] = source,
				["trolleys"] = options["data"]["trolleys"]
			}
		end
	end

    TriggerClientEvent("bankrobberies:eventHandler", -1, options["event"] or "none", options["data"] or nil)
end)

RegisterServerEvent("bankrobberies:receiveCash")
AddEventHandler("bankrobberies:receiveCash", function()
	local player = ESX.GetPlayerFromId(source)

	if player then
		local randomMoney = math.random(Config.Trolley["cash"][1], Config.Trolley["cash"][2])
		if Config.BlackMoney then
		player.addAccountMoney('black_money', randomMoney)
		TriggerClientEvent("esx:showNotification", source, "You received~r~~n~" .. randomMoney .. "~s~$ ~r~dirty money")
		else
		player.addMoney(randomMoney)
		TriggerClientEvent("esx:showNotification", source, "You received~g~ " .. randomMoney .. "~s~$")
		end
		
	end
end)


RegisterServerEvent('ir_force:bazsho')
AddEventHandler('ir_force:bazsho', function(x,y,z, doortype)

	TriggerClientEvent('ir_force:bazshodan', -1, x,y,z, doortype)
end)

RegisterServerEvent('ir_force:kashtan')
AddEventHandler('ir_force:kashtan', function(thermiteID,doorID)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("thermite",1)
    TriggerClientEvent('ir_force:terkidan', -1, thermiteID,doorID)
end)


ESX.RegisterUsableItem('thermite', function(source)
   TriggerClientEvent('ir_force:estefade_az_item', source)
end)
