slyyCore.utils.notification = function(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(0, 1)
end

RegisterNetEvent("utils:notification")
AddEventHandler("utils:notification", function(message)
    if (message == nil and message == "") then return end
    slyyCore.utils.notification(message)
end)