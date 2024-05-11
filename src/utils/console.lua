while slyyCore == nil do Wait(1) end
slyyCore.console = {}
local _print = print

function slyyCore.console:print(...)
    _print(("[^5slyyCore^7] %s"):format(...))
end

function slyyCore.console:debug(...)
    if Config.DebugMod then
        _print(("[^5slyyCore^7] [^4DEBUG^7] %s"):format(...))
    end
end

function slyyCore.console:sucess(...)
    _print(("[^5slyyCore^7] [^2SUCESS^7] %s"):format(...))
end

function slyyCore.console:error(...)
    _print(("[^5slyyCore^7] [^8ERROR^7] %s"):format(...))
end

print = function(...)
    slyyCore.console:print(...)
end

if IsDuplicityVersion() then 
    slyyCore.events:new("toServerPrint", function(...)
        slyyCore.console:print(...)
    end)
end