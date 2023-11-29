do
	local oldModBP = ModBlueprints
	function ModBlueprints(all_bps)
		oldModBP(all_bps)

		local RangeModifier  = 3 --> Range multiplier for units added by mods and nomads, does not affect default units
		local ModifiedBlueprints  = {'uel0001','uel0301','uel0105','uel0208','uel0309','xel0209','xeb0104','xeb0204','xea3204',
		'url0001','url0301','url0105','url0208','url0309','xrb0104','xrb0204','xrb0304',
		'ual0001','ual0301','ual0105','ual0208','ual0309',
		'xsl0001','xsl0301','xsl0105','xsl0208','xsl0309'}
		--UEF
		--Cybran
		--Aeon
		--Seraphim
		for index,unit in all_bps.Unit do
			if unit.Categories
			and table.find(unit.Categories,'ENGINEER') then
				if unit.Description then
					unitID = string.sub(unit.Description,6,12)
					if not table.find(ModifiedBlueprints,unitID)
					and not table.find(unit.Categories,'RALLYPOINT') then
						if unit.Economy.MaxBuildDistance then
							unit.Economy.MaxBuildDistance = unit.Economy.MaxBuildDistance * RangeModifier
						else
							unit.Economy.MaxBuildDistance = 5 * RangeModifier
						end
					end
				end
			end
			
		end
	end
end