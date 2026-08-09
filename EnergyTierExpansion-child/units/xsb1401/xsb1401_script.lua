-- xsb1401_script.lua (Seraphim, generatore energia T4)
-- V1 solo funzionale (richiesta esplicita utente) -- nessuna animazione di
-- upgrade custom, eredita tutto il comportamento dalla classe base T3
-- (stessa classe da cui parte anche XSB1301 nativo).
local SEnergyCreationUnit = import('/lua/seraphimunits.lua').SEnergyCreationUnit

xsb1401 = ClassUnit(SEnergyCreationUnit) {}

TypeClass = xsb1401
