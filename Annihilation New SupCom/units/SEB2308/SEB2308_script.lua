--------------------------------------------------------------------------------
--  Summary  :  UEF Heavy Torpedo Launcher Script
--------------------------------------------------------------------------------
local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local TANTorpedoAngler = import('/lua/terranweapons.lua').TANTorpedoAngler
--------------------------------------------------------------------------------
SEB2308 = Class(TStructureUnit) {
    UpsideDown = false,
    Weapons = {
        Torpedo = Class(TANTorpedoAngler) {},
    },

    HideLandBones = function(self)
    --    TStructureUnit.HideLandBones(self)
        local pos = self:GetPosition()
        if pos[2] == GetTerrainHeight(pos[1],pos[3]) then
            for k, v in self.LandBuiltHiddenBones do
                if self:IsValidBone(v) then
                    self:HideBone(v, true)
                end
            end
        end
        --LOG(pos[2])
    end,
	
    OnStopBeingBuilt = function(self, builder, layer)
        TStructureUnit.OnStopBeingBuilt(self, builder, layer)
        local pos = self:GetPosition()
        if pos[2] ~= GetTerrainHeight(pos[1],pos[3]) then
			self:StartSinkingFromBuild()
			ChangeState(self, self.IdleState)
        end
    end,
	
    StartSinkingFromBuild = function(self)
        local position = self:GetPosition()
        if GetSurfaceHeight(position[1], position[3]) > position[2] then return end

        local bone = 0
        local proj = self:CreateProjectileAtBone('/projectiles/Sinker/Sinker_proj.bp', bone)
        self.sinkProjectile = proj

        proj:SetLocalAngularVelocity(0, 0, 0)
        proj:Start(0, self, bone)
        proj:SetBallisticAcceleration(-0.75)
        self.Trash:Add(proj)
        self.Depthwatcher = self.Trash:Add(ForkThread(self.DepthWatcher,self))
    end,

    DepthWatcher = function(self)
        self.sinkingFromBuild = true

        local sinkFor = 3.4
        while self.sinkProjectile and sinkFor > 0 do
            WaitTicks(1)
            sinkFor = sinkFor - 0.1
        end

        local bottom = true
        if not self.Dead then
            if self.sinkProjectile then
                bottom = false
                self.sinkProjectile:Destroy()
                self.sinkProjectile = nil
            end

            self:SetPosition(self:GetPosition(), true)
            self:FinalAnimation()
        end

        self.sinkingFromBuild = false
        self.Bottom = bottom
    end,

    FinalAnimation = function(self)
    --    local bp = self.Blueprint
    --    local bpAnim = bp.Display.AnimationDeploy

    --    self.OpenAnim = CreateAnimator(self)
    --    self.OpenAnim:PlayAnim(bpAnim)
    --    self.Trash:Add(self.OpenAnim)
    --    self:PlaySound(bp.Audio.Deploy)

        local pos = self:GetPosition()

        for _, army in self.SpottedByArmy or {} do
            VizMarker({ X = pos[1], Z = pos[3], Radius = 4, LifeTime = 0.3, Army = army, Vision = true, })
        end
    end,
	
	
}

TypeClass = SEB2308
