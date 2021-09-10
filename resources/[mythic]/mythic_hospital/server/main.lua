local beds = {
    { x = 314.45, y = -584.08, z = 44.2, h = 157.93, taken = false, model = 1631638868 },
    { x = 311.16, y = -582.71, z = 44.2, h = 154.61, taken = false, model = 1631638868 }, 
    { x = 307.73, y = -581.57, z = 44.2, h = 157.99, taken = false, model = 1631638868 }, 
    { x = 317.72, y = -585.19, z = 44.2, h = 158.94, taken = false, model = 1631638868 }, 
    { x = 322.73, y = -586.92, z = 44.2, h = 155.91, taken = false, model = 1631638868 }, 
    { x = 324.18, y = -583.09, z = 44.2, h = 337.72, taken = false, model = 1631638868 }, 
    { x = 319.35, y = -581.26, z = 44.2, h = 335.39, taken = false, model = 1631638868 }, 
    { x = 313.88, y = -579.22, z = 44.2, h = 338.46, taken = false, model = 1631638868 },
    { x = 319.35, y = -581.26, z = 44.2, h = 335.39, taken = false, model = 1631638868 },
}

local bedsTaken = {}
local injuryBasePrice = 10

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('mythic_hospital:server:RequestBed')
AddEventHandler('mythic_hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('mythic_hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No Beds Available' })
end)

RegisterServerEvent('mythic_hospital:server:RPRequestBed')
AddEventHandler('mythic_hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('mythic_hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerEvent('mythic_chat:server:System', source, 'That Bed Is Taken')
            end
        end
    end

    if not foundbed then
        TriggerEvent('mythic_chat:server:System', source, 'Not Near A Hospital Bed')
    end
end)

RegisterServerEvent('mythic_hospital:server:EnteredBed')
AddEventHandler('mythic_hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end

	-- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
	local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeBank(totalBill)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You were Billed 20$ for Medical Services & Expenses', length = 2500, style = { ['background-color'] = '#eb4034', ['color'] = '#ffffff' } })
	TriggerClientEvent('mythic_hospital:client:FinishServices', src)
end)

RegisterServerEvent('mythic_hospital:server:LeaveBed')
AddEventHandler('mythic_hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)