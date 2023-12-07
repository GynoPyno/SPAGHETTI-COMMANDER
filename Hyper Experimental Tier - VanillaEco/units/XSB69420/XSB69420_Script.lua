#****************************************************************************
#**
#**  File     :  /mods/Hyper Experimental Tier/units/XSB69420/XSB69420_script.lua
#**  Author(s):  Cmd Draven
#**
#**  Summary  :  Seraphim Othuy Artillery Script
#****************************************************************************
local SStructureUnit = import('/lua/seraphimunits.lua').SStructureUnit
local SIFSuthanusArtilleryCannon = import('/lua/seraphimweapons.lua').SIFSuthanusArtilleryCannon

XSB69420 = Class(SStructureUnit) {
    Weapons = {
        MainGun = Class(SIFSuthanusArtilleryCannon) {
        },
    },
}
TypeClass = XSB69420
