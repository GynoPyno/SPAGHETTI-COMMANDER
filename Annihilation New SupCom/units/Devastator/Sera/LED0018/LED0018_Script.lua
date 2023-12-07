----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/XSL0304/XSL0304_script.lua
--  Author(s):  John Comes, David Tomandl, Matt Vainio, Aaron Lundquist
--
--  Summary  :  Seraphim Mobile Heavy Artillery
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local SWalkingLandUnit = import( '/lua/seraphimunits.lua').SWalkingLandUnit
local SIFSuthanusArtilleryCannon = import('/lua/seraphimweapons.lua').SIFSuthanusMobileArtilleryCannon

LED0018 = Class(SWalkingLandUnit) {
    Weapons = {
        MainGun = Class(SIFSuthanusArtilleryCannon) {},
        Upgrade02Gun = Class(SIFSuthanusArtilleryCannon) {},
        Upgrade03Gun = Class(SIFSuthanusArtilleryCannon) {},
    },
    OnCreate = function(self)
        SWalkingLandUnit.OnCreate(self)
        self.Effect1 = CreateAttachedEmitter(self,'Upgrade05_01',self:GetArmy(), '/effects/emitters/seraphim_being_built_ambient_02_emit.bp')
		self.Trash:Add(self.Effecct1)
    end,
}
TypeClass = LED0018