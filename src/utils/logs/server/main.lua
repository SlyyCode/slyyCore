slyyCore.utils.log = function(webId, data)
    if not Webhook[webId] then 
        slyyCore.console:error(("The webId (%s) is not configured or does not exist."):format(webId))
        return
    end

    if not data.title then 
        slyyCore.console:error("A title is required to send a log.")
        return
    end

    if not data.description then 
        slyyCore.console:error("A description is required to send a log.")
        return
    end

    PerformHttpRequest(Webhook[webId], function(err, text, headers) 
        if not (err == 200 or err == 204) then
            slyyCore.console:error(("Error when sending a log, code: %s."):format(err))
        end
    end, "POST", json.encode({
        ["username"] = data.username or "Nouveau Log",
        ["avatar_url"] = data.avatar_url or Config.ServerIcon,
        ["embeds"] = {{
            ["title"] = data.title,
            ["description"] = data.description,
            ["color"] = data.color and slyyCore.utils.rgbToDecimal(table.unpack(data.color)) or 16711680,
            ["fields"] = data.fields or {},
            ["thumbnail"] = {
                ["url"] = data.thumbnail_url or ""
            },
            ["footer"] = {
                ["text"] = slyyCore.utils.getFormattedDateTime(),
                ["icon_url"] = Config.ServerIcon
            }
        }}
    }), {["Content-Type"] = "application/json"})
end

local function getPlayerInfo(playerId, isTarget)
    local identifiers = slyyCore.utils.getIdentifiers(playerId) 
    local info = _("LOG_UTILS_TITLE_PLAYER_INFO", isTarget and _("LOG_UTILS_TITLE_PLAYER_PLAYER") or _("LOG_UTILS_TITLE_PLAYER_SOURCE"), _("LOG_UTILS_PSEUDO"), GetPlayerName(playerId), _("LOG_UTILS_ID"), playerId)

    for identifier, value in pairs(identifiers) do 
        if Config.ShowInLog[identifier] then
            if identifier == "discord" then 
                info = info..("→ **%s** : <@%s>\n"):format(slyyCore.utils.capitalizeFirstLetter(identifier), value)
            else
                info = info..("→ **%s** : %s\n"):format(slyyCore.utils.capitalizeFirstLetter(identifier), value)
            end
        end
    end

    return info
end

slyyCore.utils.playerLog = function(webId, data, source, target)
    data.description = getPlayerInfo(source).."\n"..(target ~= nil and getPlayerInfo(target, true).."\n" or "").._("LOG_UTILS_TITLE_ADDITIONAL_INFO")..data.description
    slyyCore.utils.log(webId, data)
end

-- RegisterCommand("log", function()
--     slyyCore.utils.log("main", {
--         username = "Jsuis un test",
--         title = "Test",
--         description = "Description tets",
--         thumbnail_url = Config.ServerIcon,
--         color = {0, 255, 0}
--     })
--     slyyCore.utils.playerLog("main", {
--         username = "Jsuis un test",
--         title = "Test",
--         description = "Description tets",
--         thumbnail_url = Config.ServerIcon,
--         color = {0, 255, 0}
--     }, 2, 2)
-- end, false)