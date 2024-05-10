function slyyCore.events:server(eventName, ...)
    TriggerServerEvent(slyyCore.events:getHash(eventName), ...)
end