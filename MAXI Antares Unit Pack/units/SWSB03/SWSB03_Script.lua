local SAirFactoryUnit = import('/lua/seraphimunits.lua').SAirFactoryUnit

SWSB03 = Class(SAirFactoryUnit) {

    OnStopBeingBuilt = function(self,builder,layer)
	local army = self:GetArmy()
        SAirFactoryUnit.OnStopBeingBuilt(self,builder,layer)

        self.Trash:Add(CreateRotator(self, 'Pod01', 'z', nil, 50, 0, 50))
	self.Trash:Add(CreateRotator(self, 'Pod02', 'z', nil, -50, 0, -50))
	self.Trash:Add(CreateRotator(self, 'Pod03', 'z', nil, 50, 0, 50))
	self.Trash:Add(CreateRotator(self, 'Pod04', 'z', nil, -50, 0, -50))
	self.Trash:Add(CreateRotator(self, 'Pod06', 'z', nil, 50, 0, 50))
	self.Trash:Add(CreateRotator(self, 'Pod05', 'z', nil, -50, 0, -50))
    end,

}

TypeClass = SWSB03