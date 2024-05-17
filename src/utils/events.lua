slyyCore.events = {}
slyyCore.events.list = {}

function slyyCore.events:getHash(eventName)
    return ("slyyCore:"..GetHashKey(eventName))
end

function slyyCore.events:new(eventName, handler)
    local eventHash = slyyCore.events:getHash(eventName)
    if not slyyCore.events.list[eventHash] then 
        RegisterNetEvent(eventHash)
        slyyCore.events.list[eventHash] = true
    end
    AddEventHandler(eventHash, handler)
end

function slyyCore.events:handler(eventName, handler)
    AddEventHandler(slyyCore.events:getHash(eventName), handler)
end

function slyyCore.events:basic(eventName, handler)
    AddEventHandler(eventName, handler)
end

function slyyCore.events:internal(eventName, ...)
    TriggerEvent(slyyCore.events:getHash(eventName), ...)
end