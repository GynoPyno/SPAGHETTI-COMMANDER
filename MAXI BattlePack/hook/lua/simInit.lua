
-- Hook for modfiles validator
local OldBeginSessionWyvernBattlePack = BeginSession
function BeginSession()
    OldBeginSessionWyvernBattlePack()
    ValidateModFilesWyvernBattlePack()
end

function ValidateModFilesWyvernBattlePack()
    local ModName = 'Wyvern Battle Pack'
    local ModDirectory = 'BattlePack'
    local Files = 1698
    local Bytes = 339592224
    local modlocation = ""
    for i, mod in __active_mods do
        if mod.name == ModName then
            LOG('* '..ModName..': Mod "'..ModName..'" version ('..mod.version..') is active.')
            modlocation = mod.location
        end
    end
    LOG('* '..ModName..': Running from: '..debug.getinfo(1).source..'.')
    LOG('* '..ModName..': Checking directory "/mods/'..ModDirectory..'"...')
    local FilesInFolder = DiskFindFiles('/mods/', '*.*')
    local modfoundcount = 0
    local modfilepath = ""
    for _, FilepathAndName in FilesInFolder do
        -- FilepathAndName = /mods/ai-uveso/mod_info.lua
        if string.find(FilepathAndName, 'mod_info.lua') then
            if string.gsub(FilepathAndName, ".*/(.*)/.*", "%1") == string.lower(ModDirectory) then
                modfilepath = string.gsub(FilepathAndName, "(.*/.*)/.*", "%1")
                modfoundcount = modfoundcount + 1
                if modlocation == modfilepath then
                    LOG('* '..ModName..': Found mod in correct directory: '..FilepathAndName..'.')
                else
                    LOG('* '..ModName..': Found mod in wrong directory: '..FilepathAndName..'.')
                end
            end
        end
    end
    if modfoundcount == 1 then
        LOG('* '..ModName..': Check OK. Found '..modfoundcount..' "'..ModDirectory..'" directory.')
    else
        LOG('* '..ModName..': Check FAILED! Found '..modfoundcount..' "'..ModDirectory..'" directories.')
    end
    LOG('* '..ModName..': Checking files and filesize for "'..ModName..'"...')
    local FilesInFolder = DiskFindFiles('/mods/'..ModDirectory..'/', '*.*')
    local filecount = 0
    local bytecount = 0
    local fileinfo
    for _, FilepathAndName in FilesInFolder do
        if not string.find(FilepathAndName, '.git') then
            filecount = filecount + 1
            fileinfo = DiskGetFileInfo(FilepathAndName)
            bytecount = bytecount + fileinfo.SizeBytes
        end
    end
    local FAIL = false
    if filecount < Files then
        LOG('* '..ModName..': Check FAILED! Directory: "'..ModDirectory..'" - Missing '..(Files - filecount)..' files! ('..filecount..'/'..Files..')')
        FAIL = true
    elseif filecount > Files then
        LOG('* '..ModName..': Check FAILED! Directory: "'..ModDirectory..'" - Found '..(filecount - Files)..' odd files! ('..filecount..'/'..Files..')')
        FAIL = true
    end
    if bytecount < Bytes then
        LOG('* '..ModName..': Check FAILED! Directory: "'..ModDirectory..'" - Missing '..(Bytes - bytecount)..' bytes! ('..bytecount..'/'..Bytes..')')
        FAIL = true
    elseif bytecount > Bytes then
        LOG('* '..ModName..': Check FAILED! Directory: "'..ModDirectory..'" - Found '..(bytecount - Bytes)..' odd bytes! ('..bytecount..'/'..Bytes..')')
        FAIL = true
    end
    if not FAIL then
        LOG('* '..ModName..': Check OK! files: '..filecount..', bytecount: '..bytecount..'.')
    end
end
