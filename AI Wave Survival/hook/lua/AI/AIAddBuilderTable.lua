
local OLDAddGlobalBaseTemplate = AddGlobalBaseTemplate
function AddGlobalBaseTemplate(aiBrain, locationType, baseBuilderName)
    LOG('Injecting BuilderGroup -E Land Experimental Formers x2')
    AddGlobalBuilderGroup(aiBrain, locationType, 'E Land Experimental Formers')
    #AddGlobalBuilderGroup(aiBrain, locationType, 'E2 Land Experimental Formers')
    OLDAddGlobalBaseTemplate(aiBrain, locationType, baseBuilderName)
end
