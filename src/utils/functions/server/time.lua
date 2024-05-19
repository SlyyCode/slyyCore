slyyCore.utils.getFormattedDateTime = function()
    local dateTable = os.date("*t")
    local day = string.format("%02d", dateTable.day)
    local month = string.format("%02d", dateTable.month)
    local year = dateTable.year
    local hour = string.format("%02d", dateTable.hour)
    local minute = string.format("%02d", dateTable.min)
    local second = string.format("%02d", dateTable.sec)
    
    return ("%s-%s-%s %s:%s:%s"):format(day, month, year, hour, minute, second)
end