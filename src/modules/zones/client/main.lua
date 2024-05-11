slyyCore.modules.zones = {}
slyyCore.modules.zones.list = {}
slyyCore.modules.zones.inCooldown = false

slyyCore.events:new("zones:receiveZones", function(list)
    slyyCore.modules.zones.list = list
end)

slyyCore.events:new("zones:new", function(zone)
    slyyCore.modules.zones.list[zone.id] = zone
end)

slyyCore.events:new("zones:remove", function(zoneId)
    slyyCore.modules.zones.list[zoneId] = nil
end)

CreateThread(function()
    while true do 
        local interval = 500
        local pPed = PlayerPedId()
        local pCoords = GetEntityCoords(pPed)

        for k,v in pairs(slyyCore.modules.zones.list) do 
            local distToMarker = #(pCoords - v.position)
            if distToMarker < v.marker.draw then 
                DrawMarker(2, v.position, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.marker.size[1], v.marker.size[2], v.marker.size[3], v.marker.color[1], v.marker.color[2], v.marker.color[3], v.marker.color[4], v.marker.bobUpAndDown, v.marker.faceCamera, 2, v.marker.rotate, nil, nil, false)
                if distToMarker < v.marker.interact then 
                    slyyCore.utils.helpNotification(v.helpText, true)
                    if IsControlJustPressed(0, 51) then 
                        if not slyyCore.modules.zones.inCooldown then
                            slyyCore.modules.zones.inCooldown = true
                            slyyCore.events:server("zones:interact", k)
                            SetTimeout(1000, function()
                                slyyCore.modules.zones.inCooldown = false
                            end)
                        else 
                            slyyCore.utils.notification(_("DONT_SPAM_ZONE_KEY"))
                        end
                    end
                end
            end
        end
        Wait(0)
    end
end)