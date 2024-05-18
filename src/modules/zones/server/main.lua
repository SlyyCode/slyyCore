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

-- RegisterCommand("test", function()
--     slyyCore.modules.zones.createPublic(vector3(169.11, -875.15, 30.45), {
--         id = 0,
--         color = {0, 0, 255, 255},
--         bobUpAndDown = true,
--         faceCamera = false,
--         rotate = true
--     }, "Appuyez ici pour intéragir", {draw = 10, interact = 2}, function(source)
--         print("test")
--     end)
-- end, false)

-- RegisterCommand("test2", function()
--     slyyCore.modules.zones.createPrivate(vector3(169.11, -875.15, 30.45), {
--         id = 0,
--         color = {0, 0, 255, 255},
--         bobUpAndDown = true,
--         faceCamera = false,
--         rotate = true
--     }, "Appuyez ici pour intéragir", {draw = 10, interact = 2}, function(source)
--         print("test")
--     end, {1}, "ambulance")
-- end, false)

slyyCore.events:new("zones:interact", function(zoneId)
    if (slyyCore.modules.zones.list[zoneId] == nil) then return end 
    slyyCore.modules.zones.list[zoneId].onInteract(source)
end)

slyyCore.events:basic("zones:interact", function(zoneId)
    if (slyyCore.modules.zones.list[zoneId] == nil) then return end 
    slyyCore.modules.zones.list[zoneId].onInteract(source)
end)

-- slyyCore.events:new("onPlayerJoinded", function()
--     slyyCore.events:client("zones:receiveZones", source, slyyCore.modules.zones.list)
-- end)