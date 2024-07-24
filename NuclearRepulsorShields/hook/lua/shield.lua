
local OldShield = Shield

Shield = Class(OldShield) {

    -- Return true to process this collision, false to ignore it.
    OnCollisionCheck = function(self, other)
        if not self.GetArmy or not other.GetArmy then
            return OldShield.OnCollisionCheck(self, other)
        end

        if other:GetArmy() == -1 then
            return false
        end
        
        -- Don't allow strategic nuke missile to penetrate enemy shields
        if EntityCategoryContains(categories.STRATEGIC, other) and
            EntityCategoryContains(categories.MISSILE, other) then
            return IsEnemy(self:GetArmy(),other:GetArmy())
        end
        
        -- execute the normal OnCollisionCheck for non stretegic missiles
        return OldShield.OnCollisionCheck(self, other)
    end,
    
    GetOverlappingShields = function(self, tick)
        return { }, 0
    end,

}
