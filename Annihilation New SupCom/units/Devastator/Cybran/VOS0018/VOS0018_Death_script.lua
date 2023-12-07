#****************************************************************************
#**
#**  File     :  VOS0018_script.lua
#**  Author(s):  Resin_Smoker
#**
#**  Summary  :  URL0403 Ammo Cook off script
#**
#**  Copyright © 2008
#****************************************************************************

local NullShell = import('/lua/sim/defaultprojectiles.lua').NullShell
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Util = import('/lua/utilities.lua')
local RandomFloat = Util.GetRandomFloat
local CIFArtilleryWeapon = import('/lua/cybranweapons.lua').CIFArtilleryWeapon

VOS0018_Death = Class(NullShell) {

    OnCreate = function(self)
        NullShell.OnCreate(self)
        local myBlueprint = self:GetBlueprint()
		
        # Create thread that spawns and controls effects
        self:ForkThread(self.EffectThread)
    end,
     
    PassDamageData = function(self, damageData)
        NullShell.PassDamageData(self, damageData)
        local instigator = self:GetLauncher()
        if instigator == nil then
            instigator = self
        end

        # Do Damage
        self:DoDamage( instigator, self.DamageData, nil )  
    end,
    
    OnImpact = function(self, targetType, targetEntity)
        self:Destroy()
    end,

    EffectThread = function(self)
        local FxFragEffect = EffectTemplate.TFragmentationSensorShellFrag 
        local ChildProjectileBP = '/projectiles/TIFAntiMatterShells01/TIFAntiMatterShells01_proj.bp'  
              
        
        # Split effects
        for k, v in FxFragEffect do
            CreateEmitterAtEntity( self, self:GetArmy(), v )
        end
        
        local vx, vy, vz = self:GetVelocity()
        local velocity = Random(40,60)
    	
	# Create several other projectiles in a dispersal pattern
        local numProjectiles = Random(6,12)
        local angle = (2*math.pi) / numProjectiles
        local angleInitial = RandomFloat( 0, angle )
        
        # Randomization of the spread
        local angleVariation = angle * Random(0.6,0.9) # Adjusts angle variance spread
        local spreadMul = Random(0.6,0.9) # Adjusts the width of the dispersal        
        
        local xVec = 0 
        local yVec = vy
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
        self:Destroy()
    end, 
}

TypeClass = VOS0018_Death

