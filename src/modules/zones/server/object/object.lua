slyyCore.modules.zones.list = {}

slyyCore.modules.zones.new = function(position, marker, helpText, dist, onInteract, public, baseAuthorized)
    local self = setmetatable({}, slyyCore.modules.zones.list)

    self.id = #slyyCore.modules.zones.list + 1
    self.position = position 
    self.helpText = helpText
    self.marker = {
        id = marker.id or 0,
        color = marker.color or {Config.ServerColor.R, Config.ServerColor.G, Config.ServerColor.B, Config.ServerColor.A},
        size = marker.size or {0.35, 0.35, 0.35},
        bobUpAndDown = marker.bobUpAndDown or false,
        faceCamera = marker.faceCamera or false,
        rotate = marker.rotate or false,
        draw = dist.draw or 20,
        interact = dist.interact or 2
    }
    self.onInteract = function(source)
        slyyCore.console:debug(("%s to interact with zone %s."):format(GetPlayerName(source), self.id))
        onInteract(source)
    end
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

    slyyCore.modules.zones.list[self.id] = self
    return self
end