#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0303/XSL0303_script.lua
#**  Author(s):  Dru Staltman, Aaron Lundquist
#**
#**  Summary  :  Seraphim Siege Tank Script
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local WeaponsFile = import('/lua/seraphimweapons.lua')
local SDFThauCannon = WeaponsFile.SDFThauCannon
local SDFAireauBolter = WeaponsFile.SDFAireauBolterWeapon
local SANUallCavitationTorpedo = WeaponsFile.SANUallCavitationTorpedo
local SDFUltraChromaticBeamGenerator = import('/lua/seraphimweapons.lua').SDFUltraChromaticBeamGenerator


LED0021 = Class(SLandUnit) {
    Weapons = {
        MainTurret = Class(SDFThauCannon) {},
        Torpedo01 = Class(SANUallCavitationTorpedo) {},
        LeftTurret = Class(SDFAireauBolter) {},
        RightTurret = Class(SDFAireauBolter) {},
		SecondTurret = Class(SDFThauCannon) {},
		LaserGun = Class(SDFUltraChromaticBeamGenerator) {},
    },
	
	OnCreate = function(self)
        SLandUnit.OnCreate(self)
        self.Effect1 = CreateAttachedEmitter(self,'Upgrade04_01',self:GetArmy(), '/effects/emitters/seraphim_being_built_ambient_02_emit.bp')
		self.Trash:Add(self.Effecct1)
		self.Trash:Add(CreateRotator(self, 'Upgrade04_01', 'z', nil, 130, 0, 130))
    end,
}

TypeClass = LED0021