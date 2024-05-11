Config.new = function()
    local self = {}
    local self.data = {}

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

    return self
end