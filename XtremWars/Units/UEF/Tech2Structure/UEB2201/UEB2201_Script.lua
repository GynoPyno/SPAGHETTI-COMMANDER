#****************************************************************************
#**
#**  File     :  /Mods/units/UEB2201/UEB2201_script.lua
#**  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#**
#**  Summary  :  UEF Light Artillery Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local TSubUnit = import('/lua/terranunits.lua').TSubUnit
local TDFAntiShipGaussCannonWeapon = import('/Mods/XtremWars/hook/lua/terranweapons.lua').TDFAntiShipGaussCannonWeapon

UEB2201 = Class(TSubUnit) {
	SwitchAnims = true,
    IsWaiting = false,
	
    Weapons = {
        MainGun = Class(TDFAntiShipGaussCannonWeapon) {},
	},	

	OnStopBeingBuilt = function(self,builder,layer)
        TSubUnit.OnStopBeingBuilt(self,builder,layer)
        # If created with F2 on land, then play the transform anim
			self:DisableUnitIntel('RadarStealth')
            self:DisableUnitIntel('SonarStealth')  
			self.AT1 = self:ForkThread(self.TransformThread, true)
            self:SetImmobile(true)	
    end,

	OnMotionVertEventChange = function( self, new, old )
        TSubUnit.OnMotionVertEventChange(self, new, old)
		if( old != 'None' ) then
            if( self.AT1 ) then
                self.AT1:Destroy()
                self.AT1 = nil
            end
		end	
        if new == 'Top' then
			self.AT1 = self:ForkThread(self.TransformThread, true)  
			self:DisableUnitIntel('RadarStealth')
            self:DisableUnitIntel('SonarStealth')
        elseif old == 'Top' then
			self.AT1 = self:ForkThread(self.TransformThread, false)   
			--self:EnableUnitIntel('Cloak')
            self:EnableUnitIntel('RadarStealth')
            self:EnableUnitIntel('SonarStealth')
        end
    end,
	
	TransformThread = function(self, water)
        if( not self.AnimManip ) then
            self.AnimManip = CreateAnimator(self)
        end
        local bp = self:GetBlueprint()

        if ( water ) then
            local bp = self:GetBlueprint()
			self:RemoveCommandCap( 'RULEUCC_Attack' )
			IssueClearCommands( {self} )
			self:SetImmobile(false)
			self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationSurface)
			self.AnimManip:SetRate(0.5)
			WaitFor(self.AnimManip)
            self.Trash:Add(self.AnimManip)
			self:SetUnSelectable( true )		
			WaitSeconds(7)
			self:SetUnSelectable( false )
			self:AddCommandCap( 'RULEUCC_Attack' )
			self:SetImmobile(true)   
        else	
			self:SetImmobile(false)
            self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationSurface)
			self.AnimManip:SetAnimationFraction(1)
			self.AnimManip:SetRate(-0.5)
			self.IsWaiting = true
            WaitFor(self.AnimManip)
			self.IsWaiting = false
            self.AnimManip:Destroy()
            self.AnimManip = nil
			WaitSeconds(7)
            self:SetImmobile(true)
        end
    end,

}

TypeClass = UEB2201


