#****************************************************************************
#**
#**  File     :  /units/UES0106/UES0106_script.lua
#**  Author(s):  Asdrubaelvect 
#**
#**  Summary  :  UEF Aviso Script
#**
#****************************************************************************
local TSeaUnit = import('/lua/terranunits.lua').TSeaUnit
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local TAALinkedRailgun = import('/lua/terranweapons.lua').TAALinkedRailgun
local TANTorpedoAngler = import('/lua/terranweapons.lua').TANTorpedoAngler

UES0106 = Class(TSeaUnit) {
    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon) {},
        AAGun = Class(TAALinkedRailgun) {}, 
        UpgradeGun01 = Class(TDFGaussCannonWeapon) {
        },
        UpgradeAAGun01 = Class(TAALinkedRailgun) {
        },
        Torpedo01 = Class(TANTorpedoAngler) {},
    },
    OnCreate = function(self)
        TSeaUnit.OnCreate(self)
    end,    
    OnStopBeingBuilt = function(self,builder,layer)
        TSeaUnit.OnStopBeingBuilt(self,builder,layer)
        self.Trash:Add(CreateRotator(self, 'Spinner04', 'y', nil, 180, 0, 180))
        self.Trash:Add(CreateRotator(self, 'Spinner05', 'y', nil, 180, 0, 180))
    end,
}
TypeClass = UES0106