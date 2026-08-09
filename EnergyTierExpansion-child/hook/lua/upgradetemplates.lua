-- Sess.98 (bis, indagine dedicata): registra il path di upgrade T3->T4
-- ueb1301/uab1301/urb1301/xsb1301 -> ueb1401/uab1401/urb1401/xsb1401 nella
-- tabella nativa StructureUpgradeTemplates.
--
-- Causa del blocco: Economy.BuildableCategory + General.UpgradesTo sul
-- blueprint bastano per far funzionare CanBuild() (upgrade manuale da
-- giocatore umano, confermato in game), ma l'AI (nativo UnitUpgradeAI e
-- la copia custom in AI-Uveso-child/hook/lua/platoon.lua) risolve l'ID di
-- destinazione tramite aiBrain:FindUpgradeBP(), che cerca in QUESTA tabella
-- separata -- mai popolata per queste 4 unita' -- non nel blueprint. Log
-- osservato ripetuto per ~13 minuti con gate economico vero e 25-30
-- candidati disponibili: "Can't find StructureUpgradeTemplate for
-- structure: ueb1301". Pattern di fix verificato leggendo
-- TotalMayhem/hook/lua/upgradetemplates.lua (mod matura, stesso identico
-- meccanismo table.insert su file hookato per path generico motore).
--
-- Indice fazione (verificato su /lua/upgradetemplates.lua nativo estratto):
-- 1=UEF, 2=Aeon, 3=Cybran, 4=Seraphim.
LOG('[EnergyTierExpansion] upgradetemplates.lua: OK, registro upgrade T3->T4 generatori energia in StructureUpgradeTemplates')
table.insert(StructureUpgradeTemplates[1], {'ueb1301', 'ueb1401'}) -- UEF
table.insert(StructureUpgradeTemplates[2], {'uab1301', 'uab1401'}) -- Aeon
table.insert(StructureUpgradeTemplates[3], {'urb1301', 'urb1401'}) -- Cybran
table.insert(StructureUpgradeTemplates[4], {'xsb1301', 'xsb1401'}) -- Seraphim
