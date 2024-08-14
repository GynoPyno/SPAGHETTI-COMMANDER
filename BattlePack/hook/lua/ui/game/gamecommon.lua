local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version < 3652 then -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function
    LOG('Wyvern Battle Pack: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Gameversion is older then 3652. Hooking "GetUnitIconFileNames" to add our own unit icons')

local MyUnitIdTable = {
   wel0303=true, -- Rockhead - (Heavy Assault Tank)
   wal0401=true, -- Universal Colossus - (Experimental Assault Bot)
   ual0401=true, -- Galactic Colossus - (Experimental Assault Bot)
   wel0416=true, -- Dragonite - (Ultimate Assault Bot)
   web4301=true, -- Protector - (Advanced Tactical Missile Defense)
   wsa0201=true, -- Talium - (Combat Fighter)
   web0404=true, -- Turtle - (Anti Navy MKII Installation)
   wsl0403=true, -- Echibum - (Experimental Tank)
   wrb2302=true, -- LRA MK II - (Heavy Artillery Installation)
   wrb4207=true, -- ED5 - (Shield Generator)
   wel0309=true, -- Air Banisher - (Heavy Anti-Air Tank)
   wea0305=true, -- Ripper - (Strategic Missile Bomber)
   wra0202=true, -- Stalker - (Combat Interceptor)
   wsb4205=true, -- Au-iya - (Restoration Field Generator)
   wra0303=true, -- Regegade MK II - (Heavy Gunship)
   waa0305=true, -- Fury - (Attack Bomber)
   wel1409=true, -- Fatboy 2 - (Experimental Assault Vehicle)
   wsb1303=true, -- Resource Plant - (Resource Manufacturing Facility)
   wrb1303=true, -- Resource Plant - (Resource Manufacturing Center)
   wrl0209=true, -- Construction Kbot - (Combat Engineer)
   wab2303=true, -- Toth - (Missile Tower)
   wsa0306=true, -- Nyahmish - (Heavy Air Transport)
   wsb4404=true, -- Nagashm - (Experimental Anti-Air Defense)
   wrl0402=true, -- Devastation - (Experimental Assault Vehicle)
   web0401=true, -- Sedokin - (Experimental Intelligence Center)
   wel0401=true, -- The Wyvern - (Experimental Assault Tank)
   wsb1401=true, -- Pacclow - (Experimental Shield Generator)
   wsl0202=true, -- Onyxum - (Heavy Tank)
   wes0303=true, -- Posideon Class - (Advanced Battleship)
   wsl0404=true, -- Echibum - (Experimental Tank)
   wab1302=true, -- HCB4 - (Advanced Hydrocarbon Power Plant)
   wrl0207=true, -- MSG Spiderbot - (Mobile Shield Generator)
   web1302=true, -- AHCPP - X2000 - (Advanced Hydrocarbon Power Plant)
   wel0207=true, -- Sharp Shooter - (Mobile Anti-Missile Defense)
   wsl0308=true, -- Streekum - (Assault Tank)
   wrl1211=true, -- Eviction - (Mobile Heavy Rocket Artillery)
   wsl0302=true, -- Trapnichum - (Siege Bot)
   wrs0303=true, -- Executioner Class - (Battleship)
   wrb0304=true, -- The Hive - (Engineering Station)
   wal4404=true, -- Marauder - (Experimental Siege Bot)
   wsl0309=true, -- Kersploosh - (Mobile Anti-Air Tank)
   web0204=true, -- The Kennel - (Engineering Station)
   wel4404=true, -- Star Adder - (Experimental Heavy Mech)
   wrb1302=true, -- XD500 Processing Plant - (Advanced Hydrocarbon Power Plant)
   wrl0309=true, -- Python - (Mobile Anti-Air Tank)
   wrl0303=true, -- A.K. - (Prototype Medium Attack Bot)
   wrl0305=true, -- Pin shot - (Sniper Bot)
   wsb2308=true, -- Cheya Uosthu - (Advanced Torpedo Station)
   was0332=true, -- Shadow of Intent - (Battleship)
   wrs0401=true, -- Universe Class - (Experimental Battleship)
   wel0305=true, -- Pegasus - (Prototype Armored Siege Bot)
   wal0305=true, -- Hellfury - (Heavy Assault Tank)
   wel0304=true, -- Rommel - (Heavy Assault Tank)
   wss0401=true, -- Eechibumas - (Heavy Battlecruiser)
   wrl0306=true, -- Ragnarok - (Heavy Siege Assault Bot)
   wal0309=true, -- Crahdow - (Mobile AA Tank)
   wsb1444=true, -- Pacclow - (Experimental Resource Generator)
   wra0305=true, -- Bion - (Advanced Multipurpose Fighter)
   wsl0205=true, -- Beshlas - (Defender Bot)
   wes0401=true, -- Ultimina Class - (Experimental Battlecruiser)
   uab2310=true, -- Heavy Experimental Defense Installation  - (Heavy Experimental Defense Installation )
   wab1303=true, -- Resource Plant - (Resource Manufacturing Facility)
   wrl0302=true, -- Symbiont - (Heavy Tank)
   web1303=true, -- Resource Plant - (Resource Manufacturing Facility)
   wel0302=true, -- Wrecker - (Heavy Gatling Bot)
   wrl0301=true, -- Lion - (Heavy Stealth Tank)
   wss0301=true, -- Echigo - (Support Battleship)
   wel03041=true, -- Demolisher MKII - (Prototype Mobile Heavy Artillery)
   wrl2466=true, -- Storm Strider - (Experimental Fortress Megabot)
   wra0401=true, -- Soul Ripper II - (Experimental Gunship)
   wrl0404=true, -- Megalith MK II - (Experimental Prototype Spiderbot)
   wrl1466=true, -- Storm Spider - (Experimental Fortress Megabot)
   wsb1302=true, -- EQ5 - (Advanced Hydrocarbon Power Plant)
   wrb4302=true, -- H.M.D.T. - (Heavy Point Defense)
}

    local IconPath = "/Mods/BattlePack"
    -- Adds icons to the unitselectionwindow
    local oldGetUnitIconFileNames = GetUnitIconFileNames
    function GetUnitIconFileNames(blueprint)
        if MyUnitIdTable[blueprint.Display.IconName] then
            local iconName = IconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
            local upIconName = IconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
            local downIconName = IconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
            local overIconName = IconPath .. "/icons/units/" .. blueprint.Display.IconName .. "_icon.dds"
            return iconName, upIconName, downIconName, overIconName
        else
            return oldGetUnitIconFileNames(blueprint)
        end
    end

else
    LOG('Wyvern Battle Pack: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Gameversion is 3652 or newer. No need to insert the unit icons by our own function.')
end
