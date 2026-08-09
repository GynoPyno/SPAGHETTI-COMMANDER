-- PlatoonFormManager.lua (hook)
-- Instrumentazione diagnostica temporanea (sess.73): stesso scopo di
-- hook/lua/sim/FactoryBuilderManager.lua, ma per Fase B ('OWPlus Outpost
-- Factory Upgrade', BuildersType='PlatoonFormBuilder'). A differenza di
-- FactoryBuilderManager (che decide via AssignBuildOrder su eventi di
-- completamento), PlatoonFormManager decide TUTTO dentro ManagerLoopBody,
-- richiamato dal loop periodico condiviso (BuilderManager.ManagerThread,
-- BuilderCheckInterval=5s per questo tipo di manager). Se GetBuilderStatus()
-- e CheckInstanceCount() sono veri ma nessun upgrade avviene mai (confermato
-- da SelectedBuilder assente in sess.71-73), il sospetto e' che
-- poolPlatoon:CanFormPlatoon(...) (ricerca spaziale del match GlobalSquads
-- entro FormRadius, interna al metodo originale, non duplicata qui) fallisca
-- silenziosamente — questo hook lo isola per eliminazione, loggando lo stato
-- appena PRIMA che il metodo originale tenti il form. Pattern di subclassing
-- identico a hook/lua/sim/FactoryBuilderManager.lua. Da rimuovere/silenziare
-- una volta diagnosticato.
--
-- Sess.98: usato temporaneamente per diagnosticare 'OWPlus Extractor Upgrade
-- T4' (confermato: poolPlatoon:CanFormPlatoon(...) tornava sempre false anche
-- con FormRadius=10000 esplicito -- causa nativa/compilata, non identificabile
-- a livello Lua). Diagnosi conclusa, builder rimosso (vedi 'OWPlus Economy
-- Upgrade.lua' e hook/lua/platoon.lua per il meccanismo sostitutivo) --
-- rimossa anche la relativa estensione diagnostica qui.
--
-- Sess.98 (bis): riusato per 'OWPlus Energy Generator Upgrade T4' -- il fix
-- BuildableCategory ha sbloccato il PRIMO upgrade (T4=1 confermato in game).
-- Diagnosi InstanceCount confermata (CheckInstanceCount=false permanente
-- dopo il primo successo) e fix implementato (subclass UnitUpgradeAI,
-- hook/lua/platoon.lua). Rimossa la chiamata diagnostica a CanFormPlatoon
-- qui: sospetto (non confermato) che chiamarla "a vuoto" come sonda possa
-- interferire con la chiamata reale del motore subito dopo (stessa risorsa
-- condivisa ArmyPool) -- un test successivo con questa sonda attiva ha
-- mostrato zero tentativi di upgrade nonostante candidati disponibili,
-- diversamente dal test precedente senza rilanci ravvicinati della sonda.
-- Da rivalutare se necessario, ma per ora si preferisce non rischiare falsi
-- negativi nei test futuri.

local prevClass = PlatoonFormManager

PlatoonFormManager = Class(prevClass) {
    ManagerLoopBody = function(self, builder, bType)
        if self.LocationType and self.Brain and self.Brain.OWPlusOutpostLocationTypes
            and self.Brain.OWPlusOutpostLocationTypes[self.LocationType]
            and builder.BuilderName and string.find(builder.BuilderName, 'OWPlus Outpost') then
            self.OWPlusDebugLastLog = self.OWPlusDebugLastLog or {}
            local now = GetGameTimeSeconds()
            local key = 'PFMLoopBody_' .. tostring(builder.BuilderName)
            if not self.OWPlusDebugLastLog[key] or now - self.OWPlusDebugLastLog[key] >= 5 then
                self.OWPlusDebugLastLog[key] = now
                local status = builder:GetBuilderStatus()
                local instOk = builder:CheckInstanceCount()
                LOG('[OWPlus-HOOK] PlatoonFormManager(' .. tostring(self.LocationType) .. '): builder "' .. tostring(builder.BuilderName)
                    .. '" GetBuilderStatus=' .. tostring(status) .. ' CheckInstanceCount=' .. tostring(instOk)
                    .. ' (se entrambi true e nessun upgrade avviene, il sospetto ricade su CanFormPlatoon/FormRadius, non loggato qui)')
            end
        end
        prevClass.ManagerLoopBody(self, builder, bType)
    end,
}
