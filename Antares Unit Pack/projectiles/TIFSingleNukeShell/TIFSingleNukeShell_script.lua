local TArtilleryAntiMatterProjectile = import('/lua/terranprojectiles.lua').TArtilleryAntiMatterProjectile02
TIFSingleNukeShell = Class(TArtilleryAntiMatterProjectile) {
    OnImpact = function(self, targetType, targetEntity)
       TArtilleryAntiMatterProjectile.OnImpact(self, targetType, targetEntity)
       
       
        
  ##------------------------##
  ##   Specify Nuke Traits  ##
  ##------------------------##
          
          local Data = {
	 
	 
	 		    NukeInnerRingDamage = 70000,
	 		    NukeInnerRingRadius = 30,
	 		    NukeInnerRingTicks = 30,
	 		    NukeInnerRingTotalTime = 24,
	 		    
	 		    NukeOuterRingDamage = 5000,
	 		    NukeOuterRingRadius = 40,
	 		    NukeOuterRingTicks = 40,
	 		    NukeOuterRingTotalTime = 35,
	 
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
          
           proj:PassDamageData(self.DamageData)
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
TypeClass = TIFSingleNukeShell