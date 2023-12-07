#****************************************************************************
#**
#**  File     :  /cdimage/units/UAB2301/GGA00002_script.lua
#**  Author(s):  bbkineebee
#**
#**  Summary  :  Cybran T4 Crusher
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CShieldLandUnit = import('/lua/cybranunits.lua').CShieldLandUnit
local blnCrusherActive = false

GGA0002 = Class(CShieldLandUnit) {


    ShieldEffects = {
        '/mods/GGACybranT4Crusher/effects/Emitters/cybran_shield_generator_Mobile_01_emit.bp',
        '/mods/GGACybranT4Crusher/effects/Emitters/cybran_shield_generator_Mobile_02_emit.bp',
    },


    OnMotionHorzEventChange = function(self, new, old)
        CShieldLandUnit.OnMotionHorzEventChange(self, new, old)

        if new == "Cruise" then
		self.RotatorManipulator:SetSpeed( 40 )
		blnCrusherActive = true
	elseif  new == "TopSpeed" then
		self.RotatorManipulator:SetSpeed( 40 )
		blnCrusherActive = true
	elseif  new == "Stopped" then
		self.RotatorManipulator:SetSpeed( 0 )
		blnCrusherActive = false
	elseif  new == "Stopping" then
		self.RotatorManipulator:SetSpeed( 0 )
		blnCrusherActive = true
        end


    end,

    
    OnStopBeingBuilt = function(self,builder,layer)
        CShieldLandUnit.OnStopBeingBuilt(self,builder,layer)
		self.ShieldEffectsBag = {}

	blnCrusherActive = false
	self.CrushThread = self:ForkThread(self.Crush)

        self.RotatorManipulator = CreateRotator( self, 'Spinner', 'y' )
        self.Trash:Add( self.RotatorManipulator )
    end,
    
    OnShieldEnabled = function(self)
        CShieldLandUnit.OnShieldEnabled(self)

        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 0, self:GetArmy(), v ) )
        end
    end,


    OnShieldDisabled = function(self)
        CShieldLandUnit.OnShieldDisabled(self)

        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
    end,


    DoTakeDamage = function(self, instigator, amount, vector, damageType)

        if damageType != 'Crush' then
	    CShieldLandUnit.DoTakeDamage(self, instigator, amount, vector, damageType)
        end

    end,


    Crush = function(self)
        while not self:IsDead() do
		if blnCrusherActive == true then
	       	 	local x, y, z = unpack(self:GetPosition())

			DamageArea(self, {x,y,z}, 2, 800, 'Crush', true, true)
		end

            WaitSeconds(1)
        end
    end,
}

TypeClass = GGA0002


