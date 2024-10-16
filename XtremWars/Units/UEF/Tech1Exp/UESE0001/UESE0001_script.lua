#****************************************************************************
#**
#**  File     :  /Mods/units/UESE0001/UESE0001_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix  
#**					Modified By Asdrubaelvect
#**  Summary  :  FTU tech 1 spaceships experimental
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TAALinkedRailgun = import('/lua/terranweapons.lua').TAALinkedRailgun
local TWeapons = import('/lua/terranweapons.lua')
local TDFHeavyPlasmaCannonWeapon = TWeapons.TDFHeavyPlasmaCannonWeapon
local fxutil = import('/lua/effectutilities.lua')

UESE0001 = Class(TAirUnit) {
    Weapons = {
        AAGun = Class(TAALinkedRailgun) {},
		Plasma01 = Class(TDFHeavyPlasmaCannonWeapon) {},
    },
	
    MovementAmbientExhaustBones = {
		'Reacteur02',
		'Reacteur04',		
    },


    OnMotionHorzEventChange = function(self, new, old )
		TAirUnit.OnMotionHorzEventChange(self, new, old)
	
		if self.ThrustExhaustTT1 == nil then 
			if self.MovementAmbientExhaustEffectsBag then
				fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
			else
				self.MovementAmbientExhaustEffectsBag = {}
			end
			self.ThrustExhaustTT1 = self:ForkThread(self.MovementAmbientExhaustThread)
		end
		
        if new == 'Stopped' and self.ThrustExhaustTT1 != nil then
			KillThread(self.ThrustExhaustTT1)
			fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
			self.ThrustExhaustTT1 = nil
        end		 
    end,
    
    MovementAmbientExhaustThread = function(self)
		while not self.Dead do
			local ExhaustEffects = {
				'/effects/emitters/nuke_munition_launch_trail_02_emit.bp',
				--'/effects/emitters/nuke_munition_launch_trail_02_emit.bp',	
			}
			local ExhaustBeam = '/Mods/XtremWars/effects/emitters/missile_exhaust_fire_beam_12_emit.bp'
			local army = self:GetArmy()			
			
			for kE, vE in ExhaustEffects do
				for kB, vB in self.MovementAmbientExhaustBones do
					table.insert( self.MovementAmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE ))
					table.insert( self.MovementAmbientExhaustEffectsBag, CreateBeamEmitterOnEntity( self, vB, army, ExhaustBeam ))
				end
			end
			
			WaitSeconds(0)
			fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
							
		end	
    end,		
	
		
	
	
}

TypeClass = UESE0001
