slyyCore.modules.zones = {}

RegisterNetEvent("zones:interact")
AddEventHandler("zones:interact", function(zoneId)
    if (slyyCore.modules.zones.list[zoneId] == nil) then return end 
    slyyCore.modules.zones.list[zoneId].onInteract(source)
end)