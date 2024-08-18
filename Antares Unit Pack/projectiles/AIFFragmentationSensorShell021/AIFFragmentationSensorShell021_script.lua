local EffectTemplate = import('/lua/EffectTemplates.lua')
local AArtilleryFragmentationSensorShellProjectile = import('/lua/aeonprojectiles.lua').AArtilleryFragmentationSensorShellProjectile02
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

AIFFragmentationSensorShell021 = Class(AArtilleryFragmentationSensorShellProjectile) {
               
    OnImpact = function(self, TargetType, TargetEntity) 
        if TargetType != 'Shield' then
	        local FxFragEffect = EffectTemplate.Aeon_QuanticClusterFrag02 
	        local ChildProjectileBP = '/mods/Antares Unit Pack/projectiles/AIFFragmentationSensorShell031/AIFFragmentationSensorShell031_proj.bp'  
	        
	        # Split effects
	        for k, v in FxFragEffect do
	            CreateEmitterAtBone( self, -1, self:GetArmy(), v )
	        end
	        
	        local vx, vy, vz = self:GetVelocity()
	        local velocity = 12
	    
			# One initial projectile following same directional path as the original
	        self:CreateChildProjectile(ChildProjectileBP):SetVelocity(vx, 0.8*vy, vz):SetVelocity(velocity):PassDamageData(self.DamageData)
	   		
			# Create several other projectiles in a dispersal pattern
			        local numProjectiles = 15
			        local angle = (2*math.pi) / numProjectiles
			        local angleInitial = RandomFloat( 0, angle )
			        
			        # Randomization of the spread
			        local angleVariation = angle * 13 # Adjusts angle variance spread
			        local spreadMul = 1.2 # Adjusts the width of the dispersal        
			               
	        local xVec = 0 
	        local yVec = vy*0.8
	        local zVec = 0
	
	        # Launch projectiles at semi-random angles away from split location
	        for i = 0, (numProjectiles -1) do
	            xVec = vx + (math.sin(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))) * spreadMul
	            zVec = vz + (math.cos(angleInitial + (i*angle) + RandomFloat(-angleVariation, angleVariation))) * spreadMul 
	            local proj = self:CreateChildProjectile(ChildProjectileBP)
	            proj:SetVelocity(xVec,yVec,zVec)
	            proj:SetVelocity(velocity)
	            proj:PassDamageData(self.DamageData)                        
	        end
	        local pos = self:GetPosition()
	        local spec = {
	            X = pos[1],
	            Z = pos[3],
	            Radius = self.Data.Radius,
	            LifeTime = self.Data.Lifetime,
	            Army = self.Data.Army,
	            Omni = false,
	            WaterVision = false,
	        }
	        self:Destroy()
		else
	        self:DoDamage( self, self.DamageData, TargetEntity)
	        self:OnImpactDestroy(TargetType, TargetEntity)
        end
    end,
}
TypeClass = AIFFragmentationSensorShell021