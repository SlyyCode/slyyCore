slyyCore.modules.players = {}

slyyCore.events:new("onPlayerJoinded", function()
    slyyCore.modules.players.new(source)
end)

slyyCore.events:new("payment_method:pay", function(method, transaction, action, ...)
    local _source = source
    local player = slyyCore.modules.players.list[_source]

    if player:getAccountMoney(method, transaction.amount) then 
        player:removeAccountMoney(method, transaction.amount)
        slyyCore.utils.notification(_source, _("PAYMENT_METHOD_SUCCESS", slyyCore.utils.groupDigits(transaction.amount)))

        if action.accpeted ~= nil then
            slyyCore.events:internal(action.accpeted, _source, method, ...)
        end
    else 
        slyyCore.utils.notification(_source, _("PAYMENT_METHOD_NOT_ENOUGH_MONEY"))

        if action.refused ~= nil then
            slyyCore.events:internal(action.refused, _source, method, ...)
        end
    end 
end)