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
