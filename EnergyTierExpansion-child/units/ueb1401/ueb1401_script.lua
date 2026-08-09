-- ueb1401_script.lua (UEF, generatore energia T4)
-- V1 solo funzionale (richiesta esplicita utente) -- nessuna animazione di
-- upgrade custom, eredita tutto il comportamento dalla classe base T3
-- (stessa classe da cui parte anche UEB1301 nativo).
local TEnergyCreationUnit = import('/lua/terranunits.lua').TEnergyCreationUnit

ueb1401 = ClassUnit(TEnergyCreationUnit) {}

TypeClass = ueb1401
