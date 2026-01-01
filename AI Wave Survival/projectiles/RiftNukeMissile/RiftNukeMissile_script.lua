--
-- Terran Nuke Missile
--
local TIFMissileNuke = import("/lua/terranprojectiles.lua").TIFMissileNuke
local utilities = import('/lua/utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

RiftNukeMissile = ClassProjectile(TIFMissileNuke) {

    InitialEffects = {'/effects/emitters/nuke_munition_launch_trail_02_emit.bp',},
    LaunchEffects = {
        '/effects/emitters/nuke_munition_launch_trail_03_emit.bp',
        '/effects/emitters/nuke_munition_launch_trail_05_emit.bp',
        '/effects/emitters/nuke_munition_launch_trail_07_emit.bp',
    },
    ThrustEffects = {
        '/effects/emitters/nuke_munition_launch_trail_04_emit.bp',
        '/effects/emitters/nuke_munition_launch_trail_06_emit.bp',
    },

    OnCreate = function(self)
        TIFMissileNuke.OnCreate(self)
        self.effectEntityPath = '/effects/Entities/UEFNukeEffectController01/UEFNukeEffectController01_proj.bp'
        self:LauncherCallbacks()
    end,
	
	OnImpact = function(self, TargetType, targetEntity)
		
		TIFMissileNuke.OnImpact( self, TargetType, targetEntity )
		local position = self:GetPosition()
		local spiritUnit = CreateUnitHPR('RIFTORB2', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
		self:Destroy()
	end,	
	
	OnKilled = function(self)
		local position = self:GetPosition()
		local spiritUnit = CreateUnitHPR('RMARKER', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
		self:Destroy()
	end,
}

TypeClass = RiftNukeMissile