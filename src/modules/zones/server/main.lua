slyyCore.zones = {}

RegisterNetEvent("zones:interact")
AddEventHandler("zones:interact", function(zoneId)
    if (slyyCore.zones.list[zoneId] == nil) then return end 
    slyyCore.zones.list[zoneId].onInteract(source)
end)