#****************************************************************************
#**
#**  File     :  /cdimage/units/URL0302/URL0302_script.lua
#**  Author(s):  David Tomandl, Jessica St. Croix
#**
#**  Summary  :  Cybran Sub Commander Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit

WRL0207 = Class(CWalkingLandUnit) {

	ShieldEffects = {
			'/mods/BattlePack/effects/emitters/ex_cybran_shieldgen_01_emit.bp',
    },

	OnStopBeingBuilt = function(self,builder,layer)
        CWalkingLandUnit.OnStopBeingBuilt(self,builder,layer)
        self.Rotator1 = CreateRotator(self, 'Shaft', 'y', nil, 30, 5, 30)
        self.Trash:Add(self.Rotator1)
		self.ShieldEffectsBag = {}
    end,
	
	OnShieldEnabled = function(self)
        CWalkingLandUnit.OnShieldEnabled(self)
        if self.Rotator1 then
            self.Rotator1:SetTargetSpeed(10)
        end
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 'ShieldEffect', self:GetArmy(), v ) )
        end
    end,

    OnShieldDisabled = function(self)
        CWalkingLandUnit.OnShieldDisabled(self)
        self.Rotator1:SetTargetSpeed(0)
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
    end,

}

TypeClass = WRL0207
