slyyCore = {}

if not IsDuplicityVersion() then 
    CreateThread(function()
        while true do
            if NetworkIsPlayerActive(PlayerId()) then 
                DoScreenFadeOut(0)
                Wait(1000)
                DoScreenFadeIn(1500)
                slyyCore.events:server("onPlayerJoinded")
                break
            end
            Wait(100)
        end
    end)
end