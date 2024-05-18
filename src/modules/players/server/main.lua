slyyCore.modules.players = {}

slyyCore.events:new("onPlayerJoinded", function()
    slyyCore.modules.players.new(source)
end)

slyyCore.events:new("payment_method:pay", function(method, transaction, action, ...)
    local _source = source
    local player = slyyCore.modules.players.list[_source]

    if method ~= nil then
        if player:getAccountMoney(method, transaction.amount) then 
            player:removeAccountMoney(method, transaction.amount)
            slyyCore.utils.notification(_source, _("PAYMENT_METHOD_SUCCESS", slyyCore.utils.groupDigits(transaction.amount)))

            if action.accpeted ~= nil then
                slyyCore.events:internal(action.accpeted, {
                    source = _source, 
                    method = method, 
                    price = transaction.amount
                }, ...)
            end
        else 
            slyyCore.utils.notification(_source, _("PAYMENT_METHOD_NOT_ENOUGH_MONEY"))

            if action.refused ~= nil then
                slyyCore.events:internal(action.refused, {
                    source = _source, 
                    method = method, 
                    price = transaction.amount
                }, ...)
            end
        end 
    else
        slyyCore.utils.notification(_source, _("PAYMENT_METHOD_CANCEL"))

        if action.refused ~= nil then
            slyyCore.events:internal(action.refused, {
                source = _source, 
                method = "cancel", 
                price = transaction.amount
            }, ...)
        end
    end
end)