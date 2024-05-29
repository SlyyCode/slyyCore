slyyCore.modules.zones = {}

slyyCore.modules.zones.createPublic = function(position, marker, helpText, dist, onInteract)
    local zone = slyyCore.modules.zones.new(position, marker, helpText, dist, onInteract, true)
    slyyCore.events:all("zones:new", zone)
    slyyCore.console:debug(("Created new public zone (zoneId:%s)"):format(zone.id))
    return zone.id
end

slyyCore.modules.zones.createPrivate = function(position, marker, helpText, dist, onInteract, baseAuthorized, authorization, boss)
    local zone = slyyCore.modules.zones.new(position, marker, helpText, dist, onInteract, false, baseAuthorized, authorization, boss)
    for k,v in pairs(slyyCore.modules.players.list) do 
        if zone.authorization ~= nil and (v.job.name == zone.authorization) then 
            zone.addAuthorized(v.source)
        end
        if zone.isAuthorized(v.source) then
            slyyCore.events:client("zones:new", v.source, zone)
        end
    end
    slyyCore.console:debug(("Created new private zone (zoneId:%s)"):format(zone.id))
    return zone.id
end

slyyCore.modules.zones.getMyZones = function(source)
    local zones = {}

    for k,v in pairs(slyyCore.modules.zones.list) do 
        if v.public then 
            table.insert(zones, v)
        else
            if v.isAuthorized(source) then 
                table.insert(zones, v)
            end
        end
    end
    return zones
end

slyyCore.modules.zones.doesZoneExist = function(zoneId)
    return slyyCore.modules.zones.list[zoneId] ~= nil
end

slyyCore.modules.zones.deleteZone = function(zoneId)
    local zone = slyyCore.modules.zones.list[zoneId]
    if zone == nil then 
        return 
    end
    if zone.public then 
        slyyCore.events:all("zones:remove", zoneId)
    else 
        for k,v in pairs(zone.authorized) do 
            slyyCore.events:client("zones:remove", v, zoneId)
        end
    end
    slyyCore.modules.zones.list[zoneId] = nil
end

slyyCore.events:new("zones:interact", function(zoneId)
    if (slyyCore.modules.zones.list[zoneId] == nil) then return end 
    slyyCore.modules.zones.list[zoneId].onInteract(source)
end)

slyyCore.events:basic("zones:interact", function(zoneId)
    if (slyyCore.modules.zones.list[zoneId] == nil) then return end 
    slyyCore.modules.zones.list[zoneId].onInteract(source)
end)