slyyCore.zones.list = {}

slyyCore.zones.new = function(position, marker, helpText, dist, onInteract)
    local self = setmetatable({}, slyyCore.zones.list)

    self.id = #slyyCore.zones.list + 1
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
        print(("%s à intéragit avec la zone numéro %s."):format(GetPlayerName(source), self.id))
        onInteract(source)
    end

    print(("Created zone id: %s"):format(self.id))

    TriggerClientEvent("zones:new", -1, self)
    slyyCore.zones.list[self.id] = self
    return self
end

RegisterCommand("test", function()
    slyyCore.zones.new(vector3(169.11, -875.15, 30.45), {
        id = 0,
        color = {0, 0, 255, 255},
        bobUpAndDown = true,
        faceCamera = false,
        rotate = true
    }, "Appuyez ici pour intéragir", {draw = 10, interact = 2}, function(source)
        print("test")
    end)
end, false)