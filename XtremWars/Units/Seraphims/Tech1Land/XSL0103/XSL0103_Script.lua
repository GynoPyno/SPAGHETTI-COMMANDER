#****************************************************************************
#**
#**  File     :  /cdimage/units/XSL0103/XSL0103_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix, Aaron Lundquist
#**				Upgrades Model By Asdrubaelvect Script By Manimal For Experimental Wars 1.8
#**  Summary  :  Seraphim Mobile Light Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local SIFThunthoCannonWeapon = import('/lua/seraphimweapons.lua').SIFThunthoCannonWeapon

XSL0103 = Class(SHoverLandUnit) {
    Weapons = {
        MainGun = Class(SIFThunthoCannonWeapon) {},
		###UPGRADE03
		UpgradeGun01 = Class(SIFThunthoCannonWeapon) {},
		UpgradeGun02 = Class(SIFThunthoCannonWeapon) {},
    },

    OnCreate = function(self)
        SHoverLandUnit.OnCreate(self)
		self.Effect1 = CreateAttachedEmitter(self,'XSL0103',self:GetArmy(), '/effects/emitters/seraphim_being_built_ambient_02_emit.bp')
		self.Trash:Add(self.Effecct1)
		self.Trash:Add(CreateRotator(self, 'Upgrade05_01', 'y', nil, 100, 0, 100))
		self.Effect2 = CreateAttachedEmitter(self,'XSL0103',self:GetArmy(), '/effects/emitters/seraphim_being_built_ambient_02_emit.bp')
		self.Trash:Add(self.Effecct2)
		self.Trash:Add(CreateRotator(self, 'Upgrade05_02', 'y', nil, -100, 0, -100))
    end,

}

TypeClass = XSL0103