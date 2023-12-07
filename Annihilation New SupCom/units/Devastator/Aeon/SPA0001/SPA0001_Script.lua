local ALandUnit = import('/lua/aeonunits.lua').ALandUnit

local AIFArtillerySonanceShellWeapon = import('/lua/aeonweapons.lua').AIFArtillerySonanceShellWeapon

SPA0001 = Class(ALandUnit) {
    Weapons = {
        MainGun = Class(AIFArtillerySonanceShellWeapon) {
            FxMuzzleFlash = { 
                '/effects/emitters/aeon_heavy_artillery_flash_01_emit.bp', 
                '/effects/emitters/aeon_heavy_artillery_flash_02_emit.bp', 
            },
        },
    },

}

TypeClass = SPA0001