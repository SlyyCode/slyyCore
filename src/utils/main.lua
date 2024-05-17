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
