#****************************************************************************
#**
#**  File     :  /data/projectiles/TDFFragmentationGrenade01/TDFFragmentationGrenade01_script.lua
#**  Author(s):  Matt Vainio
#**
#**  Summary  :  UEF Fragmentation Shells, DEL0204
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TFragmentationGrenadeMK = import('/Mods/#Marlos mods compilation/lua/MKProjectiles.lua').TFragmentationGrenadeMK
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TNapalmHvyCarpetBombProjectile = import('/lua/terranprojectiles.lua').TNapalmHvyCarpetBombProjectile
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

TDFFragmentationGrenade01 = Class(TFragmentationGrenadeMK) {

    FxAirUnitHitScale = 2,
    FxLandHitScale = 2,
    FxNoneHitScale = 2,
    FxPropHitScale = 2,
    FxProjectileHitScale = 2,
    FxProjectileUnderWaterHitScale = 2,
    FxShieldHitScale = 2,
    FxUnderWaterHitScale = 2,
    FxUnitHitScale = 2,
    FxWaterHitScale = 2,
    FxOnKilledScale = 2,

    OnImpact = function(self, TargetType, targetEntity)
        local ChildProjectileBP = '/projectiles/TIFNapalmCarpetBomb02/TIFNapalmCarpetBomb02_proj.bp'  
        
        local vx, vy, vz = self:GetVelocity()
        local velocity = 1
		
        self:CreateChildProjectile(ChildProjectileBP):SetVelocity(vx, vy, vz):SetVelocity(velocity):PassDamageData(self.DamageData)
		
		if TargetType != 'Water' then 
			local rotation = RandomFloat(0,2*math.pi)
			local size = RandomFloat(3.75,5.0)
	        
			CreateDecal(self:GetPosition(), rotation, 'scorch_001_albedo', '', 'Albedo', size, size, 150, 15, self:GetArmy())
		end	 
		TFragmentationGrenadeMK.OnImpact( self, TargetType, targetEntity )
    end,	
	
}

TypeClass = TDFFragmentationGrenade01