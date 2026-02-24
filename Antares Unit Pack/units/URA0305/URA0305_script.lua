local CAirUnit = import('/lua/cybranunits.lua').CAirUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CDFElectronBolterWeapon = import('/lua/cybranweapons.lua').CDFElectronBolterWeapon
local CAAMissileNaniteWeapon = import('/lua/cybranweapons.lua').CAAMissileNaniteWeapon
local DroneWeapon  = import('/lua/cybranweapons.lua').CIFMissileLoaTacticalWeapon

local explosion = import('/lua/defaultexplosions.lua')

local util = import('/lua/utilities.lua')
local utilities = import('/lua/Utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

URA0305 = Class(CAirUnit) {
	DestroyNoFallRandomChance = 1.1,
    Weapons = {
        Missile_Turret = Class(CAAMissileNaniteWeapon) {},           
        DualCannon_L = Class(CDFElectronBolterWeapon) {},
        DualCannon_R = Class(CDFElectronBolterWeapon) {},
        Launchbay_01 = Class(DroneWeapon) {},
        Launchbay_02 = Class(DroneWeapon) {},
        Launchbay_03 = Class(DroneWeapon) {},
        Launchbay_04 = Class(DroneWeapon) {},
        Launchbay_05 = Class(DroneWeapon) {},
        Launchbay_06 = Class(DroneWeapon) {},
        Launchbay_07 = Class(DroneWeapon) {},
        Launchbay_08 = Class(DroneWeapon) {},                                                     
    },
                                           
OnStopBeingBuilt = function(self,builder,layer)
    CAirUnit.OnStopBeingBuilt(self,builder,layer)   
    -- landing animations   
    self.AnimManip = CreateAnimator(self)
    self.Trash:Add(self.AnimManip)
       
    -- Drone Globals
    self.ActiveBay = 0
    self.DroneTable = {}
   
    -- spawning a number of drones times equal to the number preset by numcreate
    self.Numcreate = 8     

    -- Globals used for target assists and counter attacks
    self.CurrentTarget = nil
    self.OldTarget = nil
    self.MyAttacker = nil
    self.Retaliation = false
   
    -- Globals used for Drone spawn
    self.UnitComplete = true
    self.Army = self:GetArmy()
    self.InitialSpawn = true
   
    -- Set the drone launch flag on as default
    self:SetScriptBit('RULEUTC_SpecialToggle', true)
       
    -- Initializes Drone spawn sequence 
    self:ForkThread(self.InitialDroneSpawn)           
end,

InitialDroneSpawn = function(self)
 
    -- Randomly determines which launch bay will be the first to spawn a drone
    self.ActiveBay = Random(1,8)
     
    -- Short delay after the carrier has been built
    WaitSeconds(3)
   
    -- Are we dead yet, if not spawn drones
    if not self:IsDead() then
        for i = 1, self.Numcreate do
            if not self:IsDead() then
                self:ForkThread(self.SpawnDrone)
                -- Short delay between spawns to spread them out
                WaitSeconds(1)
            end
        end
        self.InitialSpawn = false             
       
        -- Runs assist commands only after all of the drones have been built
        self:DroneCheckHeartBeat()
    end
end,

LaunchBays = {
            'Launchbay_01','Launchbay_02','Launchbay_03','Launchbay_04',
            'Launchbay_05','Launchbay_06','Launchbay_07','Launchbay_08',
             }, 

SpawnDrone = function(self)
    -- Only fires the drones if the parent unit is not dead
    if not self:IsDead() then 
           
        -- Fires the drone out of the specific launch bay
        self:GetWeaponByLabel(self.LaunchBays[self.ActiveBay]):FireWeapon()
                             
        -- changes to next launch bay in sequence
        if self.ActiveBay >= 8 then
            self.ActiveBay = 1
        else
            self.ActiveBay = self.ActiveBay + 1
        end       
    end
end,

DroneCheckHeartBeat = function(self)
    while not self:IsDead() do                       
        if not self:IsDead() and self:GetScriptBit('RULEUTC_SpecialToggle') == true then
            if self:GetTacticalSiloAmmoCount() >= 1 and table.getn(self.DroneTable) < self.Numcreate then
                -- Spawn a single drone only if the above conditions are met
                self:ForkThread(self.SpawnDrone)
            end
        end     
        if not self:IsDead() and self.Retaliation == true and self.MyAttacker != nil then
            -- Clears flags if there is no longer a target to retaliate against thats in range
            if self.MyAttacker:IsDead() or self:GetDistanceToAttacker() > 30 then
                -- Clears flag to allow retaliation on another attacker
                self.MyAttacker = nil
                self.Retaliation = false
            end
        end
        if not self:IsDead() and self.Retaliation == false and self.MyAttacker and self:GetDistanceToAttacker() <= 30 then
            if not self.MyAttacker:IsDead() then
                -- Issues the retaliation command to each of the drones on the carriers table
                if table.getn(self.DroneTable) > 0 then
                    for k, v in self.DroneTable do
                        IssueClearCommands({self.DroneTable[k]})
                        IssueAttack({self.DroneTable[k]}, self.MyAttacker)
                    end
                    -- Sets retaliation flag
                    self.Retaliation = true     
                end
            end
        elseif not self:IsDead() and self.Retaliation == false and self:GetTargetEntity() then
            -- Updates variable with latest targeting info
            self.CurrentTarget = self:GetTargetEntity()     
            -- Verifies that the carrier is not dead and that it has a target
            -- Ensures that either there hasnt been a target before or that its new
            -- To prevent the same retargeting command from being given out multible times
            if self.OldTarget == nil or self.OldTarget != self.CurrentTarget then   
                -- Updates the OldTarget to match CurrentTarget
                self.OldTarget = self.CurrentTarget       
                -- Issues the attack command to each of the drones on the carriers table
                if table.getn(self.DroneTable) > 0 then
                    for k, v in self.DroneTable do
                        IssueClearCommands({self.DroneTable[k]})
                        IssueAttack({self.DroneTable[k]}, self.CurrentTarget)
                    end
                end
            end
        end
        -- Short delay between checks
        WaitSeconds(1)       
    end
end,

GetDistanceToAttacker = function(self)
    local tpos = self.MyAttacker:GetPosition()
    local mpos = self:GetPosition()
    local dist = VDist2(mpos[1], mpos[3], tpos[1], tpos[3])
    return dist
end,

OnKilledUnit = function(self, unitKilled)
    CAirUnit.OnKilledUnit(self, unitKilled)     
    if not self:IsDead() and table.getn(self.DroneTable) > 0 then
        self:ForkThread(self.UpdateDroneKills)
    end
end,   

ReceiveKills = function(self, unitKills)
    if not self:IsDead() then
        self.AddKills(self, unitKills)
        self:ForkThread(self.UpdateDroneKills)
    end   
end,

UpdateDroneKills = function(self)
    -- Updates the drone veterancy to match that of the carrier
    if table.getn(self.DroneTable) > 0 then
        for k, v in self.DroneTable do
            if not v:BeenDestroyed() then
               local carrierKills = self:GetStat('KILLS', 0).Value
               local droneKills = self.DroneTable[k]:GetStat('KILLS', 0).Value
               if carrierKills > droneKills then
                   local unitKills = carrierKills - droneKills
                   self.DroneTable[k].ReceiveKills(self.DroneTable[k], unitKills)
               end
           end
        end
    end   
end,

OnDamage = function(self, instigator, amount, vector, damagetype)
    -- Check to make sure that the carrier isnt already dead and what just damaged it is a unit we can attack
    if self:IsDead() == false and damagetype == 'Normal' and self.MyAttacker == nil then
        -- only attack if retaliation not already active
        if IsUnit(instigator) then
            self.MyAttacker = instigator
        end
    end
    CAirUnit.OnDamage(self, instigator, amount, vector, damagetype)
end,

ExhaustBones = {'engine_exhaust01','engine_exhaust02',},         
BeamExhaustCruise = '/effects/emitters/missile_exhaust_fire_beam_03_emit.bp',
BeamExhaustIdle = '/effects/emitters/gunship_thruster_beam_01_emit.bp',

OnMotionVertEventChange = function(self, new, old)
    CAirUnit.OnMotionVertEventChange(self, new, old)
    if ((new == 'Top' or new == 'Up') and old == 'Down') then
        self.AnimManip:SetRate(-0.1)
    elseif (new == 'Down') then
        self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationLand, false):SetRate(0.5)
    elseif (new == 'Up') then
        self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationLand, false):SetRate(-0.1)
    end
end,

OnMotionHorzEventChange = function(self, new, old )
    CAirUnit.OnMotionHorzEventChange(self, new, old)   
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

MovementAmbientExhaustBones = {
    'left_effects_front',
    'left_effects_mid_1',
    'left_effects_mid_2',
    'left_effects_rear',
    'right_effects_front',
    'right_effects_mid_1',
    'right_effects_mid_2',
    'right_effects_rear',      
},

MovementAmbientExhaustThread = function(self)
    while not self:IsDead() do
        local ExhaustEffects = {
            '/effects/emitters/dirty_exhaust_smoke_01_emit.bp',
            '/effects/emitters/dirty_exhaust_sparks_01_emit.bp',         
        }
        local ExhaustBeam = '/effects/emitters/missile_exhaust_fire_beam_03_emit.bp'   
         
        for kE, vE in ExhaustEffects do
            for kB, vB in self.MovementAmbientExhaustBones do
                table.insert( self.MovementAmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, self.Army, vE ))
                table.insert( self.MovementAmbientExhaustEffectsBag, CreateBeamEmitterOnEntity( self, vB, self.Army, ExhaustBeam ))
            end
        end         
        WaitSeconds(2)
        fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')                     
        WaitSeconds(util.GetRandomFloat(1,7))
    end   
end,

OnKilled = function(self, instigator, type, overkillRatio)
    -- Disables weapons after death
    self:SetWeaponEnabledByLabel('DualCannon_L', false)
    self:SetWeaponEnabledByLabel('DualCannon_R', false)
    self:SetWeaponEnabledByLabel('Missile_Turret', false)   
    -- Small bit of table manipulation to sort thru all of the avalible drones and remove them after the carrier is dead
    if table.getn(self.DroneTable) > 0 then
        for k, v in self.DroneTable do
            IssueClearCommands({self.DroneTable[k]})
            IssueKillSelf({self.DroneTable[k]})
        end
    end
    -- Final command to finish off the carriers death event
    CAirUnit.OnKilled(self, instigator, type, overkillRatio)
end,
}
TypeClass = URA0305 