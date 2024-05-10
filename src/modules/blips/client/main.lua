slyyCore.modules.blip = {}
slyyCore.modules.blip.list = {}

local function newBlip(title, position, sprite, color, shortRange, scale)
    local blip = AddBlipForCoord(position)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, shortRange)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(title)
    EndTextCommandSetBlipName(blip)
    return blip
end

slyyCore.events:new("blip:receiveBlip", function(list)
    slyyCore.modules.blip.list = list
    for k,v in pairs(slyyCore.modules.blip.list) do
        slyyCore.modules.blip.list[v.id].blip = newBlip(v.title, v.position, v.sprite, v.color, v.shortRange, v.scale)
    end
end)

slyyCore.events:new("blip:new", function(blip)
    slyyCore.modules.blip.list[blip.id] = blip
    slyyCore.modules.blip.list[blip.id].blip = newBlip(blip.title, blip.position, blip.sprite, blip.color, blip.shortRange, blip.scale)
end)

slyyCore.events:new("blip:remove", function(blipId)
    if (slyyCore.modules.blip.list[blipId] == nil) then return end 
    while DoesBlipExist(slyyCore.modules.blip.list[blipId].blip) do 
        RemoveBlip(slyyCore.modules.blip.list[blipId].blip)
    end
    slyyCore.modules.blip.list[blipId] = nil
end)