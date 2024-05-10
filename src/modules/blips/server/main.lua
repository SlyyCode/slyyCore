slyyCore.modules.blip = {}

slyyCore.modules.blip.createPublic = function(title, position, blip)
    local blip = slyyCore.modules.blip.new(title, position, blip.sprite, blip.color, blip.shortRange, blip.scale, true)
    slyyCore.events:all("blip:new", blip)
    slyyCore.console:debug(("Created new public blip (blipId:%s)"):format(blip.id))
    return blip.id
end

slyyCore.modules.blip.createPrivate = function(title, position, blip, baseAuthorized)
    local blip = slyyCore.modules.blip.new(title, position, blip.sprite, blip.color, blip.shortRange, blip.scale, false, baseAuthorized)
    for k,v in pairs(slyyCore.modules.players.list) do 
        if blip.isAuthorized(v.source) then
            slyyCore.events:client("blip:new", v.source, blip)
        end
    end
    slyyCore.console:debug(("Created new private blip (blipId:%s)"):format(blip.id))
    return blip.id
end

RegisterCommand("blip", function()
    slyyCore.modules.blip.createPublic("Mon blip", vector3(169.11, -875.15, 30.45), {
        sprite = 137,
        color = 47,
        shortRange = true
    })
end, false)

RegisterCommand("blip2", function()
    slyyCore.modules.blip.createPrivate("Mon blip", vector3(169.11, -875.15, 30.45), {
        sprite = 137,
        color = 47,
        shortRange = true
    })
end, false)

RegisterCommand("blip3", function()
    slyyCore.modules.blip.createPrivate("Mon blip", vector3(169.11, -875.15, 30.45), {
        sprite = 137,
        color = 47,
        shortRange = true
    }, {1})
end, false)