-- FactoryBuilderManager.lua (hook)
-- Instrumentazione diagnostica temporanea (sess.73): capire perche' i builder
-- 'OWPlus Outpost Engineer Builders'/'OWPlus Outpost Factory Upgrade' non
-- vengono mai selezionati per i nostri avamposti, nonostante le loro
-- BuilderConditions risultino vere quando controllate dal vivo (vedi
-- OWPlusLogConditions.lua). Aggancia AssignBuildOrder (vanilla, /lua/sim/
-- FactoryBuilderManager.lua) — il punto esatto in cui il motore decide quale
-- builder far costruire a una fabbrica, o rinuncia e ripianifica un retry a
-- 2s (DelayBuildOrder). Pattern di subclassing (non copia integrale) identico
-- a quello gia' usato da BattlePack per hook/lua/sim/weapon.lua — nessuna
-- logica vanilla duplicata, solo un log prima di richiamare l'originale.
-- Da rimuovere/silenziare una volta diagnosticato.

local prevClass = FactoryBuilderManager

FactoryBuilderManager = Class(prevClass) {
    AssignBuildOrder = function(self, factory, bType)
        if self.LocationType and self.Brain and self.Brain.OWPlusOutpostLocationTypes
            and self.Brain.OWPlusOutpostLocationTypes[self.LocationType] then
            self.OWPlusDebugLastLog = self.OWPlusDebugLastLog or {}
            local now = GetGameTimeSeconds()
            local key = 'AssignBuildOrder_' .. tostring(bType)
            if not self.OWPlusDebugLastLog[key] or now - self.OWPlusDebugLastLog[key] >= 5 then
                self.OWPlusDebugLastLog[key] = now
                local builder = self:GetHighestBuilder(bType, {factory})
                LOG('[OWPlus-HOOK] AssignBuildOrder(' .. tostring(self.LocationType) .. ', bType=' .. tostring(bType)
                    .. ') -> ' .. tostring(builder and builder.BuilderName or 'NESSUN builder trovato, retry tra 2s')
                    .. ' -- NumBuilders totali registrati su questo manager: ' .. tostring(self.NumBuilders))
            end
        end
        prevClass.AssignBuildOrder(self, factory, bType)
    end,

    -- Fix sess.77 (octies): confermato via l'hook sopra che AssignBuildOrder ORA
    -- scatta (fix precedente) ma dice "NESSUN builder trovato" nonostante builder
    -- registrati e le nostre BuilderConditions verdi — la causa deve essere
    -- BuilderParamCheck (vanilla, FactoryBuilderManager.lua), un controllo
    -- SEPARATO dalle nostre condizioni: risolve il template reale (per
    -- fazione/tier) e chiama self.Brain:CanBuildPlatoon(template, params) — un
    -- controllo economico/di validita' che non passa dalle nostre
    -- BuilderConditions. Richiama l'originale per il risultato vero (nessuna
    -- logica duplicata), poi ri-deriva SOLO il template (chiamata read-only,
    -- innocua) per capire se il problema e' "template non risolto/fazione senza
    -- questa unita'" o qualcos'altro (economia, CanBuildPlatoon).
    BuilderParamCheck = function(self, builder, params)
        local result = prevClass.BuilderParamCheck(self, builder, params)
        if not result and self.LocationType and self.Brain and self.Brain.OWPlusOutpostLocationTypes
            and self.Brain.OWPlusOutpostLocationTypes[self.LocationType]
            and builder.BuilderName and string.find(builder.BuilderName, 'OWPlus Outpost') then
            local templateInfo = 'nil'
            local ok, template = pcall(function() return self:GetFactoryTemplate(builder:GetPlatoonTemplate(), params[1]) end)
            if ok and template then
                templateInfo = 'risolto, len=' .. tostring(table.getn(template))
            elseif not ok then
                templateInfo = 'ERRORE nel risolverlo: ' .. tostring(template)
            end
            LOG('[OWPlus-HOOK] BuilderParamCheck FALSE per "' .. tostring(builder.BuilderName) .. '" a ' .. tostring(self.LocationType)
                .. ' -- GetFactoryTemplate: ' .. templateInfo)
        end
        return result
    end,
}
