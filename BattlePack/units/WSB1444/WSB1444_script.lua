#****************************************************************************
#**
#**  File     :  /data/units/XAB1401/XAB1401_script.lua
#**  Author(s):  Jessica St. Croix, Dru Staltman
#**
#**  Summary  :  Seraphim Quantum Resource Generator
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SStructureUnit = import('/lua/aeonunits.lua').AStructureUnit
local DeathNukeWeapon = import('/lua/sim/defaultweapons.lua').BattleNukeDeathWeapon

WSB1444 = Class(SStructureUnit) {

    Weapons = {
        DeathWeapon = Class(DeathNukeWeapon) {},
    },
    AirEffects = {
                  '/effects/emitters/hydrocarbon_heatshimmer_01_emit.bp'
                },
    AirEffectsBones = {'Exhaust01','Exhaust02','Exhaust03','Exhaust04',},

    OnStopBeingBuilt = function(self, builder, layer)
        SStructureUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Spinner', 'y', nil, 90))
        
        ChangeState( self, self.ResourceOn )
        self:ForkThread(self.ResourceMonitor)

        local effects = {}
        local bones = {}
        local scale = 0.75
        if self:GetCurrentLayer() == 'Land' then
            effects = self.AirEffects
            bones = self.AirEffectsBones
        elseif self:GetCurrentLayer() == 'Seabed' then
            effects = self.WaterEffects
            bones = self.WaterEffectsBones
            scale = 3
        end
        for keys, values in effects do
            for keysbones, valuesbones in bones do
                self.Trash:Add(CreateAttachedEmitter(self, valuesbones, self:GetArmy(), values):ScaleEmitter(scale):OffsetEmitter(0,-0.2,1))
            end
        end
            
        local bp = self:GetBlueprint().Display
        self.LoopAnimation = CreateAnimator(self)
        self.LoopAnimation:PlayAnim(bp.LoopingAnimation, true)
        self.LoopAnimation:SetRate(0.5)
        self.Trash:Add(self.LoopAnimation)
    end,
        
    ResourceOn = State {
        Main = function(self)
            local aiBrain = self:GetAIBrain()
            local massAdd = 0
            local energyAdd = 0
            local maxMass = self:GetBlueprint().Economy.MaxMass
            local maxEnergy = self:GetBlueprint().Economy.MaxEnergy
            
            while true do
                local massNeed = aiBrain:GetEconomyRequested('MASS') * 10
                local energyNeed = aiBrain:GetEconomyRequested('ENERGY') * 10

                local massIncome = (aiBrain:GetEconomyIncome( 'MASS' ) * 10) - massAdd
                local energyIncome = (aiBrain:GetEconomyIncome( 'ENERGY' ) * 10) - energyAdd
                
                massAdd = 20
                if massNeed - massIncome > 0 then
                    massAdd = massAdd + massNeed - massIncome
                end
                
                if maxMass and massAdd > maxMass then
                   massAdd = maxMass
                end
                self:SetProductionPerSecondMass(massAdd)

                energyAdd = 1000
                if energyNeed - energyIncome > 0 then
                    energyAdd = energyAdd + energyNeed - energyIncome
                end
                if maxEnergy and energyAdd > maxEnergy then
                    energyAdd = maxEnergy
                end
                self:SetProductionPerSecondEnergy(energyAdd)

                WaitSeconds(.5)
            end
        end,
    },
}

TypeClass = WSB1444