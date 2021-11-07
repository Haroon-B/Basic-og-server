--
--  LEAKED BY S3NTEX -- 
--  https://discord.gg/aUDWCvM -- 
--  fivemleak.com -- 
--  fkn crew -- 
ESX.RegisterServerCallback("gcPhone:getCars", function(a, b)
    local c = ESX.GetPlayerFromId(a)
    if not c then
        return
    end;
    MySQL.Async.fetchAll("SELECT plate, vehicle, stored FROM owned_vehicles WHERE owner = @cid and type = @type", {["@cid"] = c.identifier, ["@type"] = "car"}, function(d)
        local e = {} for f, g in ipairs(d) do
            table.insert(e, {["garage"] = g["stored"], ["plate"] = g["plate"], ["props"] = json.decode(g["vehicle"])})
        end;
        b(e)
    end)
end)

RegisterServerEvent('gcPhone:finish')
AddEventHandler('gcPhone:finish', function(plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Thanks for Using valet service ' , length = 2500, style = { ['background-color'] = '#2f5c73', ['color'] = '#FFFFFF' } })
	xPlayer.removeAccountMoney('bank', 1500)
end)

RegisterServerEvent("gcPhone:valet-car-set-outside")
AddEventHandler("gcPhone:valet-car-set-outside", function(a)
    local b = source;
    local c = ESX.GetPlayerFromId(b)
    if c then
        MySQL.Async.insert("UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate", {["@plate"] = a, ["@stored"] = 0})
    end
end)
