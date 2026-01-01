local AArtilleryFragmentationSensorShellProjectile = import('/lua/aeonprojectiles.lua').AArtilleryFragmentationSensorShellProjectile03
local EffectTemplate = import('/lua/EffectTemplates.lua')
local RandomFloat = import('/lua/utilities.lua').GetRandomFloat

AIFFragmentationSensorShell031 = Class(AArtilleryFragmentationSensorShellProjectile) {
    OnImpact = function(self, TargetType, targetEntity)
        local rotation = RandomFloat(0,2*math.pi)
        local size = RandomFloat(2.25,3.75)
        
        CreateDecal(self:GetPosition(), rotation, 'scorch_004_albedo', '', 'Albedo', size, size, 300, 15, self:GetArmy())
 
        AArtilleryFragmentationSensorShellProjectile.OnImpact( self, TargetType, targetEntity )
    end,	
}
TypeClass = AIFFragmentationSensorShell031