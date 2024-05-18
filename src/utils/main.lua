slyyCore.utils = {}

slyyCore.utils.groupDigits = function(value)
    local left, num, right = string.match(value, "^([^%d]*%d)(%d*)(.-)$")
    if not left or not num or not right then
        return value
    end
    local formattedNum = num:reverse():gsub("(%d%d%d)", "%1 "):reverse()

    if formattedNum:sub(1, 1) == " " then
        formattedNum = formattedNum:sub(2)
    end
    return left..formattedNum..right
end

slyyCore.utils.trim = function(value)
    if value then
        return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
    else
        return nil
    end
end

slyyCore.utils.round = function(value, numDecimalPlaces)
    if numDecimalPlaces then
        local power = 10 ^ numDecimalPlaces
        return math.floor((value * power) + 0.5) / power
    else
        return math.floor(value + 0.5)
    end
end

slyyCore.utils.sizeOf = function(t)
    local size = 0
    for _,_ in pairs(t) do 
        size += 1
    end
    return size
end

slyyCore.utils.genPlate = function()
    local format = ""
    local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i = 1, 8 do
        local charIndex = math.random(1, #characters)
        format = format .. string.sub(characters, charIndex, charIndex)
    end
    return format
end