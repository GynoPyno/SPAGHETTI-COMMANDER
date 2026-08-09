-- uab1401_script.lua (Aeon, generatore energia T4)
-- V1 solo funzionale (richiesta esplicita utente) -- nessuna animazione di
-- upgrade custom, eredita tutto il comportamento dalla classe base T3
-- (stessa classe da cui parte anche UAB1301 nativo).
local AEnergyCreationUnit = import('/lua/aeonunits.lua').AEnergyCreationUnit

uab1401 = ClassUnit(AEnergyCreationUnit) {}

TypeClass = uab1401
