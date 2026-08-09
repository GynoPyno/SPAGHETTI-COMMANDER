-- urb1401_script.lua (Cybran, generatore energia T4)
-- V1 solo funzionale (richiesta esplicita utente) -- nessuna animazione di
-- upgrade custom, eredita tutto il comportamento dalla classe base T3
-- (stessa classe da cui parte anche URB1301 nativo).
local CEnergyCreationUnit = import('/lua/cybranunits.lua').CEnergyCreationUnit

urb1401 = ClassUnit(CEnergyCreationUnit) {}

TypeClass = urb1401
