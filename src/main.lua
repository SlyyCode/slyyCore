slyyCore = {}
slyyCore.locale = {}

function _(localName, ...)
    if (slyyCore.locale[localName] == nil) then 
        slyyCore.console:error(("The local %s does not exist."):format(localName))
        return ("The local %s does not exist."):format(localName)
    end
    return (slyyCore.locale[localName]):format(...)
end

if not IsDuplicityVersion() then 
    CreateThread(function()
        while true do
            if NetworkIsPlayerActive(PlayerId()) then 
                DoScreenFadeOut(0)
                Wait(1000)
                DoScreenFadeIn(1500)
                slyyCore.events:server("onPlayerJoinded")
                break
            end
            Wait(100)
        end

        slyyCore.events:new("locales:receive", function(data)
            slyyCore.console:sucess("Received server locales.")
            slyyCore.locale = data
        end)
    end)
else 
    local startTime = os.clock()
    Wait(50) -- Wait for all files to load

    slyyCore.events:new("serverLoaded", function()
        local elapsedTime = os.clock() - startTime
        local elapsedTimeMs = elapsedTime * 1000 -- Convert seconds to milliseconds
        local elapsedTimeString = string.format("%.6f", elapsedTimeMs)
        slyyCore.console:sucess(("The server has been launched in %s ms."):format(elapsedTimeString))

        slyyCore.utils.log("main", {
            username = _("LOG_SERVER_LOADED_USERNAME"),
            title = _("LOG_SERVER_LOADED_TITLE"),
            description = _("LOG_SERVER_LOADED_DESC", elapsedTimeString),
            color = {0, 255, 0}
        })
    end)

    slyyCore.exitServer = function(sec)
        for i=sec, 1, -1 do
            slyyCore.console:error(("The server will stop automatically in %s sec."):format(i))
            Wait(1000)
            if i == 1 then 
                slyyCore.console:error("Server shutdown ...")
                Wait(1000)
            end
        end
        os.exit()
    end 

    local file_label = Config.Language..".json"
    local file = io.open(Config.LocalFile.."/languages/"..file_label, "r+")
    
    if (file == nil) then 
        slyyCore.console:error("Server loading error.")
        slyyCore.console:error(("The %s file cannot be found. Check that the language exists."):format(file_label))
        slyyCore.exitServer(5)
        return
    end

    slyyCore.locale = json.decode(file:read("*all"))
    file:close()
    slyyCore.console:sucess(("Local %s successfully loaded."):format(file_label))
    slyyCore.events:internal("serverLoaded")

    slyyCore.events:handler("onPlayerJoinded", function()
        slyyCore.events:client("locales:receive", source, slyyCore.locale)
    end)
end