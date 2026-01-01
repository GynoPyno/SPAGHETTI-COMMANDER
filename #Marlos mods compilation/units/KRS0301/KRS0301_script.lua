#****************************************************************************
#**
#**  File     :  
#**  Author(s):  
#**
#**  Summary  :  Cybran Battleship Script
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CSubUnit = import('/lua/cybranunits.lua').CSubUnit
local CIFGrenadeWeapon = import('/lua/cybranweapons.lua').CIFGrenadeWeapon
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon
local CDFProtonCannonWeapon = import('/lua/cybranweapons.lua').CDFProtonCannonWeapon
local CANNaniteTorpedoWeapon = import('/lua/cybranweapons.lua').CANNaniteTorpedoWeapon
       
KRS0301 = Class(CSubUnit) {
    Weapons = {
        FrontCannon01 = Class(CDFProtonCannonWeapon) {},
        BackCannon01 = Class(CDFProtonCannonWeapon) {},
        Torpedo01 = Class(CANNaniteTorpedoWeapon) {},
        Torpedo02 = Class(CANNaniteTorpedoWeapon) {},
        AAGun01 = Class(CAAAutocannon) {},
        AAGun02 = Class(CAAAutocannon) {},
        AAGun03 = Class(CAAAutocannon) {},
        AAGun04 = Class(CAAAutocannon) {},
        Sidearm01 = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
        Sidearm02 = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
        Sidearm03 = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
        Sidearm04 = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
        Sidearm05 = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
        Sidearm06 = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
        Sidearm07 = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
        Sidearm08 = Class(CIFGrenadeWeapon) {
            FxMuzzleFlash = {
                '/effects/emitters/cybran_artillery_muzzle_flash_01_emit.bp',
                '/effects/emitters/cybran_artillery_muzzle_flash_02_emit.bp',
                '/effects/emitters/cannon_muzzle_smoke_02_emit.bp',
            },
            FxMuzzleFlashScale = 0.5,
        },
    },

    OnCreate = function(self)
        CSubUnit.OnCreate(self)
        self.OpenAnimManips = {}
        self.OpenAnimManips[1] = CreateAnimator(self):PlayAnim('/Mods/#Marlos mods compilation/units/KRS0301/KRS0301_aopen.sca'):SetRate(-1)
        for k, v in self.OpenAnimManips do
            self.Trash:Add(v)
        end
        if self:GetCurrentLayer() == 'Water' then
            self:PlayAllOpenAnims(true)
        end
    end,
	
    PlayAllOpenAnims = function(self, open)
        for k, v in self.OpenAnimManips do
            if open then
                v:SetRate(1)
            else
                v:SetRate(-1)
            end
        end
    end,
	
    OnMotionVertEventChange = function( self, new, old )
        CSubUnit.OnMotionVertEventChange(self, new, old)
        if new == 'Down' then
            self:PlayAllOpenAnims(false)
        elseif new == 'Top' then
            self:PlayAllOpenAnims(true)
        end
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        --- Unless we're gifted, we should have an original builder.
        --- Remains to be seen if this property is actually copied during gift
        CSubUnit.OnStopBeingBuilt(self,builder,layer)
        if self.originalBuilder then
            IssueDive({self})
        end
        if(self:GetCurrentLayer() == 'Water') then
			# Enable weapon
			self:SetWeaponEnabledByLabel('FrontCannon01', true)
			self:SetWeaponEnabledByLabel('BackCannon01', true)
			self:SetWeaponEnabledByLabel('AAGun01', true)
			self:SetWeaponEnabledByLabel('AAGun02', true)
			self:SetWeaponEnabledByLabel('AAGun03', true)
			self:SetWeaponEnabledByLabel('AAGun04', true)
			self:SetWeaponEnabledByLabel('Sidearm01', true)
			self:SetWeaponEnabledByLabel('Sidearm02', true)
			self:SetWeaponEnabledByLabel('Sidearm03', true)
			self:SetWeaponEnabledByLabel('Sidearm04', true)
			self:SetWeaponEnabledByLabel('Sidearm05', true)
			self:SetWeaponEnabledByLabel('Sidearm06', true)
			self:SetWeaponEnabledByLabel('Sidearm07', true)
			self:SetWeaponEnabledByLabel('Sidearm09', true)
        elseif (self:GetCurrentLayer() == 'UnderWater') then
			# Disable Weapon
			self:SetWeaponDisableByLabel('MainGun', false)
			self:SetWeaponDisableByLabel('FrontCannon01', true)
			self:SetWeaponDisableByLabel('BackCannon01', true)
			self:SetWeaponDisableByLabel('AAGun01', true)
			self:SetWeaponDisableByLabel('AAGun02', true)
			self:SetWeaponDisableByLabel('AAGun03', true)
			self:SetWeaponDisableByLabel('AAGun04', true)
			self:SetWeaponDisableByLabel('Sidearm01', true)
			self:SetWeaponDisableByLabel('Sidearm02', true)
			self:SetWeaponDisableByLabel('Sidearm03', true)
			self:SetWeaponDisableByLabel('Sidearm04', true)
			self:SetWeaponDisableByLabel('Sidearm05', true)
			self:SetWeaponDisableByLabel('Sidearm06', true)
			self:SetWeaponDisableByLabel('Sidearm07', true)
			self:SetWeaponDisableByLabel('Sidearm09', true)
       end
       self.WeaponsEnabled = true
    end,
	OnLayerChange = function(self, new, old)
		CSubUnit.OnLayerChange(self, new, old)
		if self.WeaponsEnabled then
			if( new == 'Water' ) then
				# Enable Land Weapons
				self:SetWeaponEnabledByLabel('FrontCannon01', true)
				self:SetWeaponEnabledByLabel('BackCannon01', true)
				self:SetWeaponEnabledByLabel('AAGun01', true)
				self:SetWeaponEnabledByLabel('AAGun02', true)
				self:SetWeaponEnabledByLabel('AAGun03', true)
				self:SetWeaponEnabledByLabel('AAGun04', true)
				self:SetWeaponEnabledByLabel('Sidearm01', true)
				self:SetWeaponEnabledByLabel('Sidearm02', true)
				self:SetWeaponEnabledByLabel('Sidearm03', true)
				self:SetWeaponEnabledByLabel('Sidearm04', true)
				self:SetWeaponEnabledByLabel('Sidearm05', true)
				self:SetWeaponEnabledByLabel('Sidearm06', true)
				self:SetWeaponEnabledByLabel('Sidearm07', true)
				self:SetWeaponEnabledByLabel('Sidearm09', true)
			elseif ( new == 'UnderWater' ) then
				# Disable Land Weapons
				self:SetWeaponDisableByLabel('MainGun', false)
				self:SetWeaponDisableByLabel('FrontCannon01', true)
				self:SetWeaponDisableByLabel('BackCannon01', true)
				self:SetWeaponDisableByLabel('AAGun01', true)
				self:SetWeaponDisableByLabel('AAGun02', true)
				self:SetWeaponDisableByLabel('AAGun03', true)
				self:SetWeaponDisableByLabel('AAGun04', true)
				self:SetWeaponDisableByLabel('Sidearm01', true)
				self:SetWeaponDisableByLabel('Sidearm02', true)
				self:SetWeaponDisableByLabel('Sidearm03', true)
				self:SetWeaponDisableByLabel('Sidearm04', true)
				self:SetWeaponDisableByLabel('Sidearm05', true)
				self:SetWeaponDisableByLabel('Sidearm06', true)
				self:SetWeaponDisableByLabel('Sidearm07', true)
				self:SetWeaponDisableByLabel('Sidearm09', true)
			end
		end
	end,
}
TypeClass = KRS0301