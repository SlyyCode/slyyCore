slyyCore.modules.vehicles.list = {}

local function getRandomId()
    for id,_ in pairs(slyyCore.modules.players.list) do 
        return id 
    end
    return false
end

--@type: automobile, bike, boat, heli, plane, submarine, trailer, train

slyyCore.modules.vehicles.new = function(model)
    local self = setmetatable({}, slyyCore.modules.vehicles.list)

    self.model = model
    self.hash = GetHashKey(self.model)
    self.entity = nil

    self.createVehicle = function(self, coords, heading, cb)
        self.entity = CreateVehicleServerSetter(model, "automobile", coords, heading)
        while not self.entity do
            Wait(1)
        end
        self.netId = NetworkGetNetworkIdFromEntity(self.entity)
        self.owner = NetworkGetEntityOwner(self.entity)
        slyyCore.modules.vehicles.list[self.entity] = self
        if cb then
            cb(self)
        end
    end

    self.setProperties = function(self, properties, source)
        slyyCore.events:client("vehicles:setProperties", source or getRandomId(), self.netId, properties)
    end

    self.setColours = function(self, colorPrimary, colorSecondary)
        slyyCore.events:client("vehicles:setColours", source or getRandomId(), self.netId, colorPrimary, colorSecondary)
    end

    self.setPlate = function(self, plate)
        SetVehicleNumberPlateText(self.entity, plate)
    end

    self.warpPlayer = function(self, source, seat)
        TaskWarpPedIntoVehicle(GetPlayerPed(source), self.entity, seat)
    end

    self.lock = function(self)
        SetVehicleDoorsLocked(self.entity, 2)
    end

    self.unlock = function(self)
        SetVehicleDoorsLocked(self.entity, 1)
    end

    self.getEntity = function(self)
        return self.entity
    end

    self.delete = function()
        if self.entity then
            slyyCore.modules.vehicles.list[self.entity] = nil
            
            while DoesEntityExist(self.entity) do 
                DeleteEntity(self.entity)
                Wait(1)
            end
        end
    end

    return self
end