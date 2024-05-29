slyyCore.modules.players = {}

slyyCore.events:new("onPlayerJoinded", function()
    slyyCore.modules.players.new(source)
end)

slyyCore.events:basic("esx:setJob", function(source, newJob, lastJob)
    local _source = source 
    local player = slyyCore.modules.players.list[_source]
    player:setJob(newJob)

    if newJob.name == lastJob.name then 
        if lastJob.grade_name == "boss" and newJob.grade_name ~= "boss" then
            for k,v in pairs(player.myZones) do 
                if v.boss then 
                    v.removeAuthorized(_source)
                    slyyCore.events:client("zones:remove", _source, v.id)
                    break
                end
            end
        end
        if lastJob.grade_name ~= "boss" and newJob.grade_name == "boss" then
            for k,v in pairs(slyyCore.modules.zones.list) do 
                if v.authorization ~= nil and v.authorization == newJob.name and v.boss then 
                    v.addAuthorized(_source)
                    slyyCore.events:client("zones:new", _source, v)
                    break
                end
            end
        end
    else
        for k,v in pairs(slyyCore.modules.zones.list) do 
            if v.authorization ~= nil and v.authorization == lastJob.name then 
                v.removeAuthorized(_source)
                slyyCore.events:client("zones:remove", _source, v.id)
            end
            if v.authorization ~= nil and v.authorization == newJob.name then 
                if not v.boss then
                    v.addAuthorized(_source)
                    slyyCore.events:client("zones:new", _source, v)
                else 
                    if newJob.grade_name == "boss" then 
                        v.addAuthorized(_source)
                        slyyCore.events:client("zones:new", _source, v)
                    end
                end
            end
        end
    end
end)

slyyCore.events:new("payment_method:request", function(target, transaction, action, ...)
    if GetPlayerName(target) == nil then 
        return
    end
    transaction.sender = source
    slyyCore.events:client("payment_method:request", target, transaction, action, ...)
end)

slyyCore.events:new("payment_method:pay", function(method, transaction, action, ...)
    local _source = source
    local player = slyyCore.modules.players.list[_source]

    if method ~= nil then
        if player:getAccountMoney(method, transaction.amount) then 
            player:removeAccountMoney(method, transaction.amount)
            slyyCore.utils.notification(_source, _("PAYMENT_METHOD_SUCCESS", slyyCore.utils.groupDigits(transaction.amount)))
            if transaction.sender then 
                slyyCore.utils.notification(transaction.sender, _("PAYMENT_METHOD_SUCCESS_SENDER", slyyCore.utils.groupDigits(transaction.amount)))
            end

            if action.accpeted ~= nil then
                slyyCore.events:internal(action.accpeted, {
                    source = _source, 
                    method = method, 
                    price = transaction.amount,
                    sender = transaction.sender
                }, ...)
            end
        else 
            slyyCore.utils.notification(_source, _("PAYMENT_METHOD_NOT_ENOUGH_MONEY"))
            if transaction.sender then 
                slyyCore.utils.notification(transaction.sender, _("PAYMENT_METHOD_NOT_ENOUGH_MONEY_SENDER"))
            end

            if action.refused ~= nil then
                slyyCore.events:internal(action.refused, {
                    source = _source, 
                    method = method, 
                    price = transaction.amount,
                    sender = transaction.sender
                }, ...)
            end
        end 
    else
        slyyCore.utils.notification(_source, _("PAYMENT_METHOD_CANCEL"))
        if transaction.sender then 
            slyyCore.utils.notification(transaction.sender, _("PAYMENT_METHOD_CANCEL_SENDER"))
        end

        if action.refused ~= nil then
            slyyCore.events:internal(action.refused, {
                source = _source, 
                method = "cancel", 
                price = transaction.amount
            }, ...)
        end
    end
end)