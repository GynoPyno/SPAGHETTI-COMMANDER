#****************************************************************************
#**
#**  File     :  VOS0018_script.lua
#**  Author(s):  Resin_Smoker & Optimus_Prime
#**
#**  Summary  :  Cybran Vulcanizer Artillery Script
#**
#**  Copyright © 2009 4th Dimension
#****************************************************************************

### Misc Lua called ###
local CLandUnit = import('/lua/cybranunits.lua').CLandUnit
local utilities = import('/lua/utilities.lua')
local RandomFloat = utilities.GetRandomFloat
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtils = import('/lua/effectutilities.lua')
local explosion = import('/lua/defaultexplosions.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone

### Weapon Local lua called ###
local CIFArtilleryWeapon = import('/lua/cybranweapons.lua').CIFArtilleryWeapon
local DefaultProjectileWeapon = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

### Weapon bones for recoil effects 
local muzzleBones = { 'Muzzle1', 'Muzzle2', 'Muzzle3', 'Muzzle4' } 
local recoilgroup1 = { 'Barrel11', 'Barrel12', 'Barrel13', 'Barrel14' } 
local recoilgroup2 = { 'Barrel21', 'Barrel22', 'Barrel23', 'Barrel24' } 

VOS0018 = Class(CLandUnit) {    
    Weapons = { 
          QuadCannon = Class(CIFArtilleryWeapon) { 
            FxMuzzleFlashScale = 0.5,
            FxMuzzleFlash = { 
            	'/effects/emitters/proton_artillery_muzzle_01_emit.bp',
            	'/effects/emitters/proton_artillery_muzzle_03_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_smoke_01_emit.bp',                                
            }, 
            FxScale = 0.75,
            FxGroundEffect = EffectTemplate.CDisruptorGroundEffect,
	        FxVentEffect = EffectTemplate.CDisruptorVentEffect,
	        FxMuzzleEffect = EffectTemplate.CElectronBolterMuzzleFlash01,
	        FxCoolDownEffect = EffectTemplate.CDisruptorCoolDownEffect,                       
            
            OnCreate = function(self) 
                CIFArtilleryWeapon.OnCreate(self) 
                ### Sets the first barrel in the firing sequence 
                self.CurrentBarrel = 1 
                self.CurrentGoal = 90                              
            end, 
            
	        PlayFxMuzzleSequence = function(self, muzzle)
		        local army = self.unit:GetArmy()
		        
	            for k, v in self.FxGroundEffect do
                    CreateAttachedEmitter(self.unit, 'url0403', army, v)
                end
  	            for k, v in self.FxVentEffect do
                    CreateAttachedEmitter(self.unit, recoilgroup1[self.CurrentBarrel], army, v):ScaleEmitter(0.25)
                end
  	            for k, v in self.FxMuzzleEffect do
                    CreateAttachedEmitter(self.unit, muzzleBones[self.CurrentBarrel], army, v):ScaleEmitter(0.25)
                end
                DefaultProjectileWeapon.PlayFxMuzzleSequence(self, muzzle)
  	            for k, v in self.FxCoolDownEffect do
                    CreateAttachedEmitter(self.unit, recoilgroup2[self.CurrentBarrel], army, v):ScaleEmitter(0.25)
                end 
                
            end,                      
                    
            CreateProjectileAtMuzzle = function(self, muzzle)                                        
                ### Updates firing Randomness but only if RapidFiringState is false 
                self.unit.CurrentAccuracy = self.unit.MyWeapon:GetFiringRandomness() 
                if self.unit.RapidFiringState == false and self.unit.CurrentAccuracy >= 0.25 then 
                    self.unit.MyWeapon:SetFiringRandomness(self.unit.CurrentAccuracy - 0.125) 
                end 

                ### Resets weapon acuracy if the target has changed 
                if not self.unit:IsDead() and self.unit.MyWeapon:GetCurrentTarget() and self.unit.RapidFiringState == false then 
                    self.unit.CurrentTarget = self.unit.MyWeapon:GetCurrentTarget():GetEntityId() 
                    if self.unit.OldTarget == nil then 
                        ### Inputs new target values into table 
                        self.unit.OldTarget = self.unit.CurrentTarget 
                    elseif self.unit.OldTarget ~= self.unit.CurrentTarget then 
                        self.unit.MyWeapon:SetFiringRandomness(self.unit.MyWeapon:GetBlueprint().FiringRandomness) 
                        ### Inputs new target values into table 
                        self.unit.OldTarget = self.unit.CurrentTarget 
                    end 
                end
                CIFArtilleryWeapon.CreateProjectileAtMuzzle(self, muzzle) 
            end, 
                      
            PlayRackRecoil = function(self, rackList) 
                ### Reset the recoil table 
                local recoilTbl = {} 

                ### Select the barrel to recoil 
                recoilTbl.MuzzleBones = muzzleBones[self.CurrentBarrel]                
                recoilTbl.RackBone = recoilgroup1[self.CurrentBarrel] 
                recoilTbl.TelescopeBone = recoilgroup2[self.CurrentBarrel]              
                table.insert( rackList, recoilTbl ) 
                
                ### Perform the recoil effects 
                CIFArtilleryWeapon.PlayRackRecoil(self, rackList)
                
                if not self.SpinManip then 
                    ### Create the cannon rotator
                    self.SpinManip = CreateRotator(self.unit, 'Rotator', 'z', self.CurrentGoal, 200, 200, 200) 
                    self.unit.Trash:Add(self.SpinManip)
                else
                    ### Spin to the next barrel 
                    self.SpinManip:SetGoal(self.CurrentGoal) 
                    self.SpinManip:SetAccel(200) 
                    self.SpinManip:SetTargetSpeed(200)                 
                end              

                ### Increment to the next barrel and goal 
                self.CurrentBarrel = self.CurrentBarrel + 1
                self.CurrentGoal = self.CurrentGoal + 90 
                if self.CurrentBarrel > 4 then 
                    self.CurrentBarrel = 1
                    self.CurrentGoal = 90  
                end               
            end,            

            OnLostTarget = function(self) 
                ### Resets weapon acuracy if target is lost 
                if not self.unit:IsDead() and self.SpinManip then      
                    self.unit.MyWeapon:SetFiringRandomness(self.unit.MyWeapon:GetBlueprint().FiringRandomness)
                    for k, v in muzzleBones do 
                        self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, v, self.unit:GetArmy(), EffectTemplate.WeaponSteam01 )
                    end                     
                end 
                CIFArtilleryWeapon.OnLostTarget(self) 
            end,
            
            PlayFxWeaponPackSequence = function(self) 
                if self.SpinManip then 
                    self.SpinManip:SetTargetSpeed(0)
                    for k, v in muzzleBones do 
                        self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, v, self.unit:GetArmy(), EffectTemplate.WeaponSteam01 ) 
                    end
                end 
                CIFArtilleryWeapon.PlayFxWeaponPackSequence(self) 
            end,             
        }, 
    },

    OnStopBeingBuilt = function(self,builder,layer)
        CLandUnit.OnStopBeingBuilt(self, builder, layer)
        ### Global variable setup
        self.MyWeapon = self:GetWeaponByLabel('QuadCannon')
        self.CurrentAccuracy = nil
        self.CurrentTarget = nil
        self.OldTarget = nil
        self.RapidFiringState = true
        self.Moving = false  
        self.TurretTable = {}

        ### Removes unused bones after the unit has been built
--        self:HideBone('PlasmaTurret', true)

        ### Calls the needed threads
--        self:ForkThread(self.SecondaryTurretSpawn)
        self:ForkThread(self.HeartBeatChecks)
    end,

    OnScriptBitSet = function(self, bit)
        ### Selected the LOW rate of fire and HIGH accuracy
        CLandUnit.OnScriptBitSet(self, bit)
        if bit == 1 then 
            self.RapidFiringState = false
            self.MyWeapon:SetFiringRandomness(self.MyWeapon:GetBlueprint().FiringRandomness)
            self.MyWeapon:ChangeRateOfFire(self.MyWeapon:GetBlueprint().RateOfFire * 0.25) 
        end
    end,

    OnScriptBitClear = function(self, bit)
        ### Selectes the HIGH rate of fire and LOW accuracy
        CLandUnit.OnScriptBitClear(self, bit)
        if bit == 1 then
            self.RapidFiringState = true 
            self.MyWeapon:SetFiringRandomness(self.MyWeapon:GetBlueprint().FiringRandomness)
            self.MyWeapon:ChangeRateOfFire(self.MyWeapon:GetBlueprint().RateOfFire) 
        end
    end,

    HeartBeatChecks = function(self)
        while self and not self:IsDead() do
            WaitSeconds(1)
            ### Checks to see if the Vulcanizer is moving
            if not self:IsDead() and self.Moving == true then 
                self.VulcPos = self:GetPosition()
                local radius = 5 
                ### Apply damage to the area under it if there is an enemy unit within the set radius  
                local targetlist = utilities.GetEnemyUnitsInSphere(self, self.VulcPos, radius)
                if table.getsize (targetlist) > 0 then
                    ### Apply damage
                    DamageRing(self, self.VulcPos, 0.1, 5, 10000, 'Normal', false)
                end
            end
        end
    end,

    OnMotionHorzEventChange = function(self, new, old)
        ### Updates the gloabal variable for when the Vulcanizers movement changes and 
        ### alters the accuracy of the secondary turret for when the Vulcanizer is moving
        if not self:IsDead() and new == 'Stopped' then
            self.Moving = false
--            self.TurretTable[1]:NotifyOfTurretStopped(self)
        elseif not self:IsDead() then
            self.Moving = true
--            self.TurretTable[1]:NotifyOfTurretMoving(self)
        end              
        CLandUnit.OnMotionHorzEventChange(self, new, old)
    end,

    DestructionEffectBones = {
        'PlasmaTurret','Turret','PlasmaTurretSleeve',
        'PlasmaTurretBarrel1','PlasmaTurretSleeve01', 
        'Rotator','PlasmaTurretBarrel2','Sleeve',
        'barrel11','barrel12','barrel13','barrel14',
        'barrel21','barrel22','barrel23','barrel24',
        'barrel31','barrel32','barrel33','barrel34',
    },

    OnKilled = function(self, instigator, type, overkillRatio)
--        ### Kills off the secondary turret
--        self.TurretTable[1]:DestroySecondaryTurret(self) 

        ### Unhides the prop weapon to provide a corpse for the secondary turret
        self:ShowBone('PlasmaTurret', true)

        ### Removes autocannon barrel spin effects
        if self.SpinManip then 
            self.unit.Trash:Add(self.SpinManip)
        end   
        CLandUnit.OnKilled(self, instigator, type, overkillRatio)
    end,

    CreateDamageEffects = function(self, bone, Army )
        for k, v in EffectTemplate.CEMPGrenadeHit01 do   
            CreateAttachedEmitter( self, bone, Army, v ):ScaleEmitter(1.0)
        end
    end,

    CreateExplosionDebris = function( self, bone, Army )
        for k, v in EffectTemplate.ExplosionEffectsSml01 do
            CreateAttachedEmitter( self, bone, Army, v ):ScaleEmitter(1.5)
        end
    end,
    
    CreateAmmoCookOff = function( self, Army, bones, yBoneOffset )
        local basePosition = self:GetPosition()
        for k, vBone in bones do
        
            ### Calculate the velocity of the effects
            local position = self:GetPosition(vBone)
            local offset = utilities.GetDifferenceVector( position, basePosition )
            velocity = utilities.GetDirectionVector( position, basePosition ) 
            velocity.x = velocity.x + utilities.GetRandomFloat(-0.3, 0.3)
            velocity.z = velocity.z + utilities.GetRandomFloat(-0.3, 0.3)
            velocity.y = velocity.y + utilities.GetRandomFloat( 0.25, 0.5)

            ### Ammo Cookoff projectiles and damage
            self.DamageData = {
                BallisticArc = 'RULEUBA_HighArc',
                UseGravity = true, 
                CollideFriendly = true, 
                DamageAmount = 1500, 
                DamageFriendly = true, 
                DamageRadius = 3, 
                DamageType = 'Normal',
                } 
            ammocookoff = self:CreateProjectile('/projectiles/CIFArtilleryProton01/CIFArtilleryProton01_proj.bp', offset.x, offset.y + yBoneOffset, offset.z, velocity.x, velocity.y, velocity.z)
            ammocookoff:SetVelocity(Random(5,20))  
            ammocookoff:SetLifetime(30) 
            ammocookoff:PassDamageData(self.DamageData)
            self.Trash:Add(ammocookoff)
            
            ### Fire plume effects            
            local proj = self:CreateProjectile('/effects/entities/DestructionFirePlume01/DestructionFirePlume01_proj.bp', offset.x, offset.y + yBoneOffset, offset.z, velocity.x, velocity.y, velocity.z)
            proj:SetBallisticAcceleration(utilities.GetRandomFloat(-1, 1)):SetVelocity(utilities.GetRandomFloat(1, 2)):SetCollision(false)
            local emitter = CreateEmitterOnEntity(proj, Army, '/effects/emitters/destruction_explosion_fire_plume_01_emit.bp')
            #local lifetime = utilities.GetRandomFloat( 10, 30 )            
        end
    end,

    InitialRandomExplosionsCybrans = function(self)
        local position = self:GetPosition()
        local numExplosions = table.getn( self.DestructionEffectBones )
        ### Create small explosions effects all over
        for i = 0, numExplosions do
            local ranBone = utilities.GetRandomInt( 1, numExplosions )
            local duration = utilities.GetRandomFloat( 0.5, 0.75 )
            self:PlayUnitSound('AmmoCookOff')
            self:ShakeCamera(4, 0.5, 0.25, duration)
            self:CreateDamageEffects( ranBone, self:GetArmy() )
            self:CreateExplosionDebris( ranBone, self:GetArmy() )
            self:CreateAmmoCookOff( self:GetArmy(), {ranBone}, Random(0,2) )
            WaitSeconds( duration )
        end

    end,

    DeathThread = function( self, overkillRatio , instigator)
        ### Create explosion effects
        self:InitialRandomExplosionsCybrans() 
        WaitSeconds(1)  
        explosion.CreateDefaultHitExplosionAtBone( self, 'Turret', 10.0 )
        self:PlayUnitSound('Destroyed')
        self:ShakeCamera(8, 1.5, 0.75, 3)
        CreateAttachedEmitter(self, 0, self:GetArmy(), '/effects/emitters/nuke_concussion_ring_01_emit.bp'):ScaleEmitter(0.175)
        CreateAttachedEmitter(self, 1, self:GetArmy(), '/effects/emitters/shockwave_smoke_01_emit.bp' )

        ### Starts the corpse effects
        if( self.ShowUnitDestructionDebris and overkillRatio ) then
           if overkillRatio <= 1 then
               self.CreateUnitDestructionDebris( self, true, true, false )
           elseif overkillRatio <= 2 then
               self.CreateUnitDestructionDebris( self, true, true, false )
           elseif overkillRatio <= 3 then
               self.CreateUnitDestructionDebris( self, true, true, true )
           else #VAPORIZED
               self.CreateUnitDestructionDebris( self, true, true, true )
           end
        end
        WaitSeconds(1.5)
        self:CreateWreckage(0.1)   
--        CLandUnit.DeathThread( self, overkillRatio , instigator)
        self:Destroy()
    end,
}
TypeClass = VOS0018