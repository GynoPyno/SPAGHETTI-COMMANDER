#****************************************************************************
#**
#**  File     :  /units/URL0320/URL0320_script.*
#**  Author(s):  Asdrubaelvect
#**
#**  Summary  :  Cybran Siege Assault Bot Script
#****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit

local WeaponsFile = import ( '/Mods/XtremWars/hook/lua/cybranweapons.lua' )
local CybranWeaponsFile = import('/lua/cybranweapons.lua')
local CDFHeavyMicrowaveLaserGeneratorCom02 = WeaponsFile.CDFHeavyMicrowaveLaserGeneratorCom02
local CDFHeavyDisintegratorWeapon = CybranWeaponsFile.CDFHeavyDisintegratorWeapon
local CAAMissileNaniteWeapon = CybranWeaponsFile.CAAMissileNaniteWeapon
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon


URL0320 = Class(CWalkingLandUnit)
{
    Weapons = {
		Disintigrator01 = Class(CDFHeavyDisintegratorWeapon) {
		},
		MainGun = Class(CDFHeavyMicrowaveLaserGeneratorCom02) {
		},
		####UPGRADE02
		Disintigrator02 = Class(CAAMissileNaniteWeapon) {
		},		
		###UPGRADE03
		HeavyBolterI = Class(CDFElectronBolterWeapon) {
			OnCreate = function(self)
                CDFElectronBolterWeapon.OnCreate(self)
                #Disable buff 
                self:DisableBuff('STUN')
            end,
		},
		HeavyBolterII = Class(CDFElectronBolterWeapon) {
			OnCreate = function(self)
                CDFElectronBolterWeapon.OnCreate(self)
                #Disable buff 
                self:DisableBuff('STUN')
            end,
		},
    },
	
	OnCreate = function(self)
        CWalkingLandUnit.OnCreate(self)

    end,	
	  
	
    OnKilled = function(self, instigator, type, overkillRatio)
        local emp = self:GetWeaponByLabel('EMP')
        local bp
        for k, v in self:GetBlueprint().Buffs do
            if v.Add.OnDeath then
                bp = v
            end
        end
        #if we could find a blueprint with v.Add.OnDeath, then add the buff 
        if bp != nil then 
            #Apply Buff
			self:AddBuff(bp)
        end
        #otherwise, we should finish killing the unit
           
		if self.UnitComplete then
            # Play EMP Effect
            CreateLightParticle( self, -1, -1, 24, 62, 'flare_lens_add_02', 'ramp_red_10' )
            # Fire EMP weapon
            emp:SetWeaponEnabled(true)
            emp:OnFire()
        end
        CWalkingLandUnit.OnKilled(self, instigator, type, overkillRatio)
    end,	
	
}
TypeClass = URL0320
