slyyCore.modules.vehicles.list = {}

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

    self.setProperties = function(self, properties)
        --@SlyyCode: faire le set properties client side
    end

    self.setPlate = function(self, plate)
        SetVehicleNumberPlateText(self.entity, plate)
    end

    self.warpPlayer = function(self, source, seat)
        TaskWarpPedIntoVehicle(GetPlayerPed(source), self.entity, seat)
    end

    return self
end