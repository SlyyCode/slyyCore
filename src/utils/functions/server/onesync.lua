local function getNearbyPlayers(source, closest, distance, ignore)
    local result = {}
    local count = 0
    local playerPed
    local playerCoords

    if not distance then
        distance = 100
    end

    if type(source) == "number" then
        playerPed = GetPlayerPed(source)

        if not source then
            error("Received invalid first argument (source); should be playerId")
            return result
        end

        playerCoords = GetEntityCoords(playerPed)

        if not playerCoords then
            error("Received nil value (playerCoords); perhaps source is nil at first place?")
            return result
        end
    end

    if type(source) == "vector3" then
        playerCoords = source

        if not playerCoords then
            error("Received nil value (playerCoords); perhaps source is nil at first place?")
            return result
        end
    end

    for _, v in pairs(slyyCore.modules.players.list) do
        if not ignore or not ignore[v.source] then
            local entity = GetPlayerPed(v.source)
            local coords = GetEntityCoords(entity)

            if not closest then
                local dist = #(playerCoords - coords)
                if dist <= distance then
                    count = count + 1
                    result[count] = { id = v.source, ped = NetworkGetNetworkIdFromEntity(entity), coords = coords, dist = dist }
                end
            else
                if v.source ~= source then
                    local dist = #(playerCoords - coords)
                    if dist <= (result.dist or distance) then
                        result = { id = v.source, ped = NetworkGetNetworkIdFromEntity(entity), coords = coords, dist = dist }
                    end
                end
            end
        end
    end

    return result
end

local function getNearbyEntities(entities, coords, modelFilter, maxDistance, isPed)
    local nearbyEntities = {}
    coords = type(coords) == "number" and GetEntityCoords(GetPlayerPed(coords)) or vector3(coords.x, coords.y, coords.z)
    for _, entity in pairs(entities) do
        if not isPed or (isPed and not IsPedAPlayer(entity)) then
            if not modelFilter or modelFilter[GetEntityModel(entity)] then
                local entityCoords = GetEntityCoords(entity)
                if not maxDistance or #(coords - entityCoords) <= maxDistance then
                    nearbyEntities[#nearbyEntities + 1] = NetworkGetNetworkIdFromEntity(entity)
                end
            end
        end
    end

    return nearbyEntities
end

local function getClosestEntity(entities, coords, modelFilter, isPed)
    local distance, closestEntity, closestCoords = 100, nil, nil
    coords = type(coords) == "number" and GetEntityCoords(GetPlayerPed(coords)) or vector3(coords.x, coords.y, coords.z)

    for _, entity in pairs(entities) do
        if not isPed or (isPed and not IsPedAPlayer(entity)) then
            if not modelFilter or modelFilter[GetEntityModel(entity)] then
                local entityCoords = GetEntityCoords(entity)
                local dist = #(coords - entityCoords)
                if dist < distance then
                    closestEntity, distance, closestCoords = entity, dist, entityCoords
                end
            end
        end
    end
    return NetworkGetNetworkIdFromEntity(closestEntity), distance, closestCoords
end

slyyCore.utils.getPlayersInArea = function(source, maxDistance, ignore)
    return getNearbyPlayers(source, false, maxDistance, ignore)
end

slyyCore.utils.getClosestPlayer = function(source, maxDistance, ignore)
    return getNearbyPlayers(source, true, maxDistance, ignore)
end

slyyCore.utils.getPedsInArea = function(coords, maxDistance, modelFilter)
    return getNearbyEntities(GetAllPeds(), coords, modelFilter, maxDistance, true)
end

slyyCore.utils.getObjectsInArea = function(coords, maxDistance, modelFilter)
    return getNearbyEntities(GetAllObjects(), coords, modelFilter, maxDistance)
end

slyyCore.utils.getVehiclesInArea = function(coords, maxDistance, modelFilter)
    return getNearbyEntities(GetAllVehicles(), coords, modelFilter, maxDistance)
end

slyyCore.utils.getClosestPed = function(coords, modelFilter)
    return getClosestEntity(GetAllPeds(), coords, modelFilter, true)
end

slyyCore.utils.getClosestObject = function(coords, modelFilter)
    return getClosestEntity(GetAllObjects(), coords, modelFilter)
end

slyyCore.utils.getClosestVehicle = function(coords, modelFilter)
    return getClosestEntity(GetAllVehicles(), coords, modelFilter)
end