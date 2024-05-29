slyyCore.modules.players.list = {}

slyyCore.modules.players.new = function(source)
    local self = setmetatable({}, slyyCore.modules.players.list)

    while slyyCore.modules.framework == nil do -- Check if the framework has loaded
        Wait(1)
    end

    self.frameworkPlayer = slyyCore.modules.framework.GetPlayerFromId(source)
    self.source = source 
    self.job = self.frameworkPlayer.job
    self.name = GetPlayerName(self.source)
    self.rp_name = self.frameworkPlayer.name or "Player RolePlay Name"
    self.identifiers = slyyCore.utils.getIdentifiers(self.source)
    self.myZones = {}

    self.initZones = function(self)
        for k,v in pairs(slyyCore.modules.zones.list) do 
            if self.job.name == v.authorization then 
                v.addAuthorized(self.source)
            end
        end
        self:updateZone()
        slyyCore.events:client("zones:receiveZones", source, self.myZones)
    end

    self.updateZone = function(self)
        self.myZones = slyyCore.modules.zones.getMyZones(self.source)
    end

    self.setJob = function(self, newJob)
        self.job = newJob
    end

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
    self:initZones()
    slyyCore.modules.players.list[self.source] = self
    return self
end