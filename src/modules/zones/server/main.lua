slyyCore.modules.zones = {}

slyyCore.events:new("zones:interact", function(zoneId)
    if (slyyCore.modules.zones.list[zoneId] == nil) then return end 
    slyyCore.modules.zones.list[zoneId].onInteract(source)
end)