#****************************************************************************
#**
#**  File     :  /cdimage/units/UEL0202/UEL0202_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Heavy Tank Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local BeamtankLaser = import('/mods/#Marlos mods compilation/lua/MKWeapons.lua').BeamtankLaser

UEL0202 = Class(TLandUnit) {
    Weapons = {
        OrbitalDeathLaserWeapon = Class(BeamtankLaser){},
    },
	
 --   OnKilled = function(self, instigator, type, overkillRatio)
 --       if self.IsDying then 
  --          return 
  --      end
  --      
  --      local wep = self:GetWeaponByLabel('OrbitalDeathLaserWeapon')
  --      for k, v in wep.Beams do
  --          v.Beam:Disable()
  --      end      
  --      
  --      self.IsDying = true
  --      self.Parent:Kill(instigator, type, 0)
  --      
  --      TLandUnit.OnKilled(self, instigator, type, overkillRatio)        
  --  end,
}

TypeClass = UEL0202