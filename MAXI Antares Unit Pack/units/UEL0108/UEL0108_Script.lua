--[[#######################################################################
#  File.... :  /units/UEL0108/UEL0108_script.lua
#  Author(s):  John Comes, David Tomandl, Jessica St. Croix
#  Summary  :  UEF Medium Tank Script UEL0201
#  -----------------------------
#  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#######################################################################]]--
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local TerranWeapons = import( '/lua/terranweapons.lua' )
local TDFGaussCannonWeapon = TerranWeapons.TDFGaussCannonWeapon
local TDFMachineGunWeapon = TerranWeapons.TDFMachineGunWeapon

UEL0108 = Class( TLandUnit ) {

	Weapons = {
		ArmCannonTurret = Class( TDFMachineGunWeapon ) {},
		MainGun = Class( TDFGaussCannonWeapon ) {
			SetOnTransport = function( self, transportstate )
				self.unit:SetScriptBit( 'RULEUTC_WeaponToggle', false )
			end,  
		},
		UpgradeGun01 = Class( TDFGaussCannonWeapon ) {},
		UpgradeGun02 = Class( TDFMachineGunWeapon ) {},
		UpgradeGun03 = Class( TDFMachineGunWeapon ) {},

	},


	OnCreate = function( self )
		TLandUnit.OnCreate( self )
		if not self.AnimationManipulator then
			self.AnimationManipulator = CreateAnimator( self )
			self.Trash:Add( self.AnimationManipulator )
		end
		local bp = self:GetBlueprint()
		self.AnimationManipulator:PlayAnim( bp.Display.AnimationActivate, false ):SetRate(0)
	end,


	OnStopBeingBuilt = function( self, builder, layer )
		TLandUnit.OnStopBeingBuilt( self, builder, layer )
		self:SetWeaponEnabledByLabel( 'ArmCannonTurret', true )
		self:SetWeaponEnabledByLabel( 'MainGun', false )
		self:SetWeaponEnabledByLabel( 'UpgradeGun01', false )
		self:SetWeaponEnabledByLabel( 'UpgradeGun02', false )
		self:SetWeaponEnabledByLabel( 'UpgradeGun03', false )
		IssueClearCommands( {self})
		self:AddCommandCap( 'RULEUCC_Move' )
		self:SetSpeedMult( 1.0 )
		self:SetTurnMult( 1.0 )
	end,


	OnScriptBitSet = function( self, bit )
		TLandUnit.OnScriptBitSet( self, bit )
		if bit == 1 then
			if self.AnimationManipulator then
				self:ForkThread( function()
					WaitSeconds( self.AnimationManipulator:GetAnimationDuration() * self.AnimationManipulator:GetRate() )
					self:SetUnSelectable( true )
					IssueClearCommands( {self} )
					self:RemoveCommandCap( 'RULEUCC_Move' )
					self:SetSpeedMult(0)
					self:SetTurnMult(0)
					self.AnimationManipulator:SetRate( 0.5 ) 
					self.IsWaiting = true
					WaitFor( self.AnimationManipulator )
					self.IsWaiting = false
					##### ACTIVATION ARME PRINCIPALE ####
					self:SetWeaponEnabledByLabel( 'MainGun', true )
					self:SetWeaponEnabledByLabel( 'UpgradeGun01', true )
					self:SetUnSelectable(false)
				end )
			end
		end
	end,


	OnScriptBitClear = function( self, bit )
		TLandUnit.OnScriptBitClear( self, bit )
		if bit == 1 then 
			if self.AnimationManipulator then
				
				self:ForkThread( function()
					self:SetUnSelectable(true)
					WaitSeconds( self.AnimationManipulator:GetAnimationDuration() * self.AnimationManipulator:GetRate() )
					
					self.AnimationManipulator:SetRate(-0.5)
					self.IsWaiting = true
					WaitFor( self.AnimationManipulator )
					self.IsWaiting = false
					
					##### DÉSACTIVATION ARME PRINCIPALE ####
					self:SetWeaponEnabledByLabel( 'MainGun', false )
					self:SetWeaponEnabledByLabel( 'UpgradeGun01', false )

					IssueClearCommands( {self} )
					self:AddCommandCap( 'RULEUCC_Move' )
					self:SetSpeedMult( 1.0 )
					self:SetTurnMult( 1.0 )
					
					self:SetUnSelectable( false )
				end )
			end
		end
	end,

}

TypeClass = UEL0108
