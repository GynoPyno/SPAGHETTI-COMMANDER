-- Sess.98 (bis): registra i path di upgrade mancanti in Jaggeds Infrastructure
-- Pack nella tabella nativa StructureUpgradeTemplates. Verificato leggendo
-- Jaggeds_Infrastructure_Pack/hook/units/*.bp: Jaggeds imposta GIA' da solo
-- Economy.BuildableCategory + General.UpgradesTo per estrattori, magazzini
-- massa ed energia (T1->T2->T3, tutte le fazioni) -- quindi CanBuild()
-- funziona (upgrade manuale da giocatore umano ok). MA non registra MAI
-- questi path in StructureUpgradeTemplates -- tabella separata, usata solo
-- da aiBrain:FindUpgradeBP() (l'AI, non il click umano). Senza questa entry
-- l'AI non trova mai l'ID di destinazione, anche se CanBuild sarebbe vero.
-- Confermato dal log ripetuto "Can't find StructureUpgradeTemplate for
-- structure: ueb1106/ueb1302" nonostante 56 magazzini T1 e centinaia di
-- estrattori T3 disponibili. Stesso meccanismo gia' risolto per il
-- generatore energia T4 (mod nostra) in
-- EnergyTierExpansion-child/hook/lua/upgradetemplates.lua.
--
-- Nessun file .bp aggiuntivo necessario qui (a differenza del tentativo
-- iniziale con units/ueb1302/*): Jaggeds fornisce gia' tutto, un nostro
-- BuildableCategory/UpgradesTo duplicato avrebbe solo rischiato di
-- sovrascrivere silenziosamente il BuildRate di Jaggeds (50) col nostro (20).
--
-- Indice fazione (verificato su /lua/upgradetemplates.lua nativo estratto):
-- 1=UEF, 2=Aeon, 3=Cybran, 4=Seraphim.
LOG('[AI-Uveso-child] upgradetemplates.lua: OK, registro upgrade path mancanti Jaggeds (estrattori + magazzini massa/energia) in StructureUpgradeTemplates')

-- Estrattori massa T3->T4 (unita' sperimentale ueb1402 & co.)
table.insert(StructureUpgradeTemplates[1], {'ueb1302', 'ueb1402'}) -- UEF
table.insert(StructureUpgradeTemplates[2], {'uab1302', 'uab1402'}) -- Aeon
table.insert(StructureUpgradeTemplates[3], {'urb1302', 'urb1402'}) -- Cybran
table.insert(StructureUpgradeTemplates[4], {'xsb1302', 'xsb1402'}) -- Seraphim

-- Magazzini massa T1->T2->T3 (catena propria Jaggeds euebmst2/3 & co.)
table.insert(StructureUpgradeTemplates[1], {'ueb1106', 'euebmst2'})
table.insert(StructureUpgradeTemplates[1], {'euebmst2', 'euebmst3'})
table.insert(StructureUpgradeTemplates[2], {'uab1106', 'euabmst2'})
table.insert(StructureUpgradeTemplates[2], {'euabmst2', 'euabmst3'})
table.insert(StructureUpgradeTemplates[3], {'urb1106', 'eurbmst2'})
table.insert(StructureUpgradeTemplates[3], {'eurbmst2', 'eurbmst3'})
table.insert(StructureUpgradeTemplates[4], {'xsb1106', 'exsbmst2'})
table.insert(StructureUpgradeTemplates[4], {'exsbmst2', 'exsbmst3'})

-- Magazzini energia T1->T2->T3 (catena propria Jaggeds euebest2/3 & co.)
table.insert(StructureUpgradeTemplates[1], {'ueb1105', 'euebest2'})
table.insert(StructureUpgradeTemplates[1], {'euebest2', 'euebest3'})
table.insert(StructureUpgradeTemplates[2], {'uab1105', 'euabest2'})
table.insert(StructureUpgradeTemplates[2], {'euabest2', 'euabest3'})
table.insert(StructureUpgradeTemplates[3], {'urb1105', 'eurbest2'})
table.insert(StructureUpgradeTemplates[3], {'eurbest2', 'eurbest3'})
table.insert(StructureUpgradeTemplates[4], {'xsb1105', 'exsbest2'})
table.insert(StructureUpgradeTemplates[4], {'exsbest2', 'exsbest3'})

-- Magazzino ibrido Massa+Energia T4 (bab1106/beb1106/brb1106/bsb1106), ultimo
-- gradino della catena magazzini massa -- builder gia' esistente da sess.97
-- ('OWPlus Mass Storage Upgrade T4') ma mai completato dall'AI per lo stesso
-- identico motivo (commento originale: "funzionava solo se avviato a mano
-- dal giocatore" -- causa mai isolata prima d'ora).
table.insert(StructureUpgradeTemplates[1], {'euebmst3', 'beb1106'})
table.insert(StructureUpgradeTemplates[2], {'euabmst3', 'bab1106'})
table.insert(StructureUpgradeTemplates[3], {'eurbmst3', 'brb1106'})
table.insert(StructureUpgradeTemplates[4], {'exsbmst3', 'bsb1106'})
