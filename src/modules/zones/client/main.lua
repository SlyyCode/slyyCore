slyyCore.zones = {}
slyyCore.zones.list = {}
slyyCore.zones.inCooldown = false

RegisterNetEvent("zones:new")
AddEventHandler("zones:new", function(zone)
    slyyCore.zones.list[zone.id] = zone
    print("Received new zone.")
end)

CreateThread(function()
    while true do 
        local interval = 500
        local pPed = PlayerPedId()
        local pCoords = GetEntityCoords(pPed)

        for k,v in pairs(slyyCore.zones.list) do 
            local distToMarker = #(pCoords - v.position)
            if distToMarker < v.marker.draw then 
                DrawMarker(2, v.position, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.marker.size[1], v.marker.size[2], v.marker.size[3], v.marker.color[1], v.marker.color[2], v.marker.color[3], v.marker.color[4], v.marker.bobUpAndDown, v.marker.faceCamera, 2, v.marker.rotate, nil, nil, false)
                if distToMarker < v.marker.interact then 
                    if IsControlJustPressed(0, 51) then 
                        if not slyyCore.zones.inCooldown then
                            slyyCore.zones.inCooldown = true
                            TriggerServerEvent("zones:interact", k)
                            SetTimeout(1000, function()
                                slyyCore.zones.inCooldown = false
                            end)
                        else 
                            print("attends un peu")
                        end
                    end
                end
            end
        end
        Wait(0)
    end
end)