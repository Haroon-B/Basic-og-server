local pendingPing = nil
local isPending = false

function AddBlip(bData)
    pendingPing.blip = AddBlipForCoord(bData.x, bData.y, bData.z)
    SetBlipSprite(pendingPing.blip, bData.id)
    SetBlipAsShortRange(pendingPing.blip, true)
    SetBlipScale(pendingPing.blip, bData.scale)
    SetBlipColour(pendingPing.blip, bData.color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(bData.name)
    EndTextCommandSetBlipName(pendingPing.blip)

    pendingPing.count = 0
end

function TimeoutPingRequest()
    Citizen.CreateThread(function()
        local count = 0
        while isPending do
            count = count + 1
            if count >= 30 and isPending then
                exports['mythic_notify']:SendAlert('inform', 'Ping From ' .. pendingPing.name .. ' Timed Out')
                TriggerServerEvent('mythic_ping:server:SendPingResult', pendingPing.id, 'timeout')
                pendingPing = nil
                isPending = false
            end
            Citizen.Wait(1000)
        end
    end)
end

function TimeoutBlip()
    Citizen.CreateThread(function()
        while pendingPing ~= nil do
            if pendingPing.count ~= nil then
                if pendingPing.count >= 60 then
                    RemoveBlip(pendingPing.blip)
                    pendingPing = nil
                else
                    pendingPing.count = pendingPing.count + 1
                end
            end
            Citizen.Wait(1000)
        end
    end)
end

function RemoveBlipDistance()
    local player = PlayerPedId()
    Citizen.CreateThread(function()
        while pendingPing ~= nil do
            local plyCoords = GetEntityCoords(player)
            local dist = math.floor(#(vector2(pendingPing.pos.x, pendingPing.pos.y) - vector2(plyCoords.x, plyCoords.y)))

            if dist < 10 then
                RemoveBlip(pendingPing.blip)
                pendingPing = nil
            else
                Citizen.Wait(math.floor((dist - 10) * 30))
            end
        end
    end)
end

RegisterNetEvent('mythic_ping:client:SendPing')
AddEventHandler('mythic_ping:client:SendPing', function(sender, senderId)
    if pendingPing == nil then
        pendingPing = {}
        pendingPing.id = senderId
        pendingPing.name = sender
        pendingPing.pos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(pendingPing.id)), false) 

        TriggerServerEvent('mythic_ping:server:SendPingResult', pendingPing.id, 'received')
        exports['mythic_notify']:SendAlert('inform', pendingPing.name .. ' Sent You a Ping, Use /ping accept To Accept', (30 * 1000))
        isPending = true

        if 30 > 0 then
            TimeoutPingRequest()
        end

    else
        exports['mythic_notify']:SendAlert('inform', sender .. ' Attempted To Ping You')
        TriggerServerEvent('mythic_ping:server:SendPingResult', senderId, 'unable')
    end
end)

RegisterNetEvent('mythic_ping:client:AcceptPing')
AddEventHandler('mythic_ping:client:AcceptPing', function()
    if isPending then
        local playerBlip = { name = pendingPing.name, color = 4, id = 280, scale = 0.75, x = pendingPing.pos.x, y = pendingPing.pos.y, z = pendingPing.pos.z }
        AddBlip(playerBlip)

        --if true then
        SetNewWaypoint(pendingPing.pos.x, pendingPing.pos.y)
        --end

        if 30 > 0 then
            TimeoutBlip()
        end

        if 10 > 0 then
            RemoveBlipDistance()
        end

        exports['mythic_notify']:SendAlert('inform', pendingPing.name .. '\'s Location Showing On Map')
        TriggerServerEvent('mythic_ping:server:SendPingResult', pendingPing.id, 'accept')
        isPending = false
    else
        exports['mythic_notify']:SendAlert('inform', 'You Have No Pending Ping')
    end
end)

RegisterNetEvent('mythic_ping:client:RejectPing')
AddEventHandler('mythic_ping:client:RejectPing', function()
    if pendingPing ~= nil then
        exports['mythic_notify']:SendAlert('inform', 'Rejected Ping From ' .. pendingPing.name)
        TriggerServerEvent('mythic_ping:server:SendPingResult', pendingPing.id, 'reject')
        pendingPing = nil
        isPending = false
    else
        exports['mythic_notify']:SendAlert('inform', 'You Have No Pending Ping')
    end
end)

RegisterNetEvent('mythic_ping:client:RemovePing')
AddEventHandler('mythic_ping:client:RemovePing', function()
    if pendingPing ~= nil then
        RemoveBlip(pendingPing.blip)
        pendingPing = nil
        exports['mythic_notify']:SendAlert('inform', 'Player Ping Removed')
    else
        exports['mythic_notify']:SendAlert('inform', 'You Have No Player Ping')
    end
end)