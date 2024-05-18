local function GetVehicleEntityFromNetId(netId)
    while not NetworkDoesEntityExistWithNetworkId(netId) do
        Wait(200)
    end

    local vehicle = NetworkGetEntityFromNetworkId(netId)

    while vehicle == 0 or not DoesEntityExist(vehicle) do
        Wait(200)
    end

    return vehicle
end

slyyCore.events:new("vehicles:setProperties", function(netId, properties)
    local vehicle = GetVehicleEntityFromNetId(netId)
    slyyCore.utils.setVehicleProperties(vehicle, properties)
end)

slyyCore.events:new("vehicles:setColours", function(netId, colorPrimary, colorSecondary)
    local vehicle = GetVehicleEntityFromNetId(netId)
    SetVehicleColours(vehicle, colorPrimary, colorSecondary)
end)