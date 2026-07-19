local OldOnSync = OnSync

OnSync = function()
    if Sync.Voice then
        local filtered = {}
        local playNukeAlarm = false
        for k, v in Sync.Voice do
            if v.Bank == 'XGG' and v.Cue == 'Computer_Computer_MissileLaunch_01351' then
                playNukeAlarm = true
            else
                table.insert(filtered, v)
            end
        end
        Sync.Voice = filtered
        if playNukeAlarm then
            PlaySound(Sound {
                Bank = 'Audiowo',
                Cue = 'nuke_alarm',
            })
        end
    end
    return OldOnSync()
end
