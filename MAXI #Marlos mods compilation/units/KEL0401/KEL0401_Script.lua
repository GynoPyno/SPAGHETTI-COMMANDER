
-- Super Heavy

local TLandUnit = import('/lua/terranunits.lua').TLandUnit

local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local TIFArtilleryWeapon = import('/lua/terranweapons.lua').TIFArtilleryWeapon
local TAAFlakArtilleryCannon = import('/lua/terranweapons.lua').TAAFlakArtilleryCannon
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateBuildCubeThread = EffectUtil.CreateBuildCubeThread


UEL0101 = Class(TLandUnit) {
    
    Weapons = {
        MainGun = Class(TIFArtilleryWeapon) {
            FxMuzzleFlashScale = 3,
        },
		FrontTurret01 = Class(TDFGaussCannonWeapon) {
		},
		FrontTurret02 = Class(TDFGaussCannonWeapon) {
		},
        AAGun1 = Class(TAAFlakArtilleryCannon) {},
        AAGun2 = Class(TAAFlakArtilleryCannon) {},
        AAGun3 = Class(TAAFlakArtilleryCannon) {},
        AAGun4 = Class(TAAFlakArtilleryCannon) {},
        AAGun5 = Class(TAAFlakArtilleryCannon) {},
        AAGun6 = Class(TAAFlakArtilleryCannon) {},
	},
	
    StartBeingBuiltEffects = function(self, builder, layer)
        self:SetMesh(self:GetBlueprint().Display.BuildMeshBlueprint, true)
        if self:GetBlueprint().General.UpgradesFrom ~= builder.UnitId then
            self:HideBone(0, true)
            self.OnBeingBuiltEffectsBag:Add(self:ForkThread(CreateBuildCubeThread, builder, self.OnBeingBuiltEffectsBag))
        end
    end,
}


TypeClass = UEL0101
