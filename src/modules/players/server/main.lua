slyyCore.modules.players = {}

slyyCore.events:new("onPlayerJoinded", function()
    slyyCore.modules.players.new(source)
end)

slyyCore.events:new("payment_method:pay", function(method, transaction, action, ...)
    local _source = source
    local player = slyyCore.modules.players.list[_source]

    if player:getAccountMoney(method, transaction.amount) then 

    else 
        slyyCore.utils.notification(_source, "")
    end 
end)