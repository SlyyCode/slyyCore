slyyCore.modules.zones.list = {}

slyyCore.modules.zones.new = function(position, marker, helpText, dist, onInteract)
    local self = setmetatable({}, slyyCore.modules.zones.list)

    self.id = #slyyCore.modules.zones.list + 1
    self.position = position 
    self.marker = {
        id = marker.id or 0,
        color = marker.color or {0, 0, 0, 255},
        size = marker.size or {1.0, 1.0, 1.0},
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

    slyyCore.modules.zones.list[self.id] = self
    slyyCore.console:debug(("Created zone id: %s"):format(self.id))
    slyyCore.events:all("zones:new", self)
    return self
end

RegisterCommand("test", function()
    slyyCore.modules.zones.new(vector3(169.11, -875.15, 30.45), {
        id = 0,
        color = {0, 0, 255, 255},
        bobUpAndDown = true,
        faceCamera = false,
        rotate = true
    }, "Appuyez ici pour intéragir", {draw = 10, interact = 2}, function(source)
        print("test")
    end)
end, false)