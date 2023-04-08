local modpath = "/mods/Ranges/"
local ASCUI = import(modpath..'modules/ACSUI.lua')

local originalCreateUI = CreateUI
local originalSetLayout = SetLayout


function CreateUI(isReplay) 
	originalCreateUI(isReplay)
	import('/mods/Ranges/modules/ACSmain.lua').init()
end

function SetLayout(layout)
	originalSetLayout(layout)
	ASCUI.SetLayout()
end