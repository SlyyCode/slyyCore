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
            print("Erreur lors de l'envoi du log: " .. err)
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

RegisterCommand("log", function()
    slyyCore.utils.log("main", {
        username = "Jsuis un test",
        title = "Test",
        description = "Description tets",
        thumbnail_url = Config.ServerIcon,
        color = {0, 255, 0}
    })
end, false)