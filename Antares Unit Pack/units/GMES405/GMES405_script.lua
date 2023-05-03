local EffectTemplate = import('/lua/EffectTemplates.lua')
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local TIFCruiseMissileLauncher = import('/lua/terranweapons.lua').TIFCruiseMissileLauncher
local TSAMLauncher = import('/lua/terranweapons.lua').TSAMLauncher
local TIFCommanderDeathWeapon = import('/lua/terranweapons.lua').TIFCommanderDeathWeapon

local EffectUtil = import('/lua/EffectUtilities.lua')

GMES405 = Class(TSeaUnit) {
    DestructionTicks = 200,

    Weapons = {
        DeathWeapon = Class(TIFCommanderDeathWeapon) {},
	ASRack = Class(TSAMLauncher) {},
	MissileRack = Class(TSAMLauncher) {},
        CruiseMissile = Class(TIFCruiseMissileLauncher) {},
        FrontTurret01 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cannon_muzzle_fire_01_emit.bp',
                '/effects/emitters/gauss_cannon_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_03_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_04_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_05_emit.bp',
                '/effects/emitters/cannon_muzzle_water_shock_01_emit.bp',
            },
            FxMuzzleFlashScale = 0.8,
        },
        FrontTurret02 = Class(TDFGaussCannonWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cannon_muzzle_fire_01_emit.bp',
                '/effects/emitters/gauss_cannon_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_03_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_04_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_05_emit.bp',
                '/effects/emitters/cannon_muzzle_water_shock_01_emit.bp',
            },
            FxMuzzleFlashScale = 0.8,
       	},
    },

    RadarThread = function(self)
        local spinner = CreateRotator(self, 'Spinner04', 'y', nil, 180, 0, 180)
        local spinner = CreateRotator(self, 'Spinner10', 'y', nil, 180, 0, 180)
        while true do
            WaitFor(spinner)
            spinner:SetTargetSpeed(-5)
            WaitFor(spinner)
            spinner:SetTargetSpeed(5)
        end
    end,

    OnStopBeingBuilt = function(self, builder,layer)
        TSeaUnit.OnStopBeingBuilt(self, builder,layer)
        self:ForkThread(self.RadarThread)
        self.Trash:Add(CreateRotator(self, 'Spinner01', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner02', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner03', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner05', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner06', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner07', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner08', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner09', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner11', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner12', 'y', nil, 180, 0, 180))
    end,

    CreateBuildEffects = function( self, unitBeingBuilt, order )
        EffectUtil.CreateUEFBuildSliceBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )                  
    end,
}

TypeClass = GMES405
