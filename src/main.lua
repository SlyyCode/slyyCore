slyyCore = {}
slyyCore.locale = {}

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
    end)
else 
    Wait(50) -- Wait all file load
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
end

function _U(localName, ...)
    if (slyyCore.locale[localName] == nil) then 
        slyyCore.console:error(("The local %s does not exist."):format(localName))
        return ("The local %s does not exist."):format(localName)
    end
    return (slyyCore.locale[localName]):format(...)
end