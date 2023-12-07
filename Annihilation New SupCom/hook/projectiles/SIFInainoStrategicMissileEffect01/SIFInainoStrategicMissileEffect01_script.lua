local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version >= 1 then
	LOG('Annihilation New SupCom (Preservation): [SIFInainoStrategicMissileEffect01_script.lua '..debug.getinfo(1).currentline..'] - Gameversion is 3652 or newer. Hooking "SIFInainoStrategicMissileEffect01".')
	

#****************************************************************************
#**
#**  File     :  /projectiles/SIFInainoStrategicMissileEffect01/SIFInainoStrategicMissileEffect01_script.lua
#**  Author(s):  Greg Kohne, Gordon Duclos
#**
#**  Summary  :  Ohwalli Strategic Bomb effect script, non-damaging
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local EffectTemplate = import('/lua/EffectTemplates.lua')

SBOOhwalliBombESIFInainoStrategicMissileEffect01ffect01 = Class(import('/lua/sim/defaultprojectiles.lua').EmitterProjectile) {
	FxTrails = EffectTemplate.SIFInainoPlumeFxTrails01,
}
TypeClass = SIFInainoStrategicMissileEffect01

else
	LOG('Annihilation New SupCom (Preservation): [SIFInainoStrategicMissileEffect01_script.lua '..debug.getinfo(1).currentline..'] - Gameversion is older then 3652. No need to hook "SIFInainoStrategicMissileEffect01".')
end