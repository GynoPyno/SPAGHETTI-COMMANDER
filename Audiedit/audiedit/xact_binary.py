"""Parser binario minimale dei banchi XACT2 (.xwb/.xsb).

Riformula in funzioni pulite la logica già scritta e validata sul campo negli script di
lavoro in Audiedit/prototipi/ (xwb_format.py, ab_compare.py, wave_usage.py, inspect_ours.py).
Riferimento di formato: implementazione MonoGame (AudioEngine.cs/SoundBank.cs/XactSound.cs),
citata in Audiowo/METODOLOGIA_AUDIO.md.

Non è un parser esaustivo di ogni possibile variante XACT: copre il caso comune (un solo
Play Wave Event per Sound, con o senza variante/pool), che è quello usato da tutti i banchi
vanilla e dalla mod già validati. Se una struttura non torna, solleva XactFormatError invece
di produrre dati sbagliati in silenzio — chi chiama (vanilla_audio.py, in futuro verify_bank)
decide come reagire.
"""
from __future__ import annotations

import struct
from dataclasses import dataclass
from pathlib import Path


class XactFormatError(Exception):
    """Una struttura binaria attesa non corrisponde — meglio fermarsi che indovinare."""


def _u16(d: bytes, o: int) -> int:
    return struct.unpack_from("<H", d, o)[0]


def _u32(d: bytes, o: int) -> int:
    return struct.unpack_from("<I", d, o)[0]


# ---------------------------------------------------------------------------
# .xwb (Wave Bank)
# ---------------------------------------------------------------------------

@dataclass
class WaveEntry:
    index: int
    format_tag: str   # 'PCM' | 'XMA' | 'ADPCM' | 'WMA/xWMA' | ...
    channels: int
    sample_rate: int
    bits: int
    pcm: bytes         # dati grezzi della regione PlayRegion


_FORMAT_TAGS = {0: "PCM", 1: "XMA", 2: "ADPCM", 3: "WMA/xWMA"}


def read_wave_bank(path: Path) -> list[WaveEntry]:
    d = path.read_bytes()
    if d[:4] != b"WBND":
        raise XactFormatError(f"{path}: non è un Wave Bank XACT (magic {d[:4]!r})")

    off = 12
    segs = []
    for _ in range(5):
        so, sl = struct.unpack_from("<II", d, off)
        off += 8
        segs.append((so, sl))
    bank_data_off = segs[0][0]
    entry_meta_off = segs[1][0]
    wave_data_off = segs[4][0]

    _flags, entry_count = struct.unpack_from("<II", d, bank_data_off)
    meta_elem_size, = struct.unpack_from("<I", d, bank_data_off + 8 + 64)

    entries: list[WaveEntry] = []
    for i in range(entry_count):
        base = entry_meta_off + i * meta_elem_size
        _flags_dur, fmt = struct.unpack_from("<II", d, base)
        play_off, play_len = struct.unpack_from("<II", d, base + 8)
        tag = fmt & 0x3
        channels = (fmt >> 2) & 0x7
        rate = (fmt >> 5) & 0x3FFFF
        bits = 16 if (fmt >> 31) & 0x1 else 8
        pcm = d[wave_data_off + play_off: wave_data_off + play_off + play_len]
        entries.append(WaveEntry(
            index=i,
            format_tag=_FORMAT_TAGS.get(tag, str(tag)),
            channels=channels,
            sample_rate=rate,
            bits=bits,
            pcm=pcm,
        ))
    return entries


def pcm_to_wav_bytes(entry: WaveEntry) -> bytes:
    """Incapsula i campioni PCM grezzi di una WaveEntry in un .wav valido (solo header RIFF)."""
    if entry.format_tag != "PCM":
        raise XactFormatError(
            f"onda #{entry.index}: formato {entry.format_tag} non supportato "
            "per l'anteprima (serve PCM)"
        )
    channels = entry.channels
    rate = entry.sample_rate
    bits = entry.bits
    block_align = channels * bits // 8
    byte_rate = rate * block_align
    data = entry.pcm
    header = b"RIFF" + struct.pack("<I", 36 + len(data)) + b"WAVE"
    fmt_chunk = b"fmt " + struct.pack(
        "<IHHIIHH", 16, 1, channels, rate, byte_rate, block_align, bits
    )
    data_chunk = b"data" + struct.pack("<I", len(data)) + data
    return header + fmt_chunk + data_chunk


# ---------------------------------------------------------------------------
# .xsb (Sound Bank)
# ---------------------------------------------------------------------------

def _cue_names(d: bytes, cue_names_off: int) -> list[str]:
    return [x.decode("ascii", "replace") for x in d[cue_names_off:].split(b"\x00") if x]


def find_sound_offset(d: bytes, cue: str) -> int:
    """Trova l'offset del record Sound corrispondente a una cue, dato il .xsb già letto in bytes."""
    num_simple = _u16(d, 19)
    num_complex = _u16(d, 21)
    simple_off = _u32(d, 34)
    complex_off = _u32(d, 38)
    cue_names_off = _u32(d, 42)
    sounds_off = _u32(d, 70)

    names = _cue_names(d, cue_names_off)
    if cue not in names:
        raise XactFormatError(f"cue '{cue}' non trovata in questo banco (prime 12: {names[:12]})")
    idx = names.index(cue)

    # fine della regione dei sound: il primo altro offset di header maggiore di sounds_off
    others = [_u32(d, 34 + 4 * i) for i in range(10)]
    after = [v for v in others if v not in (0xFFFFFFFF, sounds_off) and v > sounds_off]
    sounds_end = min(after) if after else len(d)

    def looks_like_sound(so: int) -> bool:
        return sounds_off <= so < sounds_end and (d[so] & 0x01) == 0x01

    entries = [_u32(d, simple_off + 5 * k + 1) for k in range(num_simple)]
    if num_complex and complex_off not in (0xFFFFFFFF,):
        record_size = None
        for candidate in range(8, 33):
            if complex_off + candidate * num_complex > len(d):
                continue
            offsets = [_u32(d, complex_off + candidate * k + 1) for k in range(num_complex)]
            if all(looks_like_sound(so) for so in offsets):
                record_size = candidate
                break
        if record_size is None:
            raise XactFormatError("non trovo la dimensione del record complex per questo banco")
        entries += [_u32(d, complex_off + record_size * k + 1) for k in range(num_complex)]

    if idx >= len(entries):
        raise XactFormatError(f"indice cue {idx} fuori dalla tabella ({len(entries)} voci)")
    return entries[idx]


def wave_indices_of_sound(d: bytes, sound_offset: int) -> list[int]:
    """Indici delle onde (varianti incluse) usate da un Sound — vedi prototipi/wave_usage.py.

    Questa decodifica è stata reverse-engineered su suoni "a pool" (più varianti pesate,
    es. gli impatti) ed è quella che serve per il caso d'uso principale (confrontare un
    impatto/arma vanilla col proprio sostituto). Non copre ogni possibile struttura clip
    XACT: un suono semplice a singola onda senza pool può avere un layout diverso e far
    fallire i controlli sotto. In quel caso si solleva XactFormatError invece di leggere
    byte a caso — chi chiama (vanilla_audio.py) lo mostra come "anteprima non disponibile".
    """
    try:
        flags = d[sound_offset]
        q = sound_offset + 9
        _nclips = d[q]
        q += 1
        if flags & 0x0E:
            q += _u16(d, q)  # salta il blocco RPC (lunghezza in testa)
        if flags & 0x10:
            q += 7  # salta il blocco DSP
        q += 1  # clip volume
        clip = _u32(d, q)
        q += 4
        if clip != q:
            raise XactFormatError(
                f"struttura clip inattesa a offset {sound_offset} (clip={clip}, atteso {q})"
            )
        p = q + 9 + 12
        count = _u16(d, p)
        p += 2
        p += 2 + 4  # u16 sconosciuto + sentinella 0xFFFFFFFF
        if p + 5 * count > len(d):
            raise XactFormatError(
                f"tabella varianti fuori dal file per il sound a offset {sound_offset} "
                f"(struttura clip probabilmente diversa, es. onda singola senza pool)"
            )
        out = [_u16(d, p + 5 * k) for k in range(count)]
    except struct.error as exc:
        raise XactFormatError(f"lettura fuori dai limiti per il sound a offset {sound_offset}") from exc
    if not out:
        raise XactFormatError(f"nessuna onda trovata per il sound a offset {sound_offset}")
    return out
