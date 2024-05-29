slyyCore.utils.getPlayersJob = function(job)
    local players = {}
    for _, player in pairs(slyyCore.modules.players.list) do 
        if player.job.name == job then 
            table.insert(players, player.source)
        end
    end
    return players
end