do
    local UnitOld = Unit
    local BrewLANPath = import( '/lua/game.lua' ).BrewLANPath
    local TerrainUtils = import(BrewLANPath .. '/lua/TerrainUtils.lua')
    local GetTerrainAngles = TerrainUtils.GetTerrainSlopeAnglesDegrees
    local OffsetBoneToTerrain = TerrainUtils.OffsetBoneToTerrain

    Unit = Class(UnitOld) {

        -- Triggers when this unit is started being built when a builder tries
        -- to build something with a `bp.General.SeedUnit` value instead.
        -- Args are self, and the ID of the seeder unit
        OnSeedUnitBuilt = function(self, seederID)
            if UnitOld.OnSeedUnitBuilt then
                UnitOld.OnSeedUnitBuilt(self, seederID)
            end
            _ALERT("OnSeedUnitBuilt", seederID)
        end,

        OnPreCreate = function(self)
            UnitOld.OnPreCreate(self)
            if not self.BpId then
                self.BpId = self:GetBlueprint().BlueprintId
            end
        end,

        OnStopBeingBuilt = function(self, builder, layer, ...)
            UnitOld.OnStopBeingBuilt(self, builder, layer, unpack(arg))
            local bp = __blueprints[self.BpId]

            --
            -- For buildings that don't flatten skirt to slope with the terrain
            --
            local layer = self:GetCurrentLayer()
            if not bp.Physics.FlattenSkirt and bp.Physics.SlopeToTerrain and not self.TerrainSlope and (layer == 'Land' or layer == 'Seabed') then

                local Angles = GetTerrainAngles(self:GetPosition(),{bp.Footprint.SizeX or bp.Physics.SkirtSizeX, bp.Footprint.SizeZ or bp.Physics.SkirtSizeZ})
                local Axis = bp.Physics.SlopeToTerrainAxis

                if Axis.InvertAxis then
                    for i, v in Angles do
                        if Axis.InvertAxis[i] then
                            Angles[i] = -v
                        end
                    end
                end
                self.TerrainSlope = {
                    CreateRotator(self, 0, Axis and Axis.Axis1 or 'z', -Angles[1], 99999),
                    CreateRotator(self, 0, Axis and Axis.Axis2 or 'x', Angles[2], 99999)
                }
            end
            if not bp.Physics.FlattenSkirt and bp.Physics.AltitudeToTerrain then
                if not self.TerrainSlope then
                    self.TerrainSlope = {}
                end
                for i, v in bp.Physics.AltitudeToTerrain do
                    OffsetBoneToTerrain(self, type(v) == 'table' and v[1] or v)
                end
            end

            --
            -- Checks for satellite allowances
            --
            if EntityCategoryContains(categories.SATELLITEUPLINK + categories.SATELLITEWITHNOPARENTALSUPERVISION, self) then
                self:ForkThread(
                    function()
                        coroutine.yield(1) -- UEF buildings get ignored without this delay. Why does the UEF build animation cause so many timing issues.
                        self:OnSatelliteCapacityChange()
                    end
                )
            end
        end,

        --
        -- Shield impacts for drop pods
        --
        FallenFromPod = function(self, ImpactY)
            local pos = self:GetPosition()
            local FallenD = ImpactY - pos[2]
            self:SetStunned(FallenD * 3)
            local bp = __blueprints[self.BpId]
            self:OnDamage(self, (bp.Defense.MaxHealth or 300) * (bp.SizeX or 1) * (bp.SizeY or 1) * (bp.SizeZ or 1) * (FallenD / 15), pos, 'Normal')
        end,

        --
        -- Checks for satellite allowances
        --
        OnSatelliteCapacityChange = function(self, deathcheck)
            -- Gather data
            local AIBrain = self:GetAIBrain()  -- (entityCategory, needToBeIdle, requireBuilt)
            local uplinks = AIBrain:GetListOfUnits(categories.SATELLITEUPLINK, false, true)
            local satellites = AIBrain:GetListOfUnits(categories.SATELLITEWITHNOPARENTALSUPERVISION, false, false) --requireBuilt true here makes it easy to exceed the cap
            -- Remove self from list if death check
            if deathcheck then
                if EntityCategoryContains(categories.SATELLITEUPLINK, self) then
                    table.removeByValue(uplinks, self)
                end
                if EntityCategoryContains(categories.SATELLITEWITHNOPARENTALSUPERVISION, self) then
                    table.removeByValue(satellites, self)
                end
            end
            -- If this is being called by something dying, check we are allowed satellites
            if deathcheck and table.getn(uplinks) == 0 and table.getn(satellites) > 0 then
                for i, v in satellites do
                    --LOG(v.StartUnguidedOrbitalDecay)
                    if v.StartUnguidedOrbitalDecay then
                        v:StartUnguidedOrbitalDecay(v)
                    else
                        v:Kill()
                    end
                end
            else
                -- calculate if we should allow more construction
                -- prep some vars
                local usedcap, maxcap = 0, 0
                -- Calculate max capacity
                for i, v in uplinks do
                    maxcap = maxcap + (__blueprints[v.BpId].General.SatelliteCapacity or 1)
                end
                -- calculate used capacity
                for i, v in satellites do
                    usedcap = usedcap + (__blueprints[v.BpId].General.CapCost or 1)
                    -- Prevent preventable satellite explosions
                    if v.UnguidedOrbitalDecay then
                        v:StopUnguidedOrbitalDecay(v)
                    end
                end
                -- should we allow more?
                -- Doesn't currently take into account the potential for satellites that use more than 1 capacity.
                -- Don't know if I care.
                if (maxcap - usedcap) < 1 then
                    --This is done per-unit to prevent any conflicts with R&D unlock satellites, and potential game restrictions.
                    --Is it more costly to check it can actually build, and or build satellites first, or do it and not care?
                    for i, v in uplinks do
                        v:AddBuildRestriction(categories.SATELLITEWITHNOPARENTALSUPERVISION)
                    end
                else
                    for i, v in uplinks do
                        v:RemoveBuildRestriction(categories.SATELLITEWITHNOPARENTALSUPERVISION)
                    end
                end
                self:RequestRefreshUI() -- worth checking if it actually needs a refresh?
            end
        end,

        --
        -- For Excalibur
        --
        OnCollisionCheck = function(self, other, firingWeapon)
            local hit = UnitOld.OnCollisionCheck(self, other, firingWeapon)
            if hit and other.DamageData.DamageType == 'Railgun' then
                --other:OnImpact( 'Unit', self)
                other.DamageData.DamageRadius = 0-- 0 the radius so that the damage doesn't happen somewhere random.
                other:DoDamage( other:GetLauncher(), other.DamageData, self)
                --other:DoMetaImpact(other.damageData )
                other:DoUnitImpactBuffs(other.targetEntity)

                local ImpactEffects = {}
                local ImpactEffectScale = 1
                local army = other:GetArmy()
                local bp = __blueprints[other.BpId]
                local bpAud = bp.Audio
                local snd = bpAud['ImpactUnit']
                if snd then
                    other:PlaySound(snd)
                elseif bpAud.Impact then
                    other:PlaySound(bpAud.Impact)
                end
                ImpactEffects = other.FxImpactUnit
                ImpactEffectScale = other.FxUnitHitScale
                if other.CreateRailGunImpactEffects then
                    other:CreateRailGunImpactEffects( army, ImpactEffects, ImpactEffectScale, self )
                else
                    other:CreateImpactEffects( army, ImpactEffects, ImpactEffectScale )
                end
                return false
            end
            return hit
        end,

        --
        -- UI/control fix so units that don't usually have a stop button can stop upgrading.
        --
        OnStartBuild = function(self, unitBeingBuilt, order, ...)
            local myBp = __blueprints[self.BpId]
            if myBp.General.UpgradesTo and unitBeingBuilt:GetUnitId() == myBp.General.UpgradesTo and order == 'Upgrade' then
                if not myBp.General.CommandCaps.RULEUCC_Stop then
                    self:AddCommandCap('RULEUCC_Stop')
                    self.CouldntStop = true
                end
            end
            return UnitOld.OnStartBuild(self, unitBeingBuilt, order, unpack(arg))
        end,

        OnStopBuild = function(self, unitBeingBuilt, ...)
            if self.CouldntStop then
                self:RemoveCommandCap('RULEUCC_Stop')
                self.CouldntStop = false
            end
            return UnitOld.OnStopBuild(self, unitBeingBuilt, unpack(arg))
        end,

        OnFailedToBuild = function(self, ...)
            if self.CouldntStop then
                self:RemoveCommandCap('RULEUCC_Stop')
                self.CouldntStop = nil
            end
            return UnitOld.OnFailedToBuild(self, unpack(arg))
        end,

        --
        -- Fix for bombers killing themselves against the Iron Curtain
        --
        OnDamage = function(self, instigator, amount, vector, damageType, ...)
            if damageType == 'NormalBomb' and EntityCategoryContains(categories.BOMBER, self) and self:GetCurrentLayer() == 'Air' then
                UnitOld.OnDamage(self, instigator, amount * 0.05 , vector, 'Normal', unpack(arg))
            else
                UnitOld.OnDamage(self, instigator, amount, vector, 'Normal', unpack(arg))
            end
        end,

        --
        -- Checks for satellite allowances
        --
        OnKilled = function(self, instigator, type, overkillRatio)
            if EntityCategoryContains(categories.SATELLITEUPLINK + categories.SATELLITEWITHNOPARENTALSUPERVISION, self) then
                self:OnSatelliteCapacityChange(true)
            end
            UnitOld.OnKilled(self, instigator, type, overkillRatio)
        end,

        OnDestroy = function(self)
            if EntityCategoryContains(categories.SATELLITEUPLINK + categories.SATELLITEWITHNOPARENTALSUPERVISION, self) then
                self:OnSatelliteCapacityChange(true)
            end
            UnitOld.OnDestroy(self)
        end,
    }
end
