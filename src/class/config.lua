Config.list = {}

Config.new = function(name)
    local self = {}
    self.name = name
    self.data = {}

    self.set = function(self, key, value)
        self.data[key] = value
    end

    self.get = function(self, key)
        return self.data[key]
    end

    self.remove = function(self, key)
        self.data[key] = nil
    end

    self.contains = function(self, key)
        return self.data[key] ~= nil
    end

    Config.list[name] = self
    return self
end

Config.getConfig = function(name)
    if (Config.list[name] == nil) then return end
    return Config.list[name]
end