#****************************************************************************
#**
#**  File     :  /mods/Annihilation New SupCom/units/LED0022_script.lua
#**  Author(s):  Cmd Draven
#**  Summary  :  Sera  Experimental Bomber
#**
#**  Copyright © Cmd Draven
#****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TAirToAirLinkedRailgun = import('/lua/terranweapons.lua').TAirToAirLinkedRailgun
local TIFCarpetBombWeapon = import('/lua/terranweapons.lua').TIFCarpetBombWeapon
local explosion = import('/lua/defaultexplosions.lua')


LED0022 = Class(TAirUnit) {
    Weapons = {
        RightBeam = Class(TAirToAirLinkedRailgun) {},
        LeftBeam = Class(TAirToAirLinkedRailgun) {},
        Bomb = Class(TIFCarpetBombWeapon) {

			IdleState = State (TIFCarpetBombWeapon.IdleState) {
				Main = function(self)
					TIFCarpetBombWeapon.IdleState.Main(self)
				end,
                
				OnGotTarget = function(self)
					if self.unit:IsUnitState('Moving') then
						self.unit:SetSpeedMult(1.0)
					else
						self.unit:SetBreakOffTriggerMult(2.0)
						self.unit:SetBreakOffDistanceMult(8.0)
						self.unit:SetSpeedMult(0.67)
						TIFCarpetBombWeapon.IdleState.OnGotTarget(self)
					end
				end,
				OnFire = function(self)
					self.unit:RotateWings(self:GetCurrentTarget())
					TIFCarpetBombWeapon.IdleState.OnFire(self)
				end,                
			},
			OnFire = function(self)
				self.unit:RotateWings(self:GetCurrentTarget())
				TIFCarpetBombWeapon.OnFire(self)
			end,
                    
			OnGotTarget = function(self)
				if self.unit:IsUnitState('Moving') then
					self.unit:SetSpeedMult(1.0)
				else
					self.unit:SetBreakOffTriggerMult(2.0)
					self.unit:SetBreakOffDistanceMult(8.0)
					self.unit:SetSpeedMult(0.67)
					TIFCarpetBombWeapon.OnGotTarget(self)
				end
			end,
        
			OnLostTarget = function(self)
				self.unit:SetBreakOffTriggerMult(1.0)
				self.unit:SetBreakOffDistanceMult(1.0)
				self.unit:SetSpeedMult(1.0)
				TIFCarpetBombWeapon.OnLostTarget(self)
			end,        
        },
    },
    
    
    RotateWings = function(self, target)
        if not self.LWingRotator then
            self.LWingRotator = CreateRotator(self, 'Contrail01', 'y')
            self.Trash:Add(self.LWingRotator)
        end
        if not self.RWingRotator then
            self.RWingRotator = CreateRotator(self, 'Contrail02', 'y')
            self.Trash:Add(self.RWingRotator)
        end
        local fighterAngle = -105
        local bomberAngle = 0
        local wingSpeed = 45
        if target and EntityCategoryContains(categories.AIR, target) then
            if self.LWingRotator then
                self.LWingRotator:SetSpeed(wingSpeed)
                self.LWingRotator:SetGoal(-fighterAngle)
            end
            if self.RWingRotator then
                self.RWingRotator:SetSpeed(wingSpeed)
                self.RWingRotator:SetGoal(fighterAngle)
            end
        else
            if self.LWingRotator then
                self.LWingRotator:SetSpeed(wingSpeed)
                self.LWingRotator:SetGoal(-bomberAngle)
            end
            if self.RWingRotator then
                self.RWingRotator:SetSpeed(wingSpeed)
                self.RWingRotator:SetGoal(bomberAngle)
            end                
        end  
    end,
    
    OnCreate = function(self)
        TAirUnit.OnCreate(self)
        self:ForkThread(self.MonitorWings)
    end,
    
    MonitorWings = function(self)
        local airTargetRight
        local airTargetLeft
        while self and not self.Dead do
            local airTargetWeapon = self:GetWeaponByLabel('RightBeam')
            if airTargetWeapon then     
                airTargetRight = airTargetWeapon:GetCurrentTarget()
            end
            airTargetWeapon = self:GetWeaponByLabel('LeftBeam')
            if airTargetWeapon then
                airTargetLeft = airTargetWeapon:GetCurrentTarget()
            end
            
            if airTargetRight then
                self:RotateWings(airTargetRight)              
            elseif airTargetLeft then
                self:RotateWings(airTargetLeft)             
            else
                self:RotateWings(nil)
            end
            
            WaitSeconds(1)
        end
    end,

    OnKilled = function(self, instigator, type, overkillRatio)
        self.detector = CreateCollisionDetector(self)
        self.Trash:Add(self.detector)
        self.detector:WatchBone('Purifier')
        self.detector:WatchBone('Contrail01')
        self.detector:WatchBone('Contrail02')
        self.detector:WatchBone('Exhaust')
        self.detector:WatchBone('Flak1')
        self.detector:WatchBone('Flak2')
        self.detector:WatchBone('Laser')
        self.detector:EnableTerrainCheck(true)
        self.detector:Enable()
    end,
	    OnKilled = function(self, instigator, type, overkillRatio)
        TAirUnit.OnKilled(self, instigator, type, overkillRatio)
    end,

    OnAnimTerrainCollision = function(self, bone,x,y,z)
        DamageArea(self, {x,y,z}, 5, 1000, 'Default', true, false)
        explosion.CreateDefaultHitExplosionAtBone(self, bone, 5.0)
        explosion.CreateDebrisProjectiles(self, explosion.GetAverageBoundingXYZRadius(self), {self:GetUnitSizes()})
    end,


}

TypeClass = LED0022
