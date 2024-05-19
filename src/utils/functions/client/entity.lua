slyyCore.utils.getClosestEntity = function(entities, isPlayerEntities, coords, modelFilter)
    local closestEntity, closestEntityDistance, filteredEntities = -1, -1, nil

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end

    if modelFilter then
        filteredEntities = {}

        for _, entity in pairs(entities) do
            if modelFilter[GetEntityModel(entity)] then
                filteredEntities[#filteredEntities + 1] = entity
            end
        end
    end

    for k, entity in pairs(filteredEntities or entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if closestEntityDistance == -1 or distance < closestEntityDistance then
            closestEntity, closestEntityDistance = isPlayerEntities and k or entity, distance
        end
    end

    return closestEntity, closestEntityDistance
end

slyyCore.utils.getPlayers = function(onlyOtherPlayers, returnKeyValue, returnPeds)
    local players, myPlayer = {}, PlayerId()
    local active = GetActivePlayers()

    for i = 1, #active do
        local currentPlayer = active[i]
        local ped = GetPlayerPed(currentPlayer)

        if DoesEntityExist(ped) and ((onlyOtherPlayers and currentPlayer ~= myPlayer) or not onlyOtherPlayers) then
            if returnKeyValue then
                players[currentPlayer] = ped
            else
                players[#players + 1] = returnPeds and ped or currentPlayer
            end
        end
    end

    return players
end

slyyCore.utils.getVehicles = function()
    return GetGamePool("CVehicle")
end

slyyCore.utils.getObjects = function() -- Leave the function for compatibility
    return GetGamePool("CObject")
end

slyyCore.utils.getPeds = function(onlyOtherPeds)
    local pool = GetGamePool("CPed")

    if onlyOtherPeds then
        local myPed = PlayerPedId()
        for i = 1, #pool do
            if pool[i] == myPed then
                table.remove(pool, i)
                break
            end
        end
    end

    return pool
end

slyyCore.utils.getClosestPlayer = function(coords)
    return slyyCore.utils.getClosestEntity(slyyCore.utils.getPlayers(true, true), true, coords, nil)
end

slyyCore.utils.getClosestVehicle = function(coords, modelFilter)
    return slyyCore.utils.getClosestEntity(slyyCore.utils.getVehicles(), false, coords, modelFilter)
end

slyyCore.utils.getClosestObject = function(coords, modelFilter)
    return slyyCore.utils.getClosestEntity(slyyCore.utils.getObjects(), false, coords, modelFilter)
end

slyyCore.utils.getClosestPed = function(coords, modelFilter)
    return slyyCore.utils.getClosestEntity(slyyCore.utils.getPeds(true), false, coords, modelFilter)
end
