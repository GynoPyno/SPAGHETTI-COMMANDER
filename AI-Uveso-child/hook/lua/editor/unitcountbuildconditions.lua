-- AI-Uveso-child: hook unitcountbuildconditions.lua
-- Fase 9-F28 (fix B12): UnitsLessInPlatoon (stock Uveso) chiama Platoon:GetPlan()
-- su ogni elemento di aiBrain:GetPlatoonsList() senza controllare se quel
-- metodo esiste davvero. Confermato in sess.66 (dev.log ricorrente):
--   attempt to call method 'GetPlan' (a nil value)
-- Alcuni elementi della lista a volte non hanno il metodo GetPlan (motivo non
-- chiarito — probabile residuo di merge/disband di un plotone), e il crash
-- interrompe la valutazione della condizione. Sospettato come causa (insieme a
-- PlatoonMerger, vedi platoon.lua) dell'esercito pieno di unita' che non
-- lancia mai un attacco su vasta scala.
--
-- Fix: aggiunta guardia difensiva "Platoon and Platoon.GetPlan and" prima di
-- chiamare :GetPlan() — se l'elemento non ha il metodo, viene semplicemente
-- saltato invece di far crashare l'intera valutazione. Nessun'altra logica
-- modificata rispetto all'originale.

--            { UCBC, 'UnitsLessInPlatoon', {} },
function UnitsLessInPlatoon(aiBrain, PlatoonPlan, num, cat)
    local SearchCat = cat or categories.ALLUNITS
    local PlatoonList = aiBrain:GetPlatoonsList()
    local NumPlatoonUnits = 0
    local PlatoonFound
    for Li, Platoon in PlatoonList do
        if Platoon and Platoon.GetPlan and Platoon:GetPlan() == PlatoonPlan then
            PlatoonFound = true
            for Ui, Unit in Platoon:GetPlatoonUnits() or {} do
                if EntityCategoryContains(cat, Unit) then
                    NumPlatoonUnits = NumPlatoonUnits + 1
                end
            end
            break
        end
    end
    if not PlatoonFound then
        -- in case the platoon is not formed yet, just return false.
        -- so the platoonformer does not try to add the unit to an non existing platoon
        return false
    end
    if NumPlatoonUnits < num then
        return true
    end
    return false
end
