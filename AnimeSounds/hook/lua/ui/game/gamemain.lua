AddBeatFunction(function()
    if not table.empty(Sync.Voice) then
        for k, v in Sync.Voice do
            if v.Cue == 'Computer_Computer_Commanders_01314' then
                ForkThread(function()
                    WaitSeconds(1)
                    PlaySound(Sound {
                        Bank = 'sounds',
                        Cue = 'acu' .. tostring(math.random(1, 11))
                    })
                end)
                break
            end
        end
    end
end, true)
