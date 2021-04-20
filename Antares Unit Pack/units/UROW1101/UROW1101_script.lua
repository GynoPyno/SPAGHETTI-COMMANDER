local CAirUnit = import('/lua/cybranunits.lua').CAirUnit

local Weapon = import('/lua/sim/Weapon.lua').Weapon
local WeaponFile = import('/lua/sim/defaultweapons.lua')
local CybranWeaponsFile = import('/lua/cybranweapons.lua')

local CDFLaserHeavyWeapon = CybranWeaponsFile.CDFLaserHeavyWeapon
local CDFHeavyElectronBolterWeapon = import('/lua/cybranweapons.lua').CDFHeavyElectronBolterWeapon
local CDFHvyProtonCannonWeapon = CybranWeaponsFile.CDFHvyProtonCannonWeapon

local explosion = import('/lua/defaultexplosions.lua')

local util = import('/lua/utilities.lua')
local utilities = import('/lua/Utilities.lua')
local fxutil = import('/lua/effectutilities.lua')
local Effects = import('/lua/effecttemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local EffectUtils = import('/lua/EffectUtilities.lua')
local ExhaustBeam = import('/lua/effecttemplates.lua')
local ExhaustEffects = import('/lua/effecttemplates.lua')

local AIUtils = import('/lua/ai/aiutilities.lua')

UROW1101 = Class(CAirUnit) {
	DestroyNoFallRandomChance = 1.1,

    Weapons = {
		LaserAA01 = Class(CDFLaserHeavyWeapon) {
		
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_01', self.unit:GetArmy(), Effects.WeaponSteam01 )
				self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_02', self.unit:GetArmy(), Effects.WeaponSteam01 )
                CDFLaserHeavyWeapon.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Rotation_01', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip)
                end
				if not self.SpinManip2 then 
                    self.SpinManip2 = CreateRotator(self.unit, 'Rotation_02', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip2)
                end						
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(500)
                end
                CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(200)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_01', self.unit:GetArmy(), Effects.WeaponSteam01 )
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_02', self.unit:GetArmy(), Effects.WeaponSteam01 )
				CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
		},
		
		LaserAA02 = Class(CDFLaserHeavyWeapon) {
		
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_03', self.unit:GetArmy(), Effects.WeaponSteam01 )
				self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_04', self.unit:GetArmy(), Effects.WeaponSteam01 )
                CDFLaserHeavyWeapon.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Rotation_03', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip)
                end
				if not self.SpinManip2 then 
                    self.SpinManip2 = CreateRotator(self.unit, 'Rotation_04', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip2)
                end						
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(500)
                end
                CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(200)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_03', self.unit:GetArmy(), Effects.WeaponSteam01 )
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_04', self.unit:GetArmy(), Effects.WeaponSteam01 )
				CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
		},		

		LaserAA03 = Class(CDFLaserHeavyWeapon) {
		
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_05', self.unit:GetArmy(), Effects.WeaponSteam01 )
				self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_06', self.unit:GetArmy(), Effects.WeaponSteam01 )
                CDFLaserHeavyWeapon.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Rotation_05', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip)
                end
				if not self.SpinManip2 then 
                    self.SpinManip2 = CreateRotator(self.unit, 'Rotation_06', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip2)
                end						
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(500)
                end
                CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(200)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_05', self.unit:GetArmy(), Effects.WeaponSteam01 )
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_06', self.unit:GetArmy(), Effects.WeaponSteam01 )
				CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
		},		
			

		LaserAA04 = Class(CDFLaserHeavyWeapon) {
		
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_07', self.unit:GetArmy(), Effects.WeaponSteam01 )
				self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_08', self.unit:GetArmy(), Effects.WeaponSteam01 )
                CDFLaserHeavyWeapon.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Rotation_07', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip)
                end
				if not self.SpinManip2 then 
                    self.SpinManip2 = CreateRotator(self.unit, 'Rotation_08', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip2)
                end						
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(500)
                end
                CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(200)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_07', self.unit:GetArmy(), Effects.WeaponSteam01 )
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_08', self.unit:GetArmy(), Effects.WeaponSteam01 )
				CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
		},	

		LaserAA05 = Class(CDFLaserHeavyWeapon) {
		
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_09', self.unit:GetArmy(), Effects.WeaponSteam01 )
				self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_10', self.unit:GetArmy(), Effects.WeaponSteam01 )
                CDFLaserHeavyWeapon.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Rotation_09', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip)
                end
				if not self.SpinManip2 then 
                    self.SpinManip2 = CreateRotator(self.unit, 'Rotation_10', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip2)
                end						
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(500)
                end
                CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(200)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_09', self.unit:GetArmy(), Effects.WeaponSteam01 )
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_10', self.unit:GetArmy(), Effects.WeaponSteam01 )
				CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
		},				

		LaserAA06 = Class(CDFLaserHeavyWeapon) {
		
            PlayFxWeaponPackSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(0)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(0)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_11', self.unit:GetArmy(), Effects.WeaponSteam01 )
				self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_12', self.unit:GetArmy(), Effects.WeaponSteam01 )
                CDFLaserHeavyWeapon.PlayFxWeaponPackSequence(self)
            end,
        
            PlayFxRackSalvoChargeSequence = function(self)
                if not self.SpinManip then 
                    self.SpinManip = CreateRotator(self.unit, 'Rotation_11', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip)
                end
				if not self.SpinManip2 then 
                    self.SpinManip2 = CreateRotator(self.unit, 'Rotation_12', 'z', nil, 270, 180, 60)				
                    self.unit.Trash:Add(self.SpinManip2)
                end						
                
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(500)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(500)
                end
                CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,            
            
            PlayFxRackSalvoReloadSequence = function(self)
                if self.SpinManip then
                    self.SpinManip:SetTargetSpeed(200)
                end
				if self.SpinManip2 then
                    self.SpinManip2:SetTargetSpeed(200)
                end
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_11', self.unit:GetArmy(), Effects.WeaponSteam01 )
                self.ExhaustEffects = EffectUtils.CreateBoneEffects( self.unit, 'Rotation_12', self.unit:GetArmy(), Effects.WeaponSteam01 )
				CDFLaserHeavyWeapon.PlayFxRackSalvoChargeSequence(self)
            end,
		},

        AntiSpaceShipsGun = Class(CDFHeavyElectronBolterWeapon) {
		FxMuzzleFlashScale = 1.5,
        },		
	ParticleGunRight = Class(CDFHvyProtonCannonWeapon) {},
        ParticleGunLeft = Class(CDFHvyProtonCannonWeapon) {},			 
	ParticleGunFront = Class(CDFHvyProtonCannonWeapon) {},
    }, 

    OnStopBeingBuilt = function(self,builder,layer)
        CAirUnit.OnStopBeingBuilt(self,builder,layer)
        if( not self.OpenAnimManip ) then
            self.OpenAnimManip = CreateAnimator(self)
        end
        local bp = self:GetBlueprint()
		self.OpenAnimManip = CreateAnimator(self)
		self.OpenAnimManip:PlayAnim(self:GetBlueprint().Display.AnimationOpen, false)
    end,


    MovementAmbientExhaustBones = {
		'Reacteur02',
		'Reacteur01',
    },

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
    
    MovementAmbientExhaustThread = function(self)
		while not self:IsDead() do
			local ExhaustEffects = {
				'/effects/emitters/missile_cruise_munition_trail_01_emit.bp',
				'/effects/emitters/nuke_munition_launch_trail_02_emit.bp',	
			}
			local ExhaustBeam = '/mods/Antares Unit Pack/effects/emitters/cybran_missile_exhaust_fire_beam_12_emit.bp'
						--'/mods/Antares Unit Pack/effects/emitters/cybran_missile_exhaust_fire_beam_11_emit.bp'
			local army = self:GetArmy()			
			
			for kE, vE in ExhaustEffects do
				for kB, vB in self.MovementAmbientExhaustBones do
					table.insert( self.MovementAmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE ))
					table.insert( self.MovementAmbientExhaustEffectsBag, CreateBeamEmitterOnEntity( self, vB, army, ExhaustBeam ))
				end
			end
			
			WaitSeconds(5)
			fxutil.CleanupEffectBag(self,'MovementAmbientExhaustEffectsBag')
							
			--WaitSeconds(util.GetRandomFloat(0,3))
		end	
    end,		
			
	
}

TypeClass = UROW1101
