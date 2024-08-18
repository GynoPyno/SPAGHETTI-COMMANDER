local TArtilleryAntiMatterProjectile = import('/lua/terranprojectiles.lua').TArtilleryAntiMatterSmallProjectile

SingleNukeShell2 = Class(TArtilleryAntiMatterProjectile) {

    
    
    OnImpact = function(self, targetType, targetEntity)
       TArtilleryAntiMatterProjectile.OnImpact(self, targetType, targetEntity)
       
       
        
  ##------------------------##
  ##   Specify Nuke Traits  ##
  ##------------------------##
          
          local Data = {
	 
	 
	 		    NukeInnerRingDamage = 24000,
	 		    NukeInnerRingRadius = 24,
	 		    NukeInnerRingTicks = 48,
	 		    NukeInnerRingTotalTime = 48,
	 		    
	 		    NukeOuterRingDamage = 2400,
	 		    NukeOuterRingRadius = 36,
	 		    NukeOuterRingTicks = 36,
	 		    NukeOuterRingTotalTime = 12,	 
	 
	    }     
       
	   
	   
	   
  ##------------------------##
  ##        4 STEPS         ##
  ##------------------------##
  
          
          ##------------------------------##
	  ##   Step 1: Create Projectile  ##
          ##------------------------------##
          
	   local proj =  self:CreateProjectile('/effects/Entities/UEFNukeEffectController01/UEFNukeEffectController01_proj.bp', 0, 0, 0, nil, nil, nil):SetCollision(false)
	   
	  ##-----------------------------------------##
	  ##   Step 2: Give Nuke Data to Projectile  ##
          ##-----------------------------------------##
          
	   proj:PassData(Data)
	   
	   
	  ##-----------------------------------##
	  ##   Step 3: Get position of Impact  ##
          ##-----------------------------------##          
          
	   local pos = self:GetPosition()  


          ##------------------------------------------------##
	  ##   Step 4: Spawn Projectile at Point of Impact  ##
          ##------------------------------------------------##
          
	   Warp(proj, pos)     
   
    
      end,
}
TypeClass = SingleNukeShell2


