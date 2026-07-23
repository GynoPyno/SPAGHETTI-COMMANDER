"""Classificazione Pattern A ("PlaySound diretto") vs Pattern B ("canale annunciatore").

Vedi Audiowo/METODOLOGIA_AUDIO.md per la spiegazione completa. In sintesi: la stragrande
maggioranza dei campi Audio.* di un blueprint sono Pattern A (override diretto, affidabile).
Un piccolo sottoinsieme passa invece dal canale VO (aiBrain:PlayVOSound -> Sync.Voice ->
UserSync.lua:OnSync -> PlayVoice) e richiede l'hook UI invece dell'override di blueprint.

La lista sotto viene dalla tabella `VOSounds` in aibrain.lua (lua_nx2_extracted, patch FAF),
l'unico punto del codice Sim che elenca in modo esaustivo quali chiavi passano da PlayVOSound.
Di queste chiavi, solo quelle il cui valore `bank` è `nil` leggono davvero un Sound da un
campo blueprint (le altre hanno una cue XGG fissa scritta a mano, non arrivano mai da un
blueprint e quindi non compariranno comunque nello scan del catalogo).
"""
from __future__ import annotations

# Chiavi note della tabella aibrain.lua:VOSounds che leggono un Sound *dal blueprint*
# (bank = nil nella tabella originale -> il valore arriva da bp['<chiave>'], vedi
# aibrain.lua:PlayVOSound e sim/Unit.lua:NukeCreatedAtUnit per NuclearLaunchDetected).
KNOWN_PATTERN_B_FIELDS = frozenset({
    "NuclearLaunchDetected",
    "OnTransportFull",
})

PATTERN_A = "A"
PATTERN_B = "B"


def classify(field_name: str) -> str:
    """Ritorna PATTERN_B per i campi noti del canale annunciatore, PATTERN_A altrimenti.

    Attenzione: è un'euristica sul nome del campo, non una prova formale come l'analisi
    manuale del codice Sim fatta finora. Un errore di classificazione qui non produce un
    errore nei log: produce un suono vanilla sbagliato e diverso a ogni tentativo (vedi
    METODOLOGIA_AUDIO.md, Passo 0). Testare sempre in game un evento nuovo prima di fidarsene.
    """
    return PATTERN_B if field_name in KNOWN_PATTERN_B_FIELDS else PATTERN_A
