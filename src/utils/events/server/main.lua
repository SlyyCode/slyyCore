function slyyCore.events:client(eventName, source, ...)
    TriggerClientEvent(slyyCore.events:getHash(eventName), source, ...)
end

function slyyCore.events:all(eventName, ...)
    TriggerClientEvent(slyyCore.events:getHash(eventName), -1, ...)
end