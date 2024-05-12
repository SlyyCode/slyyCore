slyyCore.modules.players.list = {}

slyyCore.modules.players.new = function(source)
    local self = setmetatable({}, slyyCore.modules.players.list)

    self.source = source 
    self.name = GetPlayerName(self.source)
    self.identifiers = slyyCore.utils.getIdentifiers(self.source)

    self.setCoords = function(self, coords)
        SetEntityCoords(GetPlayerPed(self.source), coords)
    end

    slyyCore.modules.players.list[self.source] = self
    return self
end