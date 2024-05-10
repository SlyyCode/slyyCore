slyyCore.utils.getIdentifiers = function(source)
    local identifiers = {}

    for i=0, GetNumPlayerIdentifiers(source) - 1 do
        local id = GetPlayerIdentifier(source, i)

        if string.find(id, "steam:") then
            identifiers["steam"] = id
        elseif string.find(id, "ip:") then
            identifiers["ip"] = id
        elseif string.find(id, "discord:") then
            identifiers["discord"] = id
        elseif string.find(id, "license:") then
            identifiers["license"] = id
        elseif string.find(id, "license2:") then
            identifiers["license2"] = id
        elseif string.find(id, "xbl:") then
            identifiers["xbl"] = id
        elseif string.find(id, "live:") then
            identifiers["live"] = id
        elseif string.find(id, "fivem:") then
            identifiers["fivem"] = id
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