#****************************************************************************
#**
#**  File     :  URA0305_script.lua
#**  Author   :  Resin_Smoker, Optimus Prime
#**  
#**  Summary  :  Cybran Retribution, Airborne Drone Carrier
#**
#**  Special Thanks to :  ChirmayaWrongEmail, Eni, Neruz, Goom, Gilbot-X
#**  Copyright � 2008
#****************************************************************************
#### Localy imported files ####
local Unit = import('/lua/sim/Unit.lua').Unit
#### Thrust effect locals called
local EffectUtil = import('/lua/EffectUtilities.lua')
#### Death effects locals called
local utilities = import('/lua/utilities.lua')
local RandomFloat = utilities.GetRandomFloat
local explosion = import('/lua/defaultexplosions.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local CreateDeathExplosion = explosion.CreateDefaultHitExplosionAtBone

#### Weapon local files ####
local CollisionBeamFile = import('/mods/Antares Unit Pack/hook/lua/ura0305_defaultcollisionbeams.lua')
local DefaultBeamWeapon = import('/lua/sim/defaultweapons.lua').DefaultBeamWeapon
LaserBeamWeapon = Class(DefaultBeamWeapon) {
    BeamType = CollisionBeamFile.RetributionGreenLaserCollisionBeam,
    FxMuzzleFlash = {},
}
local CDFProtonCannonWeapon = import('/lua/cybranweapons.lua').CDFProtonCannonWeapon
local CAAMissileNaniteWeapon = import('/lua/cybranweapons.lua').CAAMissileNaniteWeapon
local AIFBombQuarkWeapon = import('/lua/aeonweapons.lua').AIFBombQuarkWeapon

URA0305 = Class(Unit) {

    Weapons = {
        GreenLaser = Class(LaserBeamWeapon) {},
        FrontCannon = Class(CDFProtonCannonWeapon) {},
        AA_Front_L = Class(CAAMissileNaniteWeapon) {},
        AA_Front_R = Class(CAAMissileNaniteWeapon) {},
        AA_Rear_L = Class(CAAMissileNaniteWeapon) {},
        AA_Rear_R = Class(CAAMissileNaniteWeapon) {},
        #Flare_Left = Class(AIFBombQuarkWeapon) {},
        #Flare_Right = Class(AIFBombQuarkWeapon) {},
    },

    ExhaustBones = {
                    'engine_center01','engine_center02','engine_center03','engine_center04','engine_center05','engine_center06',
                    'engine_left01','engine_left02','engine_left03','engine_left04','engine_left05','engine_left06',
                    'engine_right01','engine_right02','engine_right03','engine_right04','engine_right05','engine_right06',
                   },

    BeamExhaustCruise = '/effects/emitters/gunship_thruster_beam_01_emit.bp',
    BeamExhaustIdle = '/effects/emitters/gunship_thruster_beam_01_emit.bp',

OnStopBeingBuilt = function(self,builder,layer)
    Unit.OnStopBeingBuilt(self,builder,layer)

    ### Initializes Drone spawn sequence and radar jammer energy useage
    self:ForkThread(self.InitialDroneSpawn)
    self:SetMaintenanceConsumptionInactive()
    self:SetScriptBit('RULEUTC_StealthToggle', true)
    self:SetScriptBit('RULEUTC_ProductionToggle', false)
    self:RequestRefreshUI()
    self.UnitComplete = true
    self.Army = self:GetArmy()

    ### Global Varibles###
    self.HitsTaken = 0
    self.DmgTotal = 0
    self.Side = 0
    self.TargetElevation = nil
    self.DroneTable = {}
    self.EffectsBag = {} 

end,

OnIntelEnabled = function(self)
    Unit.OnIntelEnabled(self)
    ### Radar rotation on jammer activation
    if not self:IsDead() and not self.SpinManip then 
        self.SpinManip = CreateRotator(self, 'radar_dish', 'y', nil, 0, 20, 100)
        self.Trash:Add(self.SpinManip)
    end
    if not self:IsDead() and self.SpinManip then
        self.SpinManip:SetTargetSpeed(100)
    end
end,

OnIntelDisabled = function(self)
    Unit.OnIntelDisabled(self)
    ### Radar rotation halt on jammer de-activation
    if not self:IsDead() and self.SpinManip then
        self.SpinManip:SetTargetSpeed(0)
    end
end,

InitialDroneSpawn = function(self)
    ### spawning a number of drones times equal to the number preset by numcreate
    local numcreate = 8

    ### Randomly determines which launch bay will be the first to spawn a drone
    self.Side = Random(1,2) 

    ### Short delay after the carrier has been built
    WaitSeconds(2)

    ### Are we dead yet, if not spawn drones
    if not self:IsDead() then
        for i = 0, (numcreate -1) do
            if not self:IsDead() then 
                self:ForkThread(self.SpawnDrone) 
                ### Short delay between spawns to spread them out
                WaitSeconds(1)
            end
        end
    end
end,

SpawnDrone = function(self)
    ### Small respawn delay so the drones are not instantly respawned after death
    WaitSeconds(1)

    ### Only respawns the drones if the parent unit is not dead
    if not self:IsDead() then 

        ### Sets up local Variables used and spawns a drone at the parents location 
        local myOrientation = self:GetOrientation()
      
        if self.Side == 1 then
            ### Gets the current position of the carrier launch bay in the game world
            local location = self:GetPosition('drone_launch_left')

            ### Creates our drone in the left launch bay and directs the unit to face the same direction as its parent unit
            local drone = CreateUnit('ura0106', self:GetArmy(), location[1], location[2], location[3], myOrientation[1], myOrientation[2], myOrientation[3], myOrientation[4], 'Air') 

            ### Adds the newly created drone to the parent carriers drone table
            table.insert (self.DroneTable, drone)

            ### Sets the Carrier unit as the drones parent
            drone:SetParent(self, 'ura0305')
            drone:SetCreator(self)  

            ### Issues the guard command
            IssueClearCommands({drone})
            IssueGuard({drone}, self)

            ### Flips from the left to the right self.Side after a drone has been spawned
            self.Side = 2

            ###Drone clean up scripts
            self.Trash:Add(drone)

        elseif self.Side == 2 then
            ### Gets the current position of the carrier launch bay in the game world
            local location = self:GetPosition('drone_launch_right')

            ### Creates our drone in the right launch bay and directs the unit to face the same direction as its parent unit
            local drone = CreateUnit('ura0106', self:GetArmy(), location[1], location[2], location[3], myOrientation[1], myOrientation[2], myOrientation[3], myOrientation[4], 'Air') 

            ### Adds the newly created drone to the parent carriers drone table
            table.insert (self.DroneTable, drone)

            ### Sets the Carrier unit as the drones parent
            drone:SetParent(self, 'ura0305')
            drone:SetCreator(self)

            ### Issues the guard command
            IssueClearCommands({drone})
            IssueGuard({drone}, self)

            ### Flips from the right to the left self.Side after a drone has been spawned
            self.Side = 1

            ###Drone clean up scripts
            self.Trash:Add(drone)
        end
    end
end,

NotifyOfDroneDeath = function(self) 
    ### Only respawns the drones if the parent unit is not dead 
    if not self:IsDead() then
        local mass = self:GetAIBrain():GetEconomyStored('Mass')
        local energy = self:GetAIBrain():GetEconomyStored('Energy')

        ### Check to see if the player has enough mass / energy
        ### And that the production is enabled.
        if self:GetScriptBit('RULEUTC_ProductionToggle') == false and mass >= 50 and energy >= 100 then 

            ###Remove the resources and spawn a single drone
            self:GetAIBrain():TakeResource('Mass',100) 
            self:GetAIBrain():TakeResource('Energy',1000)
            self:ForkThread(self.SpawnDrone) 

        else
            ### If the above conditions are not met the carrier will wait a short time and try again
            self:ForkThread(self.EconomyWait)
        end
    end    
end,

EconomyWait = function(self)
    if not self:IsDead() then
    WaitSeconds(5)
        if not self:IsDead() then
            self:ForkThread(self.NotifyOfDroneDeath)
        end
    end
end,

OnDamage = function(self, instigator, amount, vector, damagetype) 
    ### Check to make sure that the carrier isn't already dead and what just damaged it is a unit we can attack
    if self:IsDead() == false and IsUnit(instigator) then 

        ### Update of global Variables 

        self.HitsTaken = self.HitsTaken + 1 
        self.DmgTotal = self.DmgTotal + amount 

        ### Attack trigger command 
        if self.DmgTotal >= 500 or self.HitsTaken >= 10 then
 
            ###Issues the retaliation command to each of the drones on the carriers table 
            if table.getn({self.DroneTable}) > 0 then
                for k, v in self.DroneTable do 
                    IssueClearCommands({self.DroneTable[k]})
                    IssueAttack({self.DroneTable[k]}, instigator)
                end 
            end 

            ### Reset of global Variables 
            self.HitsTaken = 0 
            self.DmgTotal = 0 

        end
    end 
Unit.OnDamage(self, instigator, amount, vector, damagetype) 
end,

OnKilled = function(self, instigator, type, overkillRatio)
    ### Disables the laser beam after death
    local wep = self:GetWeaponByLabel('GreenLaser')
    for k, v in wep.Beams do
        v.Beam:Disable()
    end
    if self.BeamFX then
       self.BeamFX:Destroy()
    end
    ### Disables weapons after death
    self:SetWeaponEnabledByLabel('GreenLaser', false)
    self:SetWeaponEnabledByLabel('FrontCannon', false)
    self:SetWeaponEnabledByLabel('AA_Front_L', false)
    self:SetWeaponEnabledByLabel('AA_Front_R', false)
    self:SetWeaponEnabledByLabel('AA_Rear_L', false)
    self:SetWeaponEnabledByLabel('AA_Rear_R', false)    
    self:SetWeaponEnabledByLabel('Flare_Left', false)
    self:SetWeaponEnabledByLabel('Flare_Right', false)

    ###Disables all engine steering effects
    if self.RightExhaustEffectsBag then
        EffectUtil.CleanupEffectBag(self,'RightExhaustEffectsBag')
    end

    if self.LeftExhaustEffectsBag then
        EffectUtil.CleanupEffectBag(self,'LeftExhaustEffectsBag')
    end

    ### Small bit of table manipulation to sort thru all of the avalible drones and remove them after the carrier is dead
    if table.getn({self.DroneTable}) > 0 then
        for k, v in self.DroneTable do 
            IssueClearCommands({self.DroneTable[k]}) 
            IssueKillSelf({self.DroneTable[k]})
        end 
    end

    #Removes radar spin effects
    if self.SpinManip then 
        self.Trash:Add(self.SpinManip)
    end
 
    ### Final command to finish off the carriers death event
    Unit.OnKilled(self, instigator, type, overkillRatio)
end,

    DestructionEffectBones = {
        'steering_exhaust_back_left','steering_exhaust_back_right',
        'missile_front_left','missile_front_right','missile_rear_right','missile_rear_left',
        'engine_center01','engine_center03','engine_center05',
        'engine_left01','engine_left03','engine_left05',
        'radar_dish','turret_cannon','front_turret_barrels','beam_muzzle', 
        'engine_right01','engine_right03','engine_right05', 
        'drone_launch_right','drone_launch_left','anti_missile_left','anti_missile_right',
        'steering_exhaust_front_left','steering_exhaust_front_right',
    },

    CreateDamageEffects = function(self, bone, Army )
        for k, v in EffectTemplate.CEMPGrenadeHit01 do   
            CreateAttachedEmitter( self, bone, Army, v ):ScaleEmitter(1.5)
        end
    end,

    CreateExplosionDebris = function( self, bone, Army )
        for k, v in EffectTemplate.ExplosionEffectsSml01 do
            CreateAttachedEmitter( self, bone, Army, v ):ScaleEmitter(1.5)
        end
    end,
    
    CreateFirePlumes = function( self, Army, bones, yBoneOffset )
        ### Fire plume effects
        local basePosition = self:GetPosition()
        for k, vBone in bones do
            local position = self:GetPosition(vBone)
            local offset = utilities.GetDifferenceVector( position, basePosition )
            velocity = utilities.GetDirectionVector( position, basePosition ) 
            velocity.x = velocity.x + utilities.GetRandomFloat(-0.45, 0.45)
            velocity.z = velocity.z + utilities.GetRandomFloat(-0.45, 0.45)
            velocity.y = velocity.y + utilities.GetRandomFloat(0.0, 0.9)
            local proj = self:CreateProjectile('/effects/entities/DestructionFirePlume01/DestructionFirePlume01_proj.bp', offset.x, offset.y + yBoneOffset, offset.z, velocity.x, velocity.y, velocity.z)
            proj:SetBallisticAcceleration(utilities.GetRandomFloat(-1, 1)):SetVelocity(utilities.GetRandomFloat(1, 2)):SetCollision(false)
            local emitter = CreateEmitterOnEntity(proj, Army, '/effects/emitters/destruction_explosion_fire_plume_01_emit.bp')
            local lifetime = utilities.GetRandomFloat( 10, 30 )
        end
    end,

    InitialRandomExplosionsCybrans = function(self)
        local position = self:GetPosition()
        local numExplosions =  math.floor( table.getn( self.DestructionEffectBones ) * 0.5)
        # Create small explosions effects all over
        for i = 0, numExplosions do
            local ranBone = utilities.GetRandomInt( 1, numExplosions )
            local duration = utilities.GetRandomFloat( 0.25, 0.5 )
            self:PlayUnitSound('SmExplosion')
            self:ShakeCamera(2, 0.5, 0.25, duration)
            self:CreateDamageEffects( ranBone, self.Army )
            self:CreateExplosionDebris( ranBone, self.Army )
            self:CreateFirePlumes( self.Army, {ranBone}, Random(0,2) )
            WaitSeconds( duration )
        end

    end,

	NukeExplosion = function(self)
        local position = self:GetPosition()

        # Create full-screen glow flash
        self:PlayUnitSound('Nuke')
        CreateAttachedEmitter(self, 'ura0305', self.Army, '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp')
        self:ForkThread(self.CreateOuterRingWaveSmokeRing)
        CreateLightParticle(self, -1, self.Army, 4, 4, 'glow_03', 'ramp_purple_01')
        WaitSeconds( 0.25 )
        CreateLightParticle(self, -1, self.Army, 6, 20, 'glow_03', 'ramp_fire_06')
        WaitSeconds( 0.50 )       
        CreateLightParticle(self, -1, self.Army, 8, 180, 'glow_03', 'ramp_nuke_04')
       
        # Create ground decals
        local orientation = RandomFloat( 0, 2 * math.pi )
        CreateDecal(position, orientation, 'Crater01_albedo', '', 'Albedo', 10, 10, 600, 0, self.Army)
        CreateDecal(position, orientation, 'Crater01_normals', '', 'Normals', 10, 10, 600, 0, self.Army)       
        CreateDecal(position, orientation, 'nuke_scorch_003_albedo', '', 'Albedo', 10, 10, 600, 0, self.Army)
   
   # Knockdown force rings
        DamageRing(self, position, 0.1, 6, 1, 'Normal', false)
        WaitSeconds(0.1)

        #Nuke damage and camera shake
        DamageRing(self, position, 0.1, 5, 5000, 'Normal', true)
        self:ShakeCamera(5, 4, 2, 1)   
    end,

    DeathThread = function( self, overkillRatio , instigator)
        ### Create Initial explosion effects
        self:InitialRandomExplosionsCybrans() 
        WaitSeconds(0.1)

        ### Nuke detonation
        self:NukeExplosion()

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
        self:CreateWreckage(1)
        self:Destroy()
    end,

}

TypeClass = URA0305