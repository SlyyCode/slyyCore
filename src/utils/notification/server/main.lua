slyyCore.utils.notification = function(source, message)
    slyyCore.events:client("utils:notification", source, message)
end