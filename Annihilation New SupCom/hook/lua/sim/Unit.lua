
local oldUnit = Unit
Unit = Class(oldUnit) {

    -------------------------------------------------------------------------------------------
    -- TELEPORTING
    -------------------------------------------------------------------------------------------
    ---@param self Unit
    ---@param teleporter any
    ---@param location Vector
    ---@param orientation Quaternion
    OnTeleportUnit = function(self, teleporter, location, orientation)
 	    local id = self:GetEntityId()
        -- Teleport Cooldown Charge
        -- Range Check to location
        local maxRange = self:GetBlueprint().Defense.MaxTeleRange
        local myposition = self:GetPosition()
        local destRange = VDist2(location[1], location[3], myposition[1], myposition[3])
        if maxRange and destRange > maxRange then
            FloatingEntityText(id,'Destination Out Of Range')
            return
        end
		if not self:HasEnhancement('AdvancedTeleporter') then
			-- Teleport Blocker Check
			for num, brain in ArmyBrains do
				local unitList = brain:GetListOfUnits(categories.ALLUNITS, false)
				for i, unit in unitList do
					-- If it's an ally, then we skip.
					if IsEnemy(self:GetArmy(), unit:GetArmy()) then
						local blockerRange = unit:GetBlueprint().Defense.NoTeleDistance
						if blockerRange then
							local blockerPosition = unit:GetPosition()
							local targetDest = VDist2(location[1], location[3], blockerPosition[1], blockerPosition[3])
							local sourceCheck = VDist2(myposition[1], myposition[3], blockerPosition[1], blockerPosition[3])
							if blockerRange and blockerRange >= targetDest then
								FloatingEntityText(id, 'Teleport Destination Scrambled')
								return
							elseif blockerRange and blockerRange >= sourceCheck then
								FloatingEntityText(id, 'Teleport Source Location Scrambled')
								return
							end
						end
					end
				end
			end
		end
        -- Economy Check and Drain
        local bp = self:GetBlueprint()
        local telecost = bp.Economy.TeleportBurstEnergyCost or 0
        local mybrain = self:GetAIBrain()
        local storedenergy = mybrain:GetEconomyStored('ENERGY')
        if telecost > 0 and not self.TeleportCostPaid then
            if storedenergy >= telecost then
                mybrain:TakeResource('ENERGY', telecost)
                self.TeleportCostPaid = true
            else
                FloatingEntityText(id,'Insufficient Energy For Teleportation')
                return
            end
        end
		
		
        -- prevent cheats (teleporting while not having the upgrade)
        if not self:TestCommandCaps('RULEUCC_Teleport') then
            return
        end

        -- prevent cheats (teleport off map)
        if location[1] < 1 or location[1] > ScenarioInfo.PlayableArea[3] - 1 then
            return
        end

        -- prevent cheats (teleport off map)
        if location[3] < 1 or location[3] > ScenarioInfo.PlayableArea[4] - 1 then
            return
        end

        if self.TeleportDrain then
            RemoveEconomyEvent(self, self.TeleportDrain)
            self.TeleportDrain = nil
        end

        if self.TeleportThread then
            KillThread(self.TeleportThread)
            self.TeleportThread = nil
        end

        self:CleanupTeleportChargeEffects()
        self.TeleportThread = self:ForkThread(self.InitiateTeleportThread, teleporter, location, orientation)
    end,

    ---@param self Unit
    ---@param teleporter any
    ---@param location Vector
    ---@param orientation Quaternion

    -------------------------------------------------------
    -- The rest of the functions are added anew by BlackOps
    -------------------------------------------------------

    EXTeleportChargeEffects = function(self)
        if not self.Dead then
            local bpe = self:GetBlueprint().Economy
            self.EXPhaseEnabled = true
            self.EXPhaseCharge = 1
            self.EXPhaseShieldPercentage = 0
            if bpe then
                local mass = bpe.BuildCostMass * (bpe.TeleportMassMod or 0.01)
                local energy = bpe.BuildCostEnergy * (bpe.TeleportEnergyMod or 0.01)
                energyCost = mass + energy
                EXTeleTime = energyCost * (bpe.TeleportTimeMod or 0.01)
                self.EXTeleTimeMod1 = (EXTeleTime * 10) * 0.2
                self.EXTeleTimeMod2 = self.EXTeleTimeMod1 * 2
                self.EXTeleTimeMod3 = (EXTeleTime * 10) - ((self.EXTeleTimeMod1 * 2) + self.EXTeleTimeMod2)
                self.EXTeleTimeMod4 = (self.EXTeleTimeMod3) - 7
                local bp = self:GetBlueprint()
                local bpDisplay = bp.Display
                if self.EXPhaseCharge == 1 then
                    WaitTicks(self.EXTeleTimeMod1)
                end
                if self.EXPhaseCharge == 1 then
                    self:SetMesh(bpDisplay.Phase1MeshBlueprint, true)
                    self.EXPhaseShieldPercentage = 33
                    WaitTicks(self.EXTeleTimeMod2)
                end
                if self.EXPhaseCharge == 1 then
                    self.EXPhaseShieldPercentage = 66
                    WaitTicks(self.EXTeleTimeMod1)
                end
                if self.EXPhaseCharge == 1 then
                    self.EXPhaseShieldPercentage = 100
                    if self.EXTeleTimeMod3 >= 7 then
                        WaitTicks(self.EXTeleTimeMod4)
                    end
                end
                if self.EXPhaseCharge == 1 then self:SetMesh(bpDisplay.Phase2MeshBlueprint, true) end
            end
        end
    end,

    EXTeleportCooldownEffects = function(self)
        if not self.Dead then
            local bp = self:GetBlueprint()
            local bpDisplay = bp.Display
            self.EXPhaseCharge = 0
            if self.EXPhaseCharge == 0 then
                self.EXPhaseShieldPercentage = 100
                WaitTicks(5)
            end
            if self.EXPhaseCharge == 0 then
                self.EXPhaseShieldPercentage = 100
                self:SetMesh(bpDisplay.Phase1MeshBlueprint, true)
                WaitTicks(8)
            end
            if self.EXPhaseCharge == 0 then
                self.EXPhaseShieldPercentage = 75
                self:SetMesh(bpDisplay.Phase1MeshBlueprint, true)
                WaitTicks(25)
            end
            if self.EXPhaseCharge == 0 then
                self.EXPhaseShieldPercentage = 50
                self:SetMesh(bpDisplay.MeshBlueprint, true)
                WaitTicks(10)
                self.EXPhaseShieldPercentage = 0
                self.EXPhaseEnabled = false
            end
        end
    end,

    GetShouldCollide = function(self, collidefriendly, army1, army2)
        if not collidefriendly then
            if army1 == army2 or IsAlly(army1, army2) then
                return false
            end
        end
        return true
    end,

    ---@param self Unit
    OnFailedTeleport = function(self)
        if self.TeleportDrain then
            RemoveEconomyEvent(self, self.TeleportDrain)
            self.TeleportDrain = nil
        end

        if self.TeleportThread then
            KillThread(self.TeleportThread)
            self.TeleportThread = nil
        end

        self:StopUnitAmbientSound('TeleportLoop')
        self:CleanupTeleportChargeEffects()
        self:CleanupRemainingTeleportChargeEffects()
        self:SetWorkProgress(0.0)
        self:SetImmobile(false)
        self.UnitBeingTeleported = nil
		
        if not self.Dead and self.EXPhaseEnabled == true then
            self.EXPhaseEnabled = false
            self.EXPhaseCharge = 0
            self.EXPhaseShieldPercentage = 0

            local bpDisplay = self:GetBlueprint().Display
            self:SetMesh(bpDisplay.MeshBlueprint, true)
        end
    end,

    ---@param self Unit
    ---@param teleporter any
    ---@param location Vector
    ---@param orientation Quaternion
    InitiateTeleportThread = function(self, teleporter, location, orientation)
        self.UnitBeingTeleported = self
        self:SetImmobile(true)
        self:PlayUnitSound('TeleportStart')
        self:PlayUnitAmbientSound('TeleportLoop')

        local bp = self.Blueprint
        local teleDelay = bp.General.TeleportDelay
        local bpEco = bp.Economy
        local energyCost, time
        
        if bpEco then
            local mass = (bpEco.TeleportMassCost or bpEco.BuildCostMass or 1) * (bpEco.TeleportMassMod or 0.01)
            local energy = (bpEco.TeleportEnergyCost or bpEco.BuildCostEnergy or 1) * (bpEco.TeleportEnergyMod or 0.01)
            energyCost = mass + energy
            time = energyCost * (bpEco.TeleportTimeMod or 0.01)
        end

        if teleDelay then
            energyCostMod = (time + teleDelay) / time
            time = time + teleDelay
            energyCost = energyCost * energyCostMod

            self.TeleportDestChargeBag = nil
            self.TeleportCybranSphere = nil  -- this fixes some "...Game object has been destroyed" bugs in EffectUtilities.lua:TeleportChargingProgress

            self.TeleportDrain = CreateEconomyEvent(self, energyCost or 100, 0, time or 5, self.UpdateTeleportProgress)

            -- Create teleport charge effect + exit animation delay
            self:PlayTeleportChargeEffects(location, orientation, teleDelay)
            WaitFor(self.TeleportDrain)
        else
            self.TeleportDrain = CreateEconomyEvent(self, energyCost or 100, 0, time or 5, self.UpdateTeleportProgress)

            -- Create teleport charge effect
            self:PlayTeleportChargeEffects(location, orientation)
            WaitFor(self.TeleportDrain)
        end

        if self.TeleportDrain then
            RemoveEconomyEvent(self, self.TeleportDrain)
            self.TeleportDrain = nil
        end

        self:PlayTeleportOutEffects()
        self:CleanupTeleportChargeEffects()
        WaitSeconds(0.1)

        -- prevent cheats (teleporting after transport, teleporting without having the enhancement)
        if self:IsUnitState('Teleporting') and self:TestCommandCaps('RULEUCC_Teleport') then
            Warp(self, location, orientation)
            self:PlayTeleportInEffects()
        else
            IssueClearCommands({self})
        end



        self:SetWorkProgress(0.0)
        self:CleanupRemainingTeleportChargeEffects()

        -- Perform cooldown Teleportation FX here
		WaitSeconds(0.1)

        -- Landing Sound
        self:StopUnitAmbientSound('TeleportLoop')
        self:PlayUnitSound('TeleportEnd')
        self:SetImmobile(false)
        self.UnitBeingTeleported = nil
        self.TeleportThread = nil
		
        local bpp = self.Blueprint
        local telDelay = bpp.Defense.TelDelay
		
		if telDelay then
            self:RemoveCommandCap('RULEUCC_Teleport')
			self.TeleportDel = CreateEconomyEvent(self, 0, 0, telDelay, self.UpdateTeleportProgress)
			WaitSeconds(telDelay)
            self:AddCommandCap('RULEUCC_Teleport')
			if self.TeleportDel then
				RemoveEconomyEvent(self, self.TeleportDel)
				self.TeleportDel = nil
			end
        end

		--oldUnit.InitiateTeleportThread(self, teleporter, location, orientation)
	
    end,

    ---@param self Unit
    ---@param progress number
    UpdateTeleportProgress = function(self, progress)
        self:SetWorkProgress(progress)
        EffectUtilities.TeleportChargingProgress(self, progress)
    end,

    ---@param self Unit
    ---@param location Vector
    ---@param orientation Quaternion
    ---@param teleDelay? number
    PlayTeleportChargeEffects = function(self, location, orientation, teleDelay)
        self.TeleportFxBag = self.TeleportFxBag or TrashBag()
        EffectUtilities.PlayTeleportChargingEffects(self, location, self.TeleportFxBag, teleDelay)
    end,

    ---@param self Unit
    CleanupTeleportChargeEffects = function(self)
        self.TeleportCostPaid = false
        self.TeleportFxBag = self.TeleportFxBag or TrashBag()
        EffectUtilities.DestroyTeleportChargingEffects(self, self.TeleportFxBag)
    end,
	
    ---@param self Unit
    CleanupRemainingTeleportChargeEffects = function(self)
        self.TeleportFxBag = self.TeleportFxBag or TrashBag()
        EffectUtilities.DestroyRemainingTeleportChargingEffects(self, self.TeleportFxBag)
    end,

    ---@param self Unit
    PlayTeleportOutEffects = function(self)
        self.TeleportFxBag = self.TeleportFxBag or TrashBag()
        EffectUtilities.PlayTeleportOutEffects(self, self.TeleportFxBag)
    end,

    ---@param self Unit
    PlayTeleportInEffects = function(self)
        self.TeleportFxBag = self.TeleportFxBag or TrashBag()
        EffectUtilities.PlayTeleportInEffects(self, self.TeleportFxBag)
        if not self.Dead and self.EXPhaseEnabled == true then
            self.EXTeleportCooldownEffects(self)
        end
    end,

}
