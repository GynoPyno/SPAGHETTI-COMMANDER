#****************************************************************************
#**
#**  File     :  /cdimage/units/UES0307/UES0307_script.lua
#**  Author(s):  Drew Staltman, Gordon Duclos, Greg Kohne
#**
#**  Summary  :  UEF Battleship Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local BWeaponsFile = import('/Mods/BattlePack/lua/BattlePackweapons.lua')
local TAMPhalanxWeapon = WeaponsFile.TAMPhalanxWeapon
local TDFHiroPlasmaCannon = WeaponsFile.TDFHiroPlasmaCannon
local HeavyPlasmaCannon = BWeaponsFile.ExWifeMaincannonWeapon01
local TDFGaussCannonWeapon = WeaponsFile.TDFShipGaussCannonWeapon
local ZapperCollisionBeam02 = BWeaponsFile.ZapperCollisionBeam02
local TIFCruiseMissileLauncher = WeaponsFile.TIFCruiseMissileLauncher

UES0302 = Class(TSeaUnit) {
    Weapons = {
        HiroCannon1 = Class(TDFHiroPlasmaCannon) {},
        HiroCannon2 = Class(TDFHiroPlasmaCannon) {},
		GaussCannon1 = Class(TDFGaussCannonWeapon) {},
		GaussCannon2 = Class(TDFGaussCannonWeapon) {},
		MegaCannon = Class(HeavyPlasmaCannon) {},
        TMD1 = Class(ZapperCollisionBeam02) {},
		TMD2 = Class(ZapperCollisionBeam02) {},
		CruiseMissile = Class(TIFCruiseMissileLauncher) {},
        
        OnKilled = function(self)
            local wep1 = self:GetWeaponByLabel('HiroCannon1')
            local bp1 = wep1:GetBlueprint()
            if bp1.Audio.BeamStop then
                wep1:PlaySound(bp1.Audio.BeamStop)
            end
            if bp1.Audio.BeamLoop and wep1.Beams[1].Beam then
                wep1.Beams[1].Beam:SetAmbientSound(nil, nil)
            end
            for k, v in wep1.Beams do
                v.Beam:Disable()
            end     
            
            local wep2 = self:GetWeaponByLabel('HiroCannon2')
            local bp2 = wep2:GetBlueprint()
            if bp2.Audio.BeamStop then
                wep2:PlaySound(bp2.Audio.BeamStop)
            end
            if bp2.Audio.BeamLoop and wep2.Beams[1].Beam then
                wep2.Beams[1].Beam:SetAmbientSound(nil, nil)
            end
            for k, v in wep2.Beams do
                v.Beam:Disable()
            end
            
            TSeaUnit.OnKilled(self)
        end,        
    },
}
TypeClass = UES0302