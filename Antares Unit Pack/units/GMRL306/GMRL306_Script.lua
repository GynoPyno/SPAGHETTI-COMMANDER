local CLandUnit = import('/lua/cybranunits.lua').CLandUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CDFParticleCannonWeapon = import('/lua/cybranweapons.lua').CDFParticleCannonWeapon
local CDFElectronBolterWeapon = CybranWeaponsFile.CDFElectronBolterWeapon

local explosion = import('/lua/defaultexplosions.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone
local utilities = import('/lua/Utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

GMRL306 = Class(CLandUnit) {
   Weapons = {
    DeathEyes = Class(CDFParticleCannonWeapon) {},
       RightReactonCannon = Class(CDFElectronBolterWeapon) {},
       LeftReactonCannon = Class(CDFElectronBolterWeapon) {},
   },

DestructionEffectBones = {
       'URL0302','Torso','TurretRight','TurretLeft','ArmBase','Head','Arm1','Arm2','BarrelRight1','BarrelRight2','BarrelLeft1','BarrelLeft2',
   },    
       
   OnCreate = function(self,builder,layer)
       CLandUnit.OnCreate(self)
       # Creating Global Variables
       Army = self:GetArmy()
   end,  

   OnKilled = function(self, instigator, type, overkillRatio)
       local wep = self:GetWeaponByLabel('DeathEyes')
       for k, v in wep.Beams do
           v.Beam:Disable()
       end
       CLandUnit.OnKilled(self, instigator, type, overkillRatio)
   end,        

   CreateExplosionDebris = function( self, bone, Army )
       for k, v in EffectTemplate.ExplosionEffectsSml01 do
           CreateAttachedEmitter( self, bone, Army, v ):ScaleEmitter(1.5)
       end
   end,  
 
   CreateDamageEffects = function(self, bone, Army )
       for k, v in EffectTemplate.TNapalmCarpetBombHitLand01 do  
           CreateAttachedEmitter( self, bone, Army, v ):ScaleEmitter(1)
       end
   end,    
   
   CreateFirePlumesCybrans = function( self, Army, bones, yBoneOffset )
       local proj, position, offset, velocity
       local basePosition = self:GetPosition()
       for k, vBone in bones do
           position = self:GetPosition(vBone)
           offset = utilities.GetDifferenceVector( position, basePosition )
           velocity = utilities.GetDirectionVector( position, basePosition )
           velocity.x = velocity.x + utilities.GetRandomFloat(-1.15, 1.15)
           velocity.z = velocity.z + utilities.GetRandomFloat(-1.15, 1.15)
           velocity.y = velocity.y + utilities.GetRandomFloat( -1.15, 1.15)
           proj = self:CreateProjectile('/effects/entities/DestructionFirePlume01/DestructionFirePlume01_proj.bp', offset.x, offset.y + yBoneOffset, offset.z, velocity.x, velocity.y, velocity.z)
           proj:SetBallisticAcceleration(utilities.GetRandomFloat(-1, 1)):SetVelocity(utilities.GetRandomFloat(1, 2)):SetCollision(false)          
           local emitter = CreateEmitterOnEntity(proj, Army,  '/effects/emitters/destruction_explosion_fire_plume_02_emit.bp')
           local lifetime = utilities.GetRandomFloat( 5, 25 )
       end
   end,

   InitialRandomExplosionsCybrans = function(self)
       local position = self:GetPosition()
       local numExplosions =  math.floor( table.getn( self.DestructionEffectBones ) * 0.5 )
       CreateAttachedEmitter(self, 0, self:GetArmy(), '/effects/emitters/nuke_concussion_ring_01_emit.bp'):ScaleEmitter(0.175)
       CreateLightParticle( self, -1, -1, 24, 62, 'flare_lens_add_02', 'ramp_red_10' )
       # Create small explosions all over
       for i = 0, numExplosions do
           local ranBone = utilities.GetRandomInt( 1, numExplosions )
           local duration = utilities.GetRandomFloat( 0.2, 0.5 )
           self:PlayUnitSound('Destroyed')
           self:CreateFirePlumesCybrans( Army, {ranBone}, Random(0,2) )
           self:CreateDamageEffects( ranBone, Army )
           self:CreateExplosionDebris( Army )
           self:ShakeCamera(2, 0.5, 0.25, duration)
           WaitSeconds( duration )
           self:CreateFirePlumesCybrans( Army, {ranBone}, Random(0,2) )
       end
       explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})
       CreateLightParticle( self, -1, -1, 24, 62, 'flare_lens_add_02', 'ramp_red_10' )
       CreateDeathExplosion( self, 'URL0302', Random(1,5))
       self:CreateDamageEffects( 'URL0302', Army )
       WaitSeconds( 1 )
       self:CreateDamageEffects( 'Torso', Army )
   end,    
   
   DeathThread = function( self, overkillRatio , instigator)
       # Create Initial explosion effects
       explosion.CreateScorchMarkSplat( self, 1.6, Army )
       explosion.CreateScorchMarkDecal( self, 1.6, Army )
       self:InitialRandomExplosionsCybrans()  
       if self.DeathAnimManip then
           WaitFor(self.DeathAnimManip)
       end
       WaitSeconds(1.5)
       self:DestroyAllDamageEffects()
       self:CreateWreckage( 1 )

       #Starts the corpse effects
       self:PlayUnitSound('Destroyed')
       self:Destroy()
   end,        
}

TypeClass = GMRL306
