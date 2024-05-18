slyyCore.utils.getIdentifiers = function(source)
    local identifiers = {}

    for i=0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)

        if string.find(id, "steam:") then
            identifiers["steam"] = string.sub(id, 7)
        elseif string.find(id, "ip:") then
            identifiers["ip"] = string.sub(id, 4)
        elseif string.find(id, "discord:") then
            identifiers["discord"] = string.sub(id, 9)
        elseif string.find(id, "license:") then
            identifiers["license"] = string.sub(id, 9)
        elseif string.find(id, "license2:") then
            identifiers["license2"] = string.sub(id, 10)
        elseif string.find(id, "xbl:") then
            identifiers["xbl"] = string.sub(id, 5)
        elseif string.find(id, "live:") then
            identifiers["live"] = string.sub(id, 6)
        elseif string.find(id, "fivem:") then
            identifiers["fivem"] = string.sub(id, 7)
        end
    end
    return identifiers
end

slyyCore.utils.getLicense = function(source)
    return slyyCore.utils.getIdentifiers(source)["license"]
end

slyyCore.utils.getDiscord = function(source)
    return slyyCore.utils.getIdentifiers(source)["discord"]
end

slyyCore.utils.getFiveM = function(source)
    return slyyCore.utils.getIdentifiers(source)["fivem"]
end