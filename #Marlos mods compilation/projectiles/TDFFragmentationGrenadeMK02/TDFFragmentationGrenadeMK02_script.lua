#****************************************************************************
#**
#**  File     :  /data/projectiles/TDFFragmentationGrenade01/TDFFragmentationGrenade01_script.lua
#**  Author(s):  Matt Vainio
#**
#**  Summary  :  UEF Fragmentation Shells, DEL0204
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local TFragmentationGrenadeMK02 = import('/Mods/#Marlos mods compilation/lua/MKProjectiles.lua').TFragmentationGrenadeMK02
local EffectTemplate = import('/lua/EffectTemplates.lua')

TDFFragmentationGrenade01 = Class(TFragmentationGrenadeMK02) {
}

TypeClass = TDFFragmentationGrenade01