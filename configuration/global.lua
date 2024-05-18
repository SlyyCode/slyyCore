Config = {}
Config.Language = "fr" -- Check that the language exists, if it doesn't you can create it
Config.DebugMod = true -- Enable debug ?
Config.LocalFile = "resources/slyyCore" -- The or the file is from the resources folder
Config.ServerColor = {
    R = 91,
    G = 157,
    B = 255,
    A = 255
}
Config.BanAction = function(source, identifiers, reason)
    print(("Ban %s (%s) [%s] for %s."):format(GetPlayerName(source), source, identifiers["license"], reason))
end