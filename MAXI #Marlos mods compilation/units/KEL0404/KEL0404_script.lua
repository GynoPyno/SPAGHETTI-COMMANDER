#****************************************************************************
#**
#**  File     :  /cdimage/units/URS0303/URS0303_script.lua
#**  Author(s):  David Tomandl, Andres Mendez
#**
#**  Summary  :  Cybran Aircraft Carrier Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local Fatboy2Weapon01 = import('/Mods/#Marlos mods compilation/lua/MKweapons.lua').Fatboy2Weapon01
local Fatboy2Weapon02 = import('/Mods/#Marlos mods compilation/lua/MKweapons.lua').Fatboy2Weapon02
local EffectUtil = import('/lua/EffectUtilities.lua')
local CreateBuildCubeThread = EffectUtil.CreateBuildCubeThread


URS0303 = Class(TLandUnit) {

    FxDamageScale = 2.5,
	
    Weapons = {
        RightTurret01 = Class(Fatboy2Weapon01) {},
        RightTurret02 = Class(Fatboy2Weapon02) {},
        LeftTurret01 = Class(Fatboy2Weapon02) {},
        LeftTurret02 = Class(Fatboy2Weapon02) {},
        LeftTurret03 = Class(Fatboy2Weapon02) {},
    },
	
    StartBeingBuiltEffects = function(self, builder, layer)
        self:SetMesh(self:GetBlueprint().Display.BuildMeshBlueprint, true)
        if self:GetBlueprint().General.UpgradesFrom ~= builder.UnitId then
            self:HideBone(0, true)
            self.OnBeingBuiltEffectsBag:Add(self:ForkThread(CreateBuildCubeThread, builder, self.OnBeingBuiltEffectsBag))
        end
    end,
}

TypeClass = URS0303

