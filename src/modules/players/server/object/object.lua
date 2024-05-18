slyyCore.modules.players.list = {}

slyyCore.modules.players.new = function(source)
    local self = setmetatable({}, slyyCore.modules.players.list)

    self.source = source 
    self.name = GetPlayerName(self.source)
    self.rp_name = "Player RolePlay Name"
    self.identifiers = slyyCore.utils.getIdentifiers(self.source)

    self.getRpName = function(self)
        return self.rp_name
    end

    self.setCoords = function(self, coords)
        SetEntityCoords(GetPlayerPed(self.source), coords)
    end

    self.putInBucket = function(self, bucketId)
        SetEntityRoutingBucket(GetPlayerPed(self.source), bucketId ~= nil and bucketId or self.source)
    end

    self.removeBucket = function(self)
        SetEntityRoutingBucket(GetPlayerPed(self.source), 0)
    end

    self.getBucket = function(self)
        return GetEntityRoutingBucket(GetPlayerPed(self.source))
    end

    self.addAccountMoney = function(self, account, amount)

    end

    self.removeAccountMoney = function(self, account, amount)

    end

    self.getAccountMoney = function(self, account)
        return true
    end

    self:removeBucket()
    slyyCore.modules.players.list[self.source] = self
    return self
end