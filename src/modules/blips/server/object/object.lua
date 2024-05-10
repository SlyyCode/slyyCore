slyyCore.modules.blip.list = {}

slyyCore.modules.blip.new = function(title, position, sprite, color, shortRange, scale, public, baseAuthorized)
    local self = setmetatable({}, slyyCore.modules.blip.list)

    self.id = #slyyCore.modules.blip.list + 1
    self.title = title
    self.position = position
    self.sprite = sprite
    self.color = color 
    self.shortRange = shortRange 
    self.scale = scale or 0.7
    self.public = public
    self.authorized = baseAuthorized or {}

    self.isAuthorized = function(source)
        for k,v in pairs(self.authorized) do 
            if source == v then 
                return true
            end
        end
        return false
    end

    slyyCore.modules.blip.list[self.id] = self
    return self
end