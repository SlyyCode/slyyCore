slyyCore.utils.plateExist = function(plate)
    local response = MySQL.query.await("SELECT * FROM `owned_vehicles` WHERE `plate` = '"..plate.."'")
    return json.encode(response) ~= "[]" 
end