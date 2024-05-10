--@SlyyCode: ajouter une possibilité de config des notification en UI

slyyCore.utils.notification = function(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(0, 1)
end

slyyCore.events:new("utils:notification", function(message)
    if (message == nil and message == "") then return end
    slyyCore.utils.notification(message)
end)

slyyCore.utils.helpNotification = function(message, thisFrame, beep, duration)
    AddTextEntry("helpNotification", message)

    if thisFrame then
        DisplayHelpTextThisFrame("helpNotification", false)
    else
        if beep == nil then
            beep = true
        end
        BeginTextCommandDisplayHelp("helpNotification")
        EndTextCommandDisplayHelp(0, false, beep, duration or -1)
    end
end