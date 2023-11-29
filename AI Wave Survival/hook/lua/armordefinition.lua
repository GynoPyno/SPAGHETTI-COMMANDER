newStructure = {
    -- Armor Type Name
    'ExperimentalStructure',

    -- Armor Definition
    'Normal 1.0',
    'Overcharge 2.5',
    'Deathnuke 0.032',
    'ExperimentalFootfall 0.0',
    'CzarBeam 0.33',
	'OtheTacticalBomb 1.75',
	'Nuke 0.5',
}

do

function hookInsert(newTable)
    for key, armorTable in armordefinition do
        for index, str in armorTable do
            if newTable[1] == str then
                armordefinition[key] = newTable
                break
            end
        end
    end
end

hookInsert(newStructure)

end
