local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit

local TWeapons = import('/lua/terranweapons.lua')

local TDFPlasmaCannonWeapon = TWeapons.TDFPlasmaCannonWeapon
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon

local explosion = import('/lua/defaultexplosions.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local utilities = import('/lua/Utilities.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

UEL0302 = Class(TWalkingLandUnit) {
    Weapons = {
    	Riotgun1 = Class(TDFPlasmaCannonWeapon) {
    	            PlayFxWeaponUnpackSequence = function(self)
                    if not self.SpinManip then 
                        self.SpinManip = CreateRotator(self.unit, 'RailGunBarrelRight', 'z', nil, 270, 180, 60)
                        self.unit.Trash:Add(self.SpinManip)
                    end
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(1470)
                    end
                    TDFPlasmaCannonWeapon.PlayFxWeaponPackSequence(self)
            end,

                PlayFxWeaponPackSequence = function(self)
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(0)
                    end
                    TDFPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
        },
        Riotgun2 = Class(TDFPlasmaCannonWeapon) {
                    PlayFxWeaponUnpackSequence = function(self)
                    if not self.SpinManip then 
                        self.SpinManip = CreateRotator(self.unit, 'RailGunBarrelLeft', 'z', nil, 270, 180, 60)
                        self.unit.Trash:Add(self.SpinManip)
                    end
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(1470)
                    end
                    TDFPlasmaCannonWeapon.PlayFxWeaponPackSequence(self)
            end,

                PlayFxWeaponPackSequence = function(self)
                    if self.SpinManip then
                        self.SpinManip:SetTargetSpeed(0)
                    end
                    TDFPlasmaCannonWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
        },
        MainGun = Class(TDFGaussCannonWeapon) {},
    },
    
	DestructionEffectBones = {
        'UEL0302','UpperlegRightFront','UpperLegRightBack','UpperLegLeftBack','UpperLegLeftFront','RailGunTurret','Turret','RailGunSleeve','LegFront','LegLeftBack','LegRightBack','LegRightFront',
    },       
    OnCreate = function(self,builder,layer)
		TWalkingLandUnit.OnCreate(self)
        # Creating Global Variables
        Army = self:GetArmy()
    end,           

    CreateExplosionDebris = function( self, bone, Army )
        for k, v in EffectTemplate.ExplosionEffectsSml01 do
            CreateAttachedEmitter( self, bone, Army, v ):ScaleEmitter(1.5)
        end
    end,    
    CreateDamageEffects = function(self, bone, Army )
        for k, v in EffectTemplate.TNapalmCarpetBombHitLand01 do   
            CreateAttachedEmitter( self, bone, Army, v ):ScaleEmitter(0.9)
        end
    end,    
    
	CreateFirePlumesUEF = function( self, Army, bones, yBoneOffset )
        local proj, position, offset, velocity
        local basePosition = self:GetPosition()
        for k, vBone in bones do
            position = self:GetPosition(vBone)
            offset = utilities.GetDifferenceVector( position, basePosition )
            velocity = utilities.GetDirectionVector( position, basePosition ) 
            velocity.x = velocity.x + utilities.GetRandomFloat(-0.55, 0.55)
            velocity.z = velocity.z + utilities.GetRandomFloat(-0.55, 0.55)
            velocity.y = velocity.y + utilities.GetRandomFloat( -0.55, 0.55)
            proj = self:CreateProjectile('/effects/entities/DestructionFirePlume01/DestructionFirePlume01_proj.bp', offset.x, offset.y + yBoneOffset, offset.z, velocity.x, velocity.y, velocity.z)
            proj:SetBallisticAcceleration(utilities.GetRandomFloat(-1, 1)):SetVelocity(utilities.GetRandomFloat(1, 2)):SetCollision(false)           
            local emitter = CreateEmitterOnEntity(proj, Army,  '/effects/emitters/destruction_explosion_fire_plume_01_emit.bp')
            local lifetime = utilities.GetRandomFloat( 5, 25 )
        end
    end,

	InitialRandomExplosionsUEF = function(self)
        local position = self:GetPosition()
        local numExplosions =  math.floor( table.getn( self.DestructionEffectBones ) * 0.5 )
		CreateAttachedEmitter(self, 0, self:GetArmy(), '/effects/emitters/nuke_concussion_ring_01_emit.bp'):ScaleEmitter(0.175)
        # Create small explosions all over        
        for i = 0, numExplosions do
            local ranBone = utilities.GetRandomInt( 1, numExplosions )
            local duration = utilities.GetRandomFloat( 0.2, 0.5 )
            self:PlayUnitSound('Destroyed')

            self:CreateFirePlumesUEF( Army, {ranBone}, Random(0,2) )
            self:CreateDamageEffects( ranBone, Army )
            self:CreateExplosionDebris( Army )
            self:ShakeCamera(2, 0.5, 0.25, duration)
            WaitSeconds( duration )
            self:CreateFirePlumesUEF( Army, {ranBone}, Random(0,2) )
        end
        explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})
        CreateDeathExplosion( self, 'UEL0302', Random(1,5))
        self:CreateDamageEffects( 'UEL0302', Army )
        WaitSeconds( 0.5 )
        self:CreateDamageEffects( 'UpperlegRightFront', Army )
        WaitSeconds( 0.5 )
 		for i = 0, numExplosions do
            local ranBone = utilities.GetRandomInt( 1, numExplosions )
            local duration = utilities.GetRandomFloat( 0.2, 0.5 )
            self:PlayUnitSound('Destroyed')

            self:CreateFirePlumesUEF( Army, {ranBone}, Random(0,2) )
            WaitSeconds( duration )
        end        
        self:CreateDamageEffects( 'LegLeftBack', Army )
        WaitSeconds( 0.5 )
        self:CreateDamageEffects( 'LegRightBack', Army )
    end,    
    
    DeathThread = function( self, overkillRatio , instigator)
        # Create Initial explosion effects
        explosion.CreateScorchMarkSplat( self, 1.6, Army )
		explosion.CreateScorchMarkDecal( self, 1.6, Army )        
        
        self:InitialRandomExplosionsUEF() 
		if Random(1,10) > 5 then
       	explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})
       	end
        self:CreateDamageEffects( 'UEL0302', Army )  
        self:PlayUnitSound('Destroyed')

        if self.DeathAnimManip then
            WaitFor(self.DeathAnimManip)
        end
       	WaitSeconds(1.5)

       	self:CreateDamageEffects( 'UEL0302', Army ) 
        self:DestroyAllDamageEffects()
        self:CreateWreckage( 1 )
		
        #Starts the corpse effects
        self:PlayUnitSound('Destroyed')
        self:Destroy()
    end,            
    
}
TypeClass = UEL0302