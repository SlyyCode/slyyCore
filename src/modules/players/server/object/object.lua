slyyCore.modules.players.list = {}

slyyCore.modules.players.new = function(source)
    local self = setmetatable({}, slyyCore.modules.players.list)

    self.source = source 
    self.name = GetPlayerName(self.source)
    
    slyyCore.modules.players.list[self.source] = self
    return self
end